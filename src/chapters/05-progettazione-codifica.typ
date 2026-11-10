#import "shared.typ": *

#show: code-style

#pagebreak()

= Progettazione e codifica <progettazione-codifica>
\
Il firmware è stato sviluppato per supportare due distinte varianti hardware basate su microcontrollore ESP32-S3: una configurazione dotata di display rotondo da 1,75 pollici e una versione equipaggiata con uno schermo da 1,8 pollici. Sebbene le due varianti condividano i moduli logici per la gestione dei dati e della connettività di rete, presentano implementazioni differenziate per quanto concerne i driver del display, la gestione del touch screen e le relative modalità di navigazione dell'interfaccia.
\
Al fine di garantire una trattazione organica e strutturata, il capitolo ripercorre il flusso logico ed elaborativo del sistema: si procede inizialmente con l'analisi della fase di avvio e della modularità del firmware, per poi approfondire i meccanismi di comunicazione con il CRM e la persistenza locale dei dati, concludendo con la descrizione delle interfacce dedicate alla consultazione e alla configurazione del sistema. Gli stralci di codice sorgente inclusi nel testo provengono dai progetti sviluppati; essi sono stati opportunamente sintetizzati ove necessario e depurati da informazioni sensibili o credenziali di autenticazione.
\
== Struttura del firmware <struttura-firmware>
\
L'architettura del software adotta un approccio modulare volto a disaccoppiare la gestione dell'hardware di I/O (display AMOLED e touch screen capacitivo) dai servizi di rete, dal server HTTP locale e dall'interazione in tempo reale con la piattaforma cloud RelAi. Le responsabilità del sistema sono ripartite nei seguenti moduli sorgente:
\
- *`main.cpp`*: punto d'ingresso principale, gestisce l'avvio delle periferiche e la pianificazione dei task FreeRTOS sui due core dell'ESP32-S3.
- *`display_config.cpp`*: gestisce l'inizializzazione del display AMOLED e del touch screen con implementazioni differenziate per le due varianti hardware (display rotondo da 1,75 pollici e schermo da 1,8 pollici), configurando il bus QSPI, i relativi controller I²C della famiglia CST e l'allocazione dei buffer grafici in PSRAM per il motore LVGL.
- *`interfaccia_ui.cpp`*: implementa la costruzione delle schermate dinamiche degli eventi adattate alle specifiche geometriche e di navigazione delle due varianti hardware (layout circolare vs rettangolare), la generazione dei QR code, la decodifica delle immagini PNG del logo tramite lodepng e la gestione delle modali di diagnostica e del menu.
- *`wifi_conessione.cpp`*: configura la connettività di rete in modalità duale AP+STA, il server HTTP locale (WebServer), il captive portal DNS e la gestione del file system LittleFS.
- *`api.cpp`*: governa la comunicazione bidirezionale con il CRM RelAi (heartbeat periodico, client WebSocket, sincronizzazione della cache eventi nella memoria flash non volatile NVS, scaricamento del logo e aggiornamento OTA).
\
== Backend: avvio, task e accesso condiviso <backend-task>
\
La funzione `setup()` all'interno di `main.cpp` inizializza la seriale, il server locale, il display e LVGL, creando successivamente due task FreeRTOS dedicati e associati ai rispettivi core (@fig:setup). I task sono creati con priorità 1 per la rete e 2 per il display:
\
#figure(
  ```cpp
  void setup() {
    Serial.begin(115200);
    delay(1000);

    Serial.println("\n--- Avvio ESP32-S3 ---");

    inizializza_sistema_reti();

    init_display_touch_lvgl();
    ui_load_cached_data();

    xTaskCreatePinnedToCore(networkTask, "NetworkTask", 24576, NULL, 1,
                            &NetworkTaskHandle, 0);
    xTaskCreatePinnedToCore(displayTask, "DisplayTask", 16384, NULL, 2,
                            &DisplayTaskHandle, 1);

    Serial.println("[SYSTEM] Avvio completato.");
  }
  ```,
  caption: [Funzione `setup()` dell'ESP32-S3],
) <fig:setup>
\
- *`NetworkTask` (Core 0, priorità 1)*: gestisce il provisioning Wi-Fi, il server web permanente, le richieste HTTP, il client WebSocket con il CRM, il download del logo dell'organizzazione e la segnalazione all'utente di eventuali perdite di connettività.
- *`DisplayTask` (Core 1, priorità 2)*: esegue ciclicamente il rendering grafico e la gestione degli input tramite LVGL. La priorità numerica più alta assegna a questo task una precedenza maggiore rispetto al task di rete, senza costituire una garanzia assoluta di fluidità in presenza di operazioni bloccanti.
\
Poiché le risorse di LVGL non sono thread-safe, le operazioni grafiche sono protette mediante l'utilizzo del mutex lvgl_mutex, creato in init_display_touch_lvgl(). Il task del display acquisisce il semaforo prima di invocare l'handler dei timer grafici e ne limita il tempo di attesa tra 1 e 10 ms (@fig:display-task):
\
#figure(
  ```cpp
  void displayTask(void *pvParameters) {
    if (xSemaphoreTake(lvgl_mutex, portMAX_DELAY)) {
      create_tileview();
      xSemaphoreGive(lvgl_mutex);
    }

    while (true) {
      uint32_t time_till_next = 5;

      if (xSemaphoreTake(lvgl_mutex, pdMS_TO_TICKS(10))) {
        time_till_next = lv_timer_handler();
        xSemaphoreGive(lvgl_mutex);
      }

      if (time_till_next < 1) time_till_next = 1;
      if (time_till_next > 10) time_till_next = 10;

      vTaskDelay(pdMS_TO_TICKS(time_till_next));
    }
  }
  ```,
  caption: [Ciclo principale del task di rendering],
) <fig:display-task>
\
Anche il `NetworkTask` utilizza lo stesso mutex ogni volta che deve interagire con l'interfaccia: aggiornamento delle etichette di stato ogni secondo, apertura e chiusura del messaggio di errore di rete (mostrato quando la connessione al router risulta assente da oltre 15 secondi, se è presente una rete salvata) e ricostruzione delle schermate. Quest'ultima avviene tramite un meccanismo a flag: i moduli che ricevono nuovi dati dal CRM invocano `ui_richiedi_ricarica_tileview()`, mentre il `NetworkTask` verifica periodicamente il flag con `ui_consuma_richiesta_ricarica()` e, se attivo, richiama `create_tileview()` mantenendo il mutex. In questo modo i thread di rete non manipolano mai direttamente gli oggetti grafici senza sincronizzazione.
\
== Backend: provisioning Wi-Fi e server locale <backend-wifi>
\
All'avvio del `NetworkTask`, il dispositivo attiva la modalità `WIFI_AP_STA`, avviando contemporaneamente un Access Point locale (`ESP32-Config`, IP `192.168.4.1`) e il tentativo di connessione alla rete station eventualmente salvata nelle `Preferences`. Un server DNS locale (`DNSServer`) risponde a qualsiasi dominio con l'indirizzo dell'Access Point, così da reindirizzare le richieste dei client verso il portale captive (@fig:provisioning). L'Access Point rimane attivo in modo permanente, anche a connessione STA avvenuta, in modo da consentire in qualsiasi momento la riconfigurazione del dispositivo.
\
#figure(
  ```cpp
  void avvia_wifi_provisioning() {
    server.stop();
    dnsServer.stop();

    WiFi.mode(WIFI_AP_STA);
    WiFi.setAutoReconnect(true);
    WiFi.setSleep(false);

    WiFi.softAPConfig(AP_IP, AP_IP, IPAddress(255, 255, 255, 0));
    if (!WiFi.softAP(AP_SSID, AP_PASS)) {
      Serial.println("[Wi-Fi AP] ERRORE: avvio Access Point fallito!");
    }
    dnsServer.start(DNS_PORT, "*", AP_IP);
    ...
  }
  ```,
  caption: [Avvio dell'Access Point e del DNS captive (versione sintetizzata)],
) <fig:provisioning>
\
Le richieste il cui header `Host` non coincide con l'indirizzo dell'Access Point vengono ridirezionate con una risposta HTTP 302 verso `http://192.168.4.1/`; le URL di verifica della connettività dei sistemi operativi (ad esempio `generate_204`) ricevono invece una risposta 204. I file statici del portale sono letti da LittleFS, con supporto ai file compressi `.gz` serviti con l'header `Content-Encoding: gzip`.
\
Il server HTTP espone endpoint REST dedicati alla gestione e alla manutenzione del sistema, registrati in `inizializza_sistema_reti()` (@fig:routes). Tra questi, `/scan` esegue la scansione asincrona delle reti disponibili, `/connect` verifica le credenziali ricevute tentando la connessione STA e le salva in caso di successo, `/status` restituisce lo stato corrente in formato JSON, mentre `/reset_wifi`, `/reboot` e `/reset_factory` consentono rispettivamente la cancellazione delle credenziali, il riavvio e il ripristino di fabbrica. La funzione `inizializza_api()` aggiunge infine l'endpoint `/api/events`, che restituisce la cache locale degli eventi.
\
#figure(
  ```cpp
  void inizializza_sistema_reti() {
    if (!LittleFS.begin(true)) {
      Serial.println("[LittleFS] ERRORE: Montaggio fallito!");
    } else {
      Serial.println("[LittleFS] File system montato correttamente.");
    }

    server.on("/", HTTP_GET, handle_root);
    server.on("/scan", HTTP_GET, handle_scan);
    inizializza_api(server);

    server.on("/status", HTTP_GET, handle_get_status);
    server.on("/connect", HTTP_POST, handle_connect);
    server.on("/reset_wifi", HTTP_POST, handle_reset_wifi);
    server.on("/reboot", HTTP_POST, handle_reboot);
    server.on("/reset_factory", HTTP_POST, handle_reset_factory);
    server.onNotFound(handle_not_found);
  }
  ```,
  caption: [Registrazione degli endpoint del server HTTP locale],
) <fig:routes>
\
La scansione delle reti è avviata in modalità asincrona. Il firmware disconnette temporaneamente la STA solo se non è già connessa; in tal caso, al termine della scansione tenta di ripristinare il collegamento usando le credenziali salvate. Il server viene gestito dal `NetworkTask` tramite `gestisci_wifi_prov()`, che elabora le richieste DNS e HTTP e invoca la gestione periodica del client WebSocket e dell'heartbeat.
\
== Backend: sincronizzazione con RelAi <backend-relai>

=== Heartbeat e telemetria
\
Il dispositivo invia periodicamente richieste HTTP POST (heartbeat) all'endpoint del CRM, autenticandosi con un token Bearer e trasmettendo dati di telemetria quali uptime, memoria heap libera e intensità del segnale RSSI (@fig:heartbeat). Il client TLS è condiviso tra heartbeat e autenticazione dei canali WebSocket, per riutilizzare la connessione (keep-alive) e ridurre il consumo di memoria.
\
#figure(
  ```cpp
  static bool esegui_heartbeat() {
    WiFiClientSecure &client = https_client();
    HTTPClient http;
    http.setReuse(true);

    if (!http.begin(client, HEARTBEAT_URL)) {
      return false;
    }

    http.setConnectTimeout(3000);
    http.setTimeout(5000);
    http.addHeader("Authorization", String("Bearer ") + API_TOKEN);
    http.addHeader("Content-Type", "application/json");

    JsonDocument doc;
    doc["mac_address"] = DEVICE_MAC;
    doc["type"] = DEVICE_TYPE;
    doc["software_version"] = get_current_firmware_version();
    doc["connection_type"] = "wifi";

    JsonObject telemetry = doc["telemetry"].to<JsonObject>();
    telemetry["uptime_seconds"] = millis() / 1000;
    telemetry["free_heap_bytes"] = ESP.getFreeHeap();
    telemetry["wifi_rssi"] = WiFi.RSSI();

    String requestBody;
    serializeJson(doc, requestBody);

    int code = http.POST(requestBody);
    ...
  }
  ```,
  caption: [Invio dell'heartbeat con telemetria (versione sintetizzata)],
) <fig:heartbeat>
\
La risposta del server contiene l'intervallo del prossimo heartbeat (limitato a un valore compreso tra 10 e 300 secondi, con default di 30), eventuali comandi da eseguire, le impostazioni di visualizzazione (intervallo di rotazione delle schermate, minimo 5 secondi) e l'elenco degli eventi. In caso di errore, il tentativo viene ripetuto dopo 15 secondi. La scadenza dei timer è calcolata con un confronto su differenza a 32 bit (`scaduto()`), che rimane corretto anche all'overflow del contatore `millis()`.
\
=== Cache degli eventi e persistenza
\
Gli eventi ricevuti (al massimo dieci, ciascuno con identificativo, nome, link per il QR code, numero di prenotazioni e di partecipanti) vengono confrontati con quelli già in memoria: solo se differiscono la cache RAM viene aggiornata e il contenuto è scritto nella memoria NVS tramite la libreria `Preferences`, limitando così le scritture sulla flash. Le chiavi relative a posizioni non più utilizzate vengono rimosse, e al termine viene richiesta la ricostruzione dell'interfaccia (@fig:salva-eventi).
\
#figure(
  ```cpp
  static void salva_eventi(JsonArray events, const char *origine) {
    std::vector<ApiEvent> nuovi;
    for (JsonObject ev : events) {
      if (nuovi.size() >= MAX_EVENTS) break;
      ApiEvent c;
      c.id = ev["id"] | 0L;
      c.name = ev["name"] | "";
      c.qr = ev["qr"] | "";
      c.reservations = ev["reservations"] | 0;
      c.participants = ev["participants"] | 0;
      nuovi.push_back(c);
    }

    bool uguale = (nuovi.size() == events_cache.size());
    for (size_t i = 0; uguale && i < nuovi.size(); ++i) {
      uguale = eventi_uguali(nuovi[i], events_cache[i]);
    }
    if (uguale) return;

    events_cache = nuovi;

    Preferences prefs;
    prefs.begin("api-cache", false);
    for (size_t i = 0; i < MAX_EVENTS; ++i) {
      char kId[16], kName[16], kQr[16], kPart[16], kPartic[16];
      snprintf(kId, sizeof(kId), "ev_id_%u", (unsigned)i);
      snprintf(kName, sizeof(kName), "ev_name_%u", (unsigned)i);
      ...
      if (i < events_cache.size()) {
        prefs.putLong(kId, events_cache[i].id);
        prefs.putString(kName, events_cache[i].name);
        ...
      } else {
        if (prefs.isKey(kId)) prefs.remove(kId);
        ...
      }
    }
    prefs.end();
    ui_richiedi_ricarica_tileview();
  }
  ```,
  caption: [Aggiornamento e salvataggio persistente degli eventi (versione sintetizzata)],
) <fig:salva-eventi>
\
Alla lettura (`api_get_cached_events()`), se la cache in RAM è vuota — ad esempio dopo un riavvio — gli eventi vengono ricostruiti dalla NVS. Il dispositivo è quindi in grado di mostrare gli ultimi dati noti anche in assenza di connettività. Per questo motivo la funzione `ui_load_cached_data()` invocata in `setup()` non deve eseguire alcuna operazione: il caricamento avviene in modo differito alla prima costruzione delle schermate.
\
=== WebSocket e comandi remoti
\
Oltre al polling periodico, il dispositivo stabilisce una connessione WebSocket persistente, i cui parametri (host, porta, chiave applicativa e canali) sono comunicati dal CRM nella risposta all'heartbeat. Il protocollo utilizzato è compatibile con Pusher: dopo l'handshake `pusher:connection_established` il client si iscrive a due canali, uno specifico del dispositivo e uno dell'organizzazione. Per i canali privati, la sottoscrizione richiede un token ottenuto con una richiesta POST all'endpoint `/broadcasting/auth`. Il client risponde ai messaggi `pusher:ping`, effettua la riconnessione automatica ogni 5 secondi e utilizza un heartbeat applicativo di 15 secondi.
\
Attraverso questo canale, e analogamente tramite il campo `commands` della risposta all'heartbeat, il CRM può inviare comandi remoti gestiti da `esegui_comando_remoto()`:
\
- `restart`: riavvio del dispositivo;
- `reset`: cancellazione delle credenziali Wi-Fi, delle impostazioni e della cache eventi, seguita dal riavvio; il logo salvato in LittleFS non viene eliminato da questo comando;
- `shutdown`: spegnimento del display e del Wi-Fi e ingresso in deep sleep;
- `ota`: aggiornamento del firmware a partire dall'URL indicato nel comando (`firmware_url`).
\
L'aggiornamento OTA è eseguito con `httpUpdate` usando un client Wi-Fi non cifrato. La funzione tenta di acquisire il mutex LVGL con un timeout di cinque secondi; se non riesce, procede comunque con il download, quindi la sospensione del rendering non è garantita in ogni situazione. In caso di aggiornamento riuscito il dispositivo viene riavviato.
\
Gli stessi messaggi WebSocket possono inoltre contenere un blocco `settings` o un elenco `events`, che vengono elaborati con le stesse funzioni dell'heartbeat, consentendo l'aggiornamento immediato del display quando i dati cambiano sul CRM.
\
=== Logo dell'organizzazione
\
Il `NetworkTask` scarica il logo dell'organizzazione fuori dal mutex LVGL, con un tentativo ogni 30 secondi finché non riesce, in modo da non bloccare l'interfaccia. Il server può restituire direttamente un file PNG oppure una sua codifica esadecimale incapsulata in JSON. In entrambi i casi il contenuto è validato (firma PNG, dimensioni massime 1024 × 1024 pixel e 1 MB) e salvato in LittleFS nel file `/logo.png`, così da essere disponibile anche dopo un riavvio.
\
== Frontend sul display: LVGL <frontend-lvgl>
\
L'interfaccia grafica si appoggia sui driver hardware del display AMOLED e del touch screen capacitivo configurati in `display_config.cpp`. La funzione `init_display_touch_lvgl()` avvia il display, inizializza il touch, alloca due buffer di rendering in PSRAM (la memoria viene verificata e, se non disponibile, il firmware si arresta) e configura LVGL 9 in modalità di rendering parziale a doppio buffer con formato colore RGB565. Un timer hardware incrementa il tick di LVGL ogni 2 ms, mentre un callback di arrotondamento (`rounder_cb`) forza le aree invalidate ad avere coordinate iniziali pari e finali dispari, come richiesto dal controller CO5300 (@fig:init-display).
\
#figure(
  ```cpp
  void init_display_touch_lvgl() {
    gfx->begin(80000000);
    ((Arduino_CO5300 *)gfx)->setBrightness(255);
    gfx->fillScreen(RGB565_BLACK);

    init_touch();
    lv_init();

    uint32_t buffer_pixels = LCD_WIDTH * (LCD_HEIGHT / 2);
    buf1 = (uint16_t *)heap_caps_aligned_alloc(64, buffer_pixels * sizeof(uint16_t),
                                               MALLOC_CAP_SPIRAM | MALLOC_CAP_8BIT);
    buf2 = (uint16_t *)heap_caps_aligned_alloc(64, buffer_pixels * sizeof(uint16_t),
                                               MALLOC_CAP_SPIRAM | MALLOC_CAP_8BIT);

    display = lv_display_create(screenWidth, screenHeight);
    lv_display_set_color_format(display, LV_COLOR_FORMAT_RGB565);
    lv_display_set_buffers(display, buf1, buf2, buffer_pixels * sizeof(uint16_t),
                           LV_DISPLAY_RENDER_MODE_PARTIAL);

    lv_display_set_flush_cb(display, my_flush_cb);
    lv_display_add_event_cb(display, rounder_cb, LV_EVENT_INVALIDATE_AREA, NULL);
    ...
  }
  ```,
  caption: [Inizializzazione di display, touch e LVGL (versione sintetizzata)],
) <fig:init-display>
\
Le due varianti hardware differiscono nella configurazione del touch e nei parametri del display. Nella variante da 1,75 pollici il touch è gestito dalla libreria `TouchDrvCSTXXX` con un controller della famiglia CST92xx; le coordinate sono adattate all'orientamento tramite le costanti `TOUCH_INVERT_X`, `TOUCH_INVERT_Y` e `TOUCH_SWAP_XY`. Nella variante da 1,8 pollici il controller CST820 è gestito tramite il driver della famiglia CST816x, collegato via I²C; il display usa il bus QSPI a 40 MHz e buffer alti un decimo dello schermo. L'avvio del pannello passa inoltre da un expander I/O; per il touch sono presenti sia un tentativo di disabilitare l'autosleep sia un debounce di 50 ms sul rilascio (@fig:touch).
\
#figure(
  ```cpp
  static void my_touchpad_read(lv_indev_t *indev, lv_indev_data_t *data) {
    static int32_t lastX = 0, lastY = 0;
    static bool pressed = false;
    static uint32_t last_finger_ms = 0;

    int32_t fingers = CST820->IIC_Read_Device_Value(
        CST820->Arduino_IIC_Touch::Value_Information::TOUCH_FINGER_NUMBER);

    if (fingers > 0) {
      lastX = CST820->IIC_Read_Device_Value(
          CST820->Arduino_IIC_Touch::Value_Information::TOUCH_COORDINATE_X);
      lastY = CST820->IIC_Read_Device_Value(
          CST820->Arduino_IIC_Touch::Value_Information::TOUCH_COORDINATE_Y);
      pressed = true;
      last_finger_ms = millis();
    } else if (pressed && (millis() - last_finger_ms) > TOUCH_RELEASE_DEBOUNCE_MS) {
      pressed = false;
    }

    CST820->IIC_Interrupt_Flag = false;
    data->state = pressed ? LV_INDEV_STATE_PRESSED : LV_INDEV_STATE_RELEASED;
    data->point.x = lastX;
    data->point.y = lastY;
  }
  ```,
  caption: [Lettura del touch con debounce nella variante con controller CST820],
) <fig:touch>
\
=== Struttura e navigazione delle schermate
\
La funzione `create_tileview()` costruisce dinamicamente l'insieme delle schermate a partire dalla cache degli eventi: una schermata per ciascun evento attivo, una schermata fissa con il logo dell'organizzazione e una schermata fissa di menu e diagnostica. Se non è disponibile alcun evento, viene mostrato un segnaposto ("In attesa di eventi Cloud...").
\
Ogni schermata evento contiene un `tileview` a due tile: la prima riporta identificativo, nome, numero di prenotazioni e di partecipanti, mentre la seconda, raggiungibile con uno scorrimento orizzontale, mostra il QR code generato dal modulo `lv_qrcode` di LVGL a partire dal link ricevuto dal CRM. La schermata del logo decodifica il file PNG con `lodepng`, converte i pixel da RGBA a RGB565 e li fornisce a LVGL tramite un descrittore d'immagine; se il logo non è disponibile compare un messaggio di cortesia.
\
La navigazione tra le schermate avviene in due modi. Una rotazione automatica, la cui cadenza è fornita dal CRM (30 secondi di default), avanza ciclicamente le schermate con un'animazione di transizione. In alternativa, due pulsanti fissi, collocati su un livello sovrapposto (`lv_layer_top`), permettono di scorrere manualmente in avanti e indietro. Un triplo tocco entro 1,5 secondi attiva o disattiva la rotazione automatica, e lo stato viene segnalato da un alone luminoso sui pulsanti. Un flag di animazione in corso impedisce cambi di schermata concorrenti.
\
La schermata di menu consente di visualizzare lo stato della rete, l'SSID quando connesso e la versione del firmware, mostrare i QR code per accedere al portale di configurazione o condividere la rete corrente, ed eseguire operazioni locali di manutenzione. La voce visualizzata come “Ultima sincronizzazione” rappresenta in realtà il tempo trascorso dall'ultima disconnessione Wi-Fi, non l'istante dell'ultima sincronizzazione con il CRM.
\
== Frontend web: configurazione e diagnostica <frontend-web>
\
Il portale web di configurazione sfrutta file statici salvati su LittleFS e serviti dal server HTTP integrato. Le pagine eseguono chiamate asincrone per aggiornare periodicamente le etichette di diagnostica e inviare comandi di configurazione Wi-Fi senza richiedere una connessione a Internet esterna. Per consentire alle pagine di riallinearsi dopo un cambio di stato, l'endpoint `/status` restituisce anche un contatore (`state_epoch`) incrementato a ogni modifica della configurazione Wi-Fi, oltre ai secondi trascorsi dalla perdita di connessione.
\
== Aspetti di sicurezza e limiti osservati <sicurezza-limiti>
\
Dall'analisi del codice sono emerse le seguenti criticità, da affrontare prima del rilascio in produzione:
\
- *Segreti e token API*: il token di autenticazione è attualmente definito in chiaro all'interno del codice sorgente (`api.cpp`), così come l'indirizzo MAC identificativo del dispositivo; è necessario adottare un sistema di archiviazione sicuro o una configurazione esterna per ciascun dispositivo.
- *Validazione TLS*: l'utilizzo di `setInsecure()` sul client TLS disabilita il controllo dei certificati del server remoto; è raccomandata l'implementazione della validazione della catena di trust. Considerazioni analoghe valgono per la connessione WebSocket sicura.
- *Access Point di configurazione*: le credenziali dell'Access Point (`ESP32-Config`) sono fisse e comuni a tutti i dispositivi, e gli endpoint di gestione (`/reboot`, `/reset_factory`, `/connect`) non richiedono alcuna autenticazione; chiunque si colleghi all'Access Point può quindi modificarne la configurazione. Le credenziali della rete Wi-Fi sono inoltre memorizzate in chiaro nella NVS.
*Aggiornamenti OTA*: l'aggiornamento è attivabile tramite comando remoto; il controllo periodico autonomo è disattivato e la funzione dedicata restituisce sempre `false`. Il download usa un client non cifrato e nel codice esaminato non è presente una verifica esplicita della firma dell'immagine; prima di un impiego produttivo sono quindi necessari un trasporto autenticato e controlli d'integrità e autenticità.
*Operazioni bloccanti*: la richiesta `/connect` attende fino a 10 secondi l'esito della connessione all'interno del `NetworkTask`, sospendendo nel frattempo l'elaborazione periodica di DNS, HTTP, heartbeat e WebSocket.
- *Reset con semantiche diverse*: il reset locale dal menu cancella le credenziali Wi-Fi e la cache eventi, ma non tutte le impostazioni né il logo; il comando remoto `reset` cancella anche il namespace delle impostazioni, ma non elimina il logo. L'endpoint locale `/reset_factory` è invece quello che rimuove anche il file del logo. Le diverse operazioni non hanno quindi lo stesso effetto e andrebbero uniformate.
- *Stato di sincronizzazione*: la finestra diagnostica presenta come ultima sincronizzazione il tempo dalla disconnessione della rete, mentre quando la rete è connessa mostra “ora”; non viene mantenuto un timestamp effettivo dell'ultimo scambio riuscito con il CRM.
\
#pagebreak()
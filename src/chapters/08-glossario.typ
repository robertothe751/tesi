#import "shared.typ": *

#pagebreak()

= Glossario <glossario>

Il presente glossario raccoglie gli acronimi, i termini tecnici e i nomi di strumenti e tecnologie utilizzati nel documento, in ordine alfabetico. Le definizioni sono riferite al contesto del progetto: dove un termine ha più significati, è riportato quello adottato nel lavoro di stage.
\
#let gloss(term, body) = block(
  width: 100%,
  breakable: false,
  above: 0.8em,
  below: 0.8em,
  par(hanging-indent: 1.5em, justify: true)[*#term* #body],
)
\
#gloss[Access Point (AP)][Modalità di funzionamento Wi-Fi in cui il dispositivo crea una propria rete alla quale altri apparecchi possono collegarsi. Nel progetto la rete `ESP32-Config` permette di raggiungere il portale di configurazione. Si contrappone alla modalità _station_.]
\
#gloss[Agile][Approccio alla gestione e allo sviluppo del software basato su iterazioni brevi, rilascio incrementale delle funzionalità e confronto continuo con il committente, che consente di adattarsi ai cambiamenti dei requisiti.]
\
#gloss[AMOLED][_Active-Matrix Organic Light-Emitting Diode_. Tecnologia di display in cui ogni pixel emette luce propria, senza retroilluminazione, con neri profondi e consumi contenuti. È la tecnologia dei due display utilizzati nel prototipo.]
\
#gloss[API][_Application Programming Interface_. Insieme di funzioni e protocolli che un sistema mette a disposizione per essere utilizzato da altri programmi. Nel progetto indica le interfacce HTTP del CRM RelAi con cui il dispositivo scambia dati.]
\
#gloss[Autosleep][Funzione dei controller touch che riduce i consumi sospendendo la rilevazione dopo un periodo di inattività. Può causare la perdita dei primi tocchi, motivo per cui nella seconda variante hardware viene gestita con il _debounce_ della lettura.]
\
#gloss[Bearer token][Token di autenticazione inviato nell'header `Authorization` di una richiesta HTTP: chi lo possiede viene riconosciuto dal server come autorizzato. È utilizzato dal dispositivo per identificarsi presso il CRM RelAi.]
\
#gloss[Branch][Ramo indipendente di un repository di controllo di versione, utilizzato per sviluppare una funzionalità o una correzione senza alterare il ramo principale.]
\
#gloss[Buffer grafico][Area di memoria in cui la libreria grafica compone i pixel di una porzione di schermo prima di inviarli al display. Nel progetto sono due buffer allocati nella memoria PSRAM, usati in modalità di rendering parziale.]
\
#gloss[Cache locale][Copia, conservata nel dispositivo, degli ultimi dati validi ricevuti dal CRM (elenco degli eventi). Permette di continuare a mostrare le informazioni in assenza di connettività e dopo un riavvio.]
\
#gloss[Captive portal][Pagina web a cui viene automaticamente reindirizzato chi si collega a una rete Wi-Fi, prima di accedere a qualsiasi altra risorsa. Nel progetto serve a guidare l'utente nella configurazione della rete dell'organizzazione.]
\
#gloss[CO5300][Controller del display AMOLED pilotato dal microcontrollore tramite bus QSPI. Richiede che le aree da ridisegnare abbiano coordinate di inizio pari e di fine dispari.]
\
#gloss[Code review][Revisione del codice sorgente da parte di un altro sviluppatore, finalizzata a controllarne qualità, leggibilità, rispetto delle convenzioni e correttezza prima dell'integrazione.]
\
#gloss[Controller touch CST][Famiglia di controller per schermi touch capacitivi collegati via bus I²C. Nelle due varianti hardware del progetto sono utilizzati i modelli CST92xx e CST820.]
\
#gloss[CRM][_Customer Relationship Management_. Sistema software per la gestione delle relazioni con clienti e organizzazioni. Nel progetto è rappresentato da RelAi, con cui il dispositivo comunica.]
\
#gloss[Debounce][Tecnica che filtra le variazioni spurie di un segnale di ingresso, considerando valido un cambiamento solo se persiste per un tempo minimo. Nel progetto viene usata per confermare il rilascio del tocco sul display.]
\
#gloss[Deep sleep][Modalità a consumo minimo dell'ESP32 in cui quasi tutte le periferiche sono spente. Nel progetto viene raggiunta dal comando remoto `shutdown`.]
\
#gloss[DNS][_Domain Name System_. Sistema che associa i nomi di dominio agli indirizzi IP. Il server DNS locale del dispositivo risponde a ogni richiesta con l'indirizzo dell'Access Point, così da reindirizzare i client al captive portal.]
\
#gloss[Endpoint][Indirizzo (URL) a cui un servizio HTTP espone una determinata funzione, ad esempio `/scan` o `/status` sul server locale del dispositivo.]
\
#gloss[ESP32-S3][Microcontrollore prodotto da Espressif Systems con due core, connettività Wi-Fi e Bluetooth Low Energy e supporto alla memoria PSRAM esterna. È la piattaforma hardware su cui è eseguito il firmware.]
\
#gloss[Fallback][Comportamento alternativo adottato quando la modalità normale non è disponibile. Nel progetto, in assenza di rete o del CRM, il dispositivo mostra i dati della cache locale e tenta la riconnessione in background.]
\
#gloss[Firmware][Software eseguito direttamente da un microcontrollore e memorizzato nella sua memoria flash. Nel progetto indica l'intero programma del dispositivo, sviluppato in C++.]
\
#gloss[Flashing][Operazione di caricamento del firmware nella memoria flash di un microcontrollore.]
\
#gloss[FreeRTOS][Sistema operativo real-time per microcontrollori, integrato nell'ambiente di sviluppo dell'ESP32. Fornisce task, semafori, mutex e temporizzazioni; nel progetto permette di eseguire rete e grafica in parallelo sui due core.]
\
#gloss[Gitea][Piattaforma open-source per l'hosting di repository Git, con gestione di branch, pull request e revisioni del codice.]
\
#gloss[Heartbeat][Messaggio inviato a intervalli regolari da un dispositivo a un server per segnalare che è attivo. Nel progetto è una richiesta HTTP POST che trasmette anche la telemetria e riceve in risposta comandi, impostazioni ed eventi.]
\
#gloss[HTTP / HTTPS][_HyperText Transfer Protocol_ (_Secure_). Protocollo di comunicazione richiesta-risposta su cui si basa il web; la variante HTTPS cifra lo scambio mediante TLS.]
\
#gloss[I²C][_Inter-Integrated Circuit_. Bus seriale a due fili (dati e clock) per la comunicazione tra un microcontrollore e le periferiche; nel progetto collega il controller touch.]
\
#gloss[Issue][Segnalazione tracciata in uno strumento di gestione dei progetti, che descrive un requisito, un'attività o un difetto da risolvere.]
\
#gloss[JSON][_JavaScript Object Notation_. Formato testuale leggero per lo scambio di dati strutturati, basato su coppie chiave-valore e liste. È il formato dei messaggi tra dispositivo e CRM.]
\
#gloss[LittleFS][File system progettato per memorie flash di piccole dimensioni, resistente agli spegnimenti improvvisi. Nel progetto ospita le pagine del portale web e il file del logo dell'organizzazione.]
\
#gloss[lodepng][Libreria C++ per la codifica e la decodifica di immagini PNG, utilizzata per convertire il logo ricevuto dal CRM in pixel visualizzabili su display.]
\
#gloss[LVGL][_Light and Versatile Graphics Library_. Libreria grafica open-source per sistemi embedded, che fornisce componenti visuali, gestione degli eventi di input e rendering ottimizzato.]
\
#gloss[Message box][Finestra modale che si sovrappone all'interfaccia per mostrare un'informazione o richiedere un'azione, bloccando l'interazione con il resto della schermata finché non viene chiusa.]
\
#gloss[MQTT][_Message Queuing Telemetry Transport_. Protocollo leggero di tipo publish/subscribe per lo scambio di messaggi tra dispositivi IoT. È citato tra le alternative per l'aggiornamento near-real-time.]
\
#gloss[Mutex][_Mutual exclusion_. Meccanismo di sincronizzazione che consente a un solo task alla volta di accedere a una risorsa condivisa. Nel progetto `lvgl_mutex` protegge gli oggetti grafici.]
\
#gloss[Near-real-time][Aggiornamento dei dati con una latenza di pochi secondi dal momento in cui cambiano sul sistema di origine.]
\
#gloss[NVS][_Non-Volatile Storage_. Area di memoria flash dell'ESP32 per salvare coppie chiave-valore che sopravvivono ai riavvii. È utilizzata tramite la libreria `Preferences` per credenziali Wi-Fi, impostazioni e cache degli eventi.]
\
#gloss[OTA][_Over-the-Air_. Aggiornamento del firmware eseguito da remoto tramite la rete, senza collegare fisicamente il dispositivo a un computer.]
\
#gloss[Payload][Contenuto utile di un messaggio o di una richiesta di rete, distinto dalle informazioni di intestazione; nel progetto è tipicamente un oggetto JSON.]
\
#gloss[Plane][Piattaforma open-source per la gestione di progetti e il tracciamento di attività e issue, usata per monitorare l'avanzamento dello stage.]
\
#gloss[PlatformIO][Ambiente di sviluppo per sistemi embedded, integrato con Visual Studio Code, che gestisce piattaforma di destinazione, librerie, compilazione e caricamento del firmware.]
\
#gloss[PNG][_Portable Network Graphics_. Formato di immagine raster con compressione senza perdita e supporto alla trasparenza; è il formato del logo dell'organizzazione.]
\
#gloss[Provisioning][Procedura di configurazione iniziale di un dispositivo. Nel progetto consiste nel collegarsi all'Access Point, scegliere la rete Wi-Fi e inserirne la password tramite il portale.]
\
#gloss[PSRAM][_Pseudo-Static RAM_. Memoria RAM esterna al microcontrollore, più capiente della RAM interna, utilizzata per i buffer grafici di LVGL.]
\
#gloss[Pull request][Richiesta di integrare le modifiche di un branch in un altro, che avvia la discussione e la revisione del codice.]
\
#gloss[Pusher (protocollo)][Protocollo di messaggistica in tempo reale basato su WebSocket, con canali pubblici e privati a cui i client si iscrivono. Il CRM RelAi ne espone uno compatibile, usato per inviare comandi e aggiornamenti al dispositivo.]
\
#gloss[QR code][_Quick Response code_. Codice a barre bidimensionale che codifica un testo, ad esempio un indirizzo web o le credenziali di una rete Wi-Fi, leggibile con la fotocamera di uno smartphone.]
\
#gloss[QSPI][_Quad Serial Peripheral Interface_. Variante del bus SPI con quattro linee dati, che aumenta la velocità di trasferimento; nel progetto collega il display AMOLED al microcontrollore.]
\
#gloss[RelAi][Piattaforma CRM di Spazio Dev S.r.l. con cui il dispositivo si integra: fornisce eventi e impostazioni e riceve la telemetria.]
\
#gloss[Rendering][Processo con cui l'interfaccia viene disegnata in pixel. Nel progetto LVGL opera in modalità parziale: ridisegna solo le aree modificate, a blocchi, in due buffer alternati.]
\
#gloss[Reset di fabbrica][Operazione che cancella configurazioni, credenziali e cache salvate e riporta il dispositivo allo stato iniziale, con l'Access Point di provisioning attivo.]
\
#gloss[REST][_Representational State Transfer_. Stile architetturale per servizi web in cui le risorse sono identificate da URL e manipolate con i metodi HTTP (GET, POST ecc.).]
\
#gloss[RGB565][Formato colore a 16 bit per pixel con 5 bit per il rosso, 6 per il verde e 5 per il blu, usato per ridurre memoria e banda verso il display.]
\
#gloss[RSSI][_Received Signal Strength Indicator_. Misura della potenza del segnale Wi-Fi ricevuto, espressa in dBm; è inclusa nella telemetria inviata al CRM.]
\
#gloss[Station (STA)][Modalità Wi-Fi in cui il dispositivo si collega a una rete esistente, come un normale client. Nel progetto convive con l'Access Point (modalità AP+STA).]
\
#gloss[Task][Unità di esecuzione di FreeRTOS, con proprio stack e priorità. Il firmware usa un `NetworkTask` sul core 0 e un `DisplayTask` sul core 1.]
\
#gloss[Telemetria][Insieme di dati di stato misurati dal dispositivo e inviati al sistema centrale. Nel progetto comprende uptime, memoria heap libera e RSSI.]
\
#gloss[Thread-safe][Caratteristica di un codice o di una libreria che può essere usato in modo sicuro da più task contemporaneamente. LVGL non lo è, perciò l'accesso è serializzato con un mutex.]
\
#gloss[Tile / Tileview][Componente LVGL che organizza il contenuto in riquadri affiancati, tra cui si scorre con un gesto. Nel progetto ogni evento è un tileview con una tile informativa e una con il QR code.]
\
#gloss[TLS][_Transport Layer Security_. Protocollo crittografico che garantisce riservatezza e autenticità delle comunicazioni; usato da HTTPS e dai WebSocket sicuri. La verifica dei certificati è attualmente disattivata (`setInsecure()`).]
\
#gloss[Toolchain][Insieme di strumenti (compilatore, linker, programmi di caricamento) necessario a produrre ed eseguire il firmware sulla piattaforma di destinazione.]
\
#gloss[Touch screen capacitivo][Schermo sensibile al tocco che rileva la variazione di capacità elettrica causata dal dito.]
\
#gloss[Typst][Sistema di composizione tipografica basato su markup, utilizzato per redigere la tesi.]
\
#gloss[UML][_Unified Modeling Language_. Linguaggio di modellazione grafico per descrivere struttura e comportamento di un sistema software. I diagrammi dei casi d'uso ne sono un tipo.]
\
#gloss[Uptime][Tempo trascorso dall'ultimo avvio del dispositivo, o dall'ultima disconnessione quando riferito alla rete.]
\
#gloss[Watchdog][Temporizzatore hardware o software che riavvia il sistema se il programma smette di rispondere entro un tempo limite; protegge da blocchi in esercizio prolungato.]
\
#gloss[WebSocket][Protocollo che mantiene aperto un canale bidirezionale persistente tra client e server, permettendo a entrambi di inviare messaggi in qualsiasi momento. Nel progetto serve a ricevere comandi e aggiornamenti dal CRM.]
\
#gloss[Wi-Fi][Famiglia di tecnologie di rete locale senza fili basate sullo standard IEEE 802.11.]
\
#pagebreak()
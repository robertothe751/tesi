#import "shared.typ": *


#pagebreak()
= Analisi dei requisiti <analisi-requisiti>
\ 
Il presente capitolo è dedicato all'analisi dei requisiti del sistema, attività essenziale per definire gli obiettivi funzionali e i vincoli progettuali della soluzione. Vengono illustrati gli attori coinvolti, i casi d'uso e i requisiti funzionali e non funzionali individuati durante la fase di studio. Le informazioni raccolte costituiscono il punto di partenza per le successive attività di progettazione e implementazione del sistema.
\
== Analisi degli utenti
\
Il sistema sviluppato nel contesto dello stage consiste in un dispositivo basato su ESP32, dotato di display e integrato con il CRM RelAi. Il suo scopo è mostrare in tempo reale informazioni relative a organizzazioni ed eventi, quali codici QR, contatori degli iscritti e dei partecipanti, prenotazioni e dati di stato del dispositivo.
\
L'utilizzo del sistema coinvolge un unico attore principale, identificato nell'utente dell'organizzazione cliente presso la quale il dispositivo viene installato. Tale soggetto è responsabile della configurazione iniziale del pannello, che comprende il collegamento alla rete Wi-Fi tramite portale captive e la gestione delle principali impostazioni operative del dispositivo trammite CRM RelAi.
\
Una volta completata la fase di configurazione, l'utente interagisce con il sistema attraverso la visualizzazione ciclica o manuale dei pannelli informativi a display e l'utilizzo di un menu diagnostico touch locale per operazioni di manutenzione (riavvio, reset, condivisione QR). Parallelamente, il sistema dialoga con il cloud per ricevere aggiornamenti in tempo reale tramite WebSocket.
\
Poiché il progetto è destinato a contesti operativi nei quali gli utilizzatori potrebbero non possedere particolari competenze tecniche, l'interfaccia e i flussi di interazione sono stati progettati privilegiando chiarezza, semplicità di utilizzo e rapidità delle operazioni di configurazione e gestione. Tale approccio consente di ridurre la complessità percepita e di facilitare l'adozione del dispositivo presso le organizzazioni clienti.
\
== Casi d'uso
Per lo studio dei casi di utilizzo del prodotto sono stati definiti i diagrammi e le relative specifiche funzionali. I diagrammi dei casi d'uso (_Use Case Diagram_) sono diagrammi di tipo _UML_ dedicati alla descrizione delle funzioni o servizi offerti dal sistema, così come sono percepiti dagli attori che interagiscono con esso.
\
=== Elenco dei casi d'uso
\
- *UC1* – Configurazione Wi‑Fi
  - *UC1.1* – Nessuna rete disponibile
  - *UC1.2* – Credenziali non valide
- *UC2* – Consultazione diagnostica locale del dispositivo
- *UC3* – Consultazione stato e telemetria remota tramite CRM RelAi
- *UC4* – Condivisione Wi-Fi tramite QR Code
- *UC5* – Riavvio locale del dispositivo
- *UC6* – Riavvio remoto del dispositivo
- *UC7* – Reset di sistema locale
- *UC8* – Reset di sistema remoto
- *UC9* – Sincronizzazione e gestione remota tramite CRM RelAi
  - *UC9.1* – Gestione del fallback in assenza di connettività
- *UC10* – Navigazione tra le schermate informative
- *UC11* – Visualizzazione dei dati nei pannelli informativi a display
\
=== Descrizione dettagliata dei casi d'uso

#usecase(1, [Configurazione della connessione Wi‑Fi], [Utente], [
- Il dispositivo ESP32 è acceso e correttamente alimentato.
- Il Captive Portal è attivo.
- L'utente è connesso alla rete generata dal dispositivo.
- È disponibile almeno una rete Wi‑Fi nelle vicinanze.
*Trigger:* L'utente desidera configurare o aggiornare i parametri di accesso alla rete Wi‑Fi del dispositivo.
], [
1. L'utente si connette all'Access Point generato dal dispositivo.
2. Il sistema reindirizza automaticamente l'utente alla pagina di configurazione.
3. Il sistema esegue la scansione delle reti Wi‑Fi disponibili.
4. L'utente seleziona la rete desiderata.
5. L'utente inserisce la password della rete selezionata.
6. L'utente conferma la configurazione.
7. Il sistema verifica i dati ricevuti.
8. Il sistema salva le credenziali nella memoria persistente.
9. Il sistema effettua la connessione alla rete Wi‑Fi selezionata.
10. Il sistema conferma l'avvenuta configurazione.
], [
- Le credenziali della rete Wi‑Fi sono memorizzate nella memoria persistente del dispositivo.
- Il dispositivo risulta connesso alla rete selezionata.
- Il dispositivo è pronto per comunicare con le API del CRM RelAi.
]) <uc-config-wifi>
\
#usecase(1.1, [Nessuna rete disponibile], [Utente], [
- Il dispositivo è acceso in modalità di provisioning.
- Il Captive Portal è attivo.
*Trigger:* Avvio della scansione delle reti Wi‑Fi senza la presenza di punti d'accesso validi nel raggio d'azione.
], [
1. L'utente accede alla pagina di configurazione Wi‑Fi.
2. Il sistema avvia la scansione delle reti disponibili.
3. La scansione non restituisce alcuna rete utilizzabile o va in timeout.
4. Il sistema restituisce l'elenco vuoto e un feedback visivo d'errore all'interfaccia web.
5. L'utente richiede una nuova scansione.
], [
- Nessuna configurazione Wi‑Fi viene salvata.
- Il Captive Portal e l'Access Point rimangono disponibili per un nuovo tentativo.
]) <uc-wifi-nessuna-rete>
\
#usecase(1.2, [Credenziali non valide], [Utente], [
- È stata selezionata una rete Wi‑Fi.
- Sono stati inseriti dati errati.
*Trigger:* Tentativo di connessione a una rete Wi‑Fi con parametri sbagliati.
], [
1. L'utente conferma la configurazione inserendo la password.
2. Il sistema tenta di collegarsi alla rete Wi-Fi per un intervallo massimo di timeout.
3. Il tentativo di associazione fallisce (codice di errore Wi-Fi).
4. Il sistema intercetta il fallimento, interrompe la connessione STA e ripristina la stabilità dell'Access Point.
5. Il sistema restituisce un messaggio di errore JSON all'interfaccia di provisioning.
6. L'utente corregge i parametri e ripete la procedura.
], [
- Nessuna credenziale errata viene salvata come configurazione stabile.
- Il portale di configurazione rimane attivo per consentire la correzione dei dati.
]) <uc-wifi-credenziali-errate>
\
#usecase(2, [Consultazione diagnostica locale del dispositivo], [Utente], [
- Il dispositivo ESP32 è acceso e correttamente avviato.
- L'interfaccia grafica LVGL è attiva e il menu di diagnostica circolare è accessibile a schermo.
*Trigger:* L'utente seleziona il pulsante "Stato Sistema" dal menu touch locale.
], [
1. L'utente preme il pulsante di accesso allo stato dal menu touch del display.
2. Il sistema interroga i moduli di runtime e raccoglie i parametri correnti (SSID della rete connessa, stato della connessione, versione del firmware e tempo trascorso – _uptime_ / _elapsed_ – dall'ultima disconnessione).
3. Il sistema apre un riquadro modale sovrapposto (_message box_) contenente le informazioni aggregate.
4. L'utente prende visione dei dati diagnostici e chiude la finestra modale tramite il pulsante di chiusura dedicato, ripristinando la schermata principale.
], [
- L'utente è informato sullo stato di salute e connettività locale del dispositivo.
- Il sistema riprende la normale rotazione o visualizzazione dei pannelli alla chiusura del modale.
]) <uc-consultazione-stato>
\
#usecase(3, [Consultazione stato e telemetria remota tramite CRM RelAi], [Utente], [
- Il dispositivo ESP32 è connesso a Internet tramite Wi-Fi.
- Il servizio di heartbeat periodico e il client HTTPS/WebSocket verso il CRM RelAi sono attivi.
*Trigger:* Scadenza del timer periodico di heartbeat o richiesta esplicita dal pannello di controllo cloud.
], [
1. Il dispositivo invia periodicamente una richiesta HTTP POST (`heartbeat`) contenente i dati di telemetria (indirizzo MAC, tipo dispositivo, versione software, _uptime_, memoria _heap_ libera e RSSI del Wi-Fi).
2. Il server CRM RelAi riceve e registra i dati di stato aggiornati del dispositivo.
3. L'utente accede alla piattaforma cloud per monitorare la telemetria e la connettività del display da remoto.
], [
- La piattaforma cloud mantiene traccia in tempo reale dello stato operativo e della telemetria del dispositivo.
- Il sistema restituisce al dispositivo l'intervallo di aggiornamento aggiornato e la lista degli eventi correnti.
]) <uc-consultazione-remota>
\
#usecase(4, [Condivisione Wi-Fi tramite QR Code], [Utente], [
- Il dispositivo ESP32 è acceso ed è connesso a una rete Wi-Fi.
- L'interfaccia grafica touch locale è attiva.
*Trigger:* L'utente seleziona il pulsante "QR Rete" dal menu di diagnostica locale.
], [
1. L'utente accede al menu diagnostico sul display e seleziona la condivisione della rete.
2. Il sistema recupera l'SSID e la chiave di rete (`WiFi.SSID()` e `WiFi.psk()`).
3. Il sistema formatta stringa secondo lo standard di connessione mobile (`WIFI:S:...;T:WPA;P:...;;`).
4. Il sistema genera dinamicamente un codice QR e lo renderizza a schermo all'interno di una finestra modale dedicata.
5. Un dispositivo esterno (es. smartphone) scansiona il codice a barre bidimensionale per connettersi rapidamente alla medesima rete.
6. L'utente chiude il modale al termine dell'operazione.
], [
- Il codice QR con le credenziali correnti risulta visibile a schermo.
- Alla chiusura del modale, viene ripristinata la visualizzazione operativa standard e riattivato il timer di rotazione.
]) <uc-condivisione-wifi>
\
#usecase(5, [Riavvio locale del dispositivo], [Utente], [
- Il dispositivo ESP32 è operativo.
- L'utente ha accesso al menu touch locale di diagnostica.
*Trigger:* L'utente seleziona il tasto "Riavvio ESP32" sul display.
], [
1. L'utente seleziona l'opzione di riavvio dal menu locale touch.
2. Il sistema avvia un timer temporizzato di sicurezza per la chiusura ordinata dei task.
3. Il sistema esegue il comando software di riavvio (`ESP.restart()`).
4. Il microcontrollore si riavvia ricaricando il firmware e ripristinando le periferiche e le connessioni di rete.
], [
- Il dispositivo viene riavviato pulitamente preservando le configurazioni e le preferenze salvate in memoria persistente NVS.
]) <uc-riavvio-locale>
\
#usecase(6, [Riavvio remoto del dispositivo], [Utente], [
- Il dispositivo ESP32 è acceso e connesso alla rete.
- Il canale di comunicazione WebSocket con il CRM RelAi è attivo.
*Trigger:* L'utente invia un comando di riavvio remoto dalla piattaforma cloud CRM RelAi.
], [
1. Il sistema riceve un payload JSON tramite WebSocket contenente il comando di riavvio (`action: "restart"`).
2. Il sistema elabora il comando remoto e avvia la procedura di chiusura delle attività in corso.
3. Il microcontrollore esegue il comando di reboot software (`ESP.restart()`).
4. Il dispositivo si riavvia da remoto ricaricando il firmware.
], [
- Il dispositivo viene riavviato da remoto preservando le configurazioni salvate in memoria persistente NVS.
]) <uc-riavvio-remoto>
\
#usecase(7, [Reset di sistema locale], [Utente], [
- Il dispositivo ESP32 è acceso e operativo.
- L'utente ha accesso al menu touch di diagnostica locale.
*Trigger:* L'utente seleziona il tasto "Reset ESP32" dal display.
], [
1. L'utente seleziona l'opzione di reset di fabbrica dal menu locale.
2. Il sistema avvia la procedura di cancellazione dei namespace di configurazione nella memoria flash (`wifi-config`, `api-cache` e `esp-settings`).
3. Il sistema disconnette le interfacce di rete e azzera le preferenze salvate.
4. Il sistema esegue il riavvio automatico del microcontrollore (`ESP.restart()`).
5. Al nuovo avvio, il dispositivo si presenta nello stato iniziale di fabbrica con l'Access Point di provisioning attivo.
], [
- Tutti i dati salvati, le preferenze di rete e la cache locale risultano completamente cancellati.
- Il dispositivo torna allo stato di configurazione iniziale pronto per una nuova associazione.
]) <uc-reset-locale>
\
#usecase(8, [Reset di sistema remoto], [Utente], [
- Il dispositivo ESP32 è connesso al server remoto.
- Il canale WebSocket con il CRM RelAi è stabilito.
*Trigger:* L'utente invia un comando di reset di fabbrica dalla piattaforma cloud CRM RelAi.
], [
1. Il sistema riceve un payload JSON tramite WebSocket contenente il comando di reset (`action: "reset"`).
2. Il sistema avvia la procedura di cancellazione remota dei dati nei namespace di configurazione presenti nella memoria flash (`wifi-config` e `api-cache`).
3. Il sistema ripulisce le preferenze e interrompe le interfacce di rete.
4. Il sistema esegue il riavvio automatico del dispositivo portandolo allo stato iniziale di fabbrica.
], [
- Tutte le preferenze e i dati memorizzati in precedenza risultano cancellati da remoto.
- Il dispositivo torna allo stato di configurazione iniziale con l'Access Point di provisioning attivo.
]) <uc-reset-remoto>
\
#usecase(9, [Sincronizzazione e gestione remota tramite CRM RelAi], [Utente], [
- Il dispositivo è connesso alla rete Wi-Fi e alle API del CRM.
- I servizi di heartbeat HTTP e i canali WebSocket (Pusher) sono inizializzati e sottoscritti.
*Trigger:* Risposta positiva a un heartbeat periodico o ricezione di un evento di aggiornamento in tempo reale sul canale WebSocket.
], [
1. Il sistema riceve i dati di configurazione aggiornati (come l'intervallo di rotazione dei pannelli `rotation_interval_seconds`) e la lista aggiornata degli eventi dal server.
2. Il modulo di gestione dati elabora il payload JSON ricevuto e verifica se vi sono variazioni rispetto alla cache corrente.
3. Se i dati differiscono, il sistema salva i nuovi eventi nella memoria persistente NVS (namespace `api-cache`).
4. Il sistema invia un segnale interno di aggiornamento (`ui_richiedi_ricarica_tileview`) per ricostruire dinamicamente le schermate informative.
], [
- Le schermate informative, i dati degli eventi e i parametri di rotazione si aggiornano dinamicamente in base alle direttive del CRM RelAi.
]) <uc-config-crm>
\
#usecase(9.1, [Gestione del fallback in assenza di connettività], [Utente], [
- Il dispositivo si trova in uno stato di disconnessione temporanea dalla rete o il server remoto/ngrok risulta irragiungibile.
*Trigger:* Fallimento di una richiesta HTTP di heartbeat o disconnessione del socket WebSocket.
], [
1. Il sistema rileva il fallimento della comunicazione di rete o l'assenza prolungata di connettività.
2. Il gestore delle API intercetta l'eccezione bloccando i tentativi non necessari e prevenendo la frammentazione della memoria RAM (`heap`).
3. Il sistema legge in modo trasparente i dati precedentemente memorizzati nella cache persistente locale (`api-cache`).
4. L'interfaccia grafica continua a mostrare l'ultimo stato valido degli eventi senza causare blocchi o riavvii anomali del display.
5. Il sistema avvia una procedura di tentativi schedulati di riconnessione in background.
], [
- Il dispositivo garantisce la continuità operativa in modalità _offline_ (fallback) sfruttando la cache locale.
- Il sistema riprende la sincronizzazione automatica non appena la connettività di rete viene ristabilita.
]) <uc-errore-crm>
\
#usecase(10, [Navigazione tra le schermate informative], [Utente], [
- Il dispositivo ESP32 è acceso e mostra le schermate degli eventi o il menu principale.
- La rotazione automatica e la barra di navigazione laterale/inferiore touch sono attive.
*Trigger:* Pressione dei pulsanti touch di navigazione o scadenza del timer di rotazione automatica; triplo tocco sullo schermo per abilitare/disabilitare la rotazione.
], [
1. Il sistema gestisce la rotazione automatica delle pagine in base al timer configurato (es. ogni 30 secondi), oppure l'utente interagisce premendo i pulsanti freccia sulla barra di navigazione.
2. Il sistema esegue l'animazione di transizione tra la schermata corrente e la successiva (gestendo la coda dei passi di navigazione ed evitando sovrapposizioni di rendering).
3. L'utente visualizza la nuova schermata informativa o la pagina del menu diagnostico.
], [
- L'interfaccia grafica risponde fluidamente ai comandi di navigazione manuale o automatica.
- Lo stato della rotazione (attiva o in pausa) viene aggiornato visivamente sui pulsanti di controllo.
]) <uc-navigazione-schermate>
\
#usecase(11, [Visualizzazione dei dati nei pannelli informativi a display], [Utente], [
- Il dispositivo ESP32 è alimentato e correttamente avviato.
- Il display AMOLED e il sistema grafico LVGL sono inizializzati con i rispettivi buffer in memoria.
- Sono presenti dati validi in cache locale o ricevuti dalle API del CRM RelAi.
*Trigger:* Completamento dell'avvio del dispositivo, ricezione di nuovi dati o transizione del timer di pagina.
], [
1. Il sistema esegue il rendering grafico dei pannelli degli eventi strutturati a schede (_tileview_).
2. Ciascun pannello mostra a schermo le informazioni principali dell'evento (identificativo ID, nome dell'evento, contatore delle prenotazioni e dei partecipanti).
3. Il sistema genera e mostra la tile laterale associata contenente il codice QR dinamico di riferimento per l'evento.
4. L'utente consulta visivamente le informazioni o interagisce con il touch screen.
], [
- I dati aggiornati dell'evento risultano correttamente renderizzati e visibili a schermo con elevata fluidità visiva.
- Il sistema mantiene la rotazione attiva in base alle impostazioni correnti.
]) <uc-visualizzazione-display>
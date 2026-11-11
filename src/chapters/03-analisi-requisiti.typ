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
- Il dispositivo ESP32 è operativo.
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
], image-path: "../../img/use_cases/UC1_Configurazione_wifi.png") <uc-config-wifi>
\
#usecase(1.1, [Nessuna rete disponibile], [Utente], [
- Il dispositivo ESP32 è acceso con il Captive Portal attivo
- L'utente è connesso alla rete generata dal dispositivo.
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
], image-path: "../../img/use_cases/UC1.1_Nessuna_rete_disponibile.png") <uc-wifi-nessuna-rete>
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
], image-path: "../../img/use_cases/UC1.2_Credenziali_non_valide.png") <uc-wifi-credenziali-errate>
\
#usecase(2, [Consultazione diagnostica locale del dispositivo], [Utente], [
- Il dispositivo ESP32 è operativo.
- L'interfaccia grafica è operativo.
*Trigger:* L'utente seleziona il pulsante "Stato Sistema" dal menu touch locale.
], [
1. L'utente preme il pulsante di accesso allo stato dal menu touch del display.
2. Il sistema interroga i moduli di runtime e raccoglie i parametri correnti (SSID della rete connessa, stato della connessione, versione del firmware e tempo trascorso _uptime_ dall'ultima disconnessione).
3. Il sistema apre una _message box_ contenente le informazioni aggregate.
4. L'utente prende visione dei dati diagnostici e chiude la finestra modale tramite il pulsante di chiusura dedicato, ripristinando la schermata principale.
], [
- L'utente è informato sullo stato di salute e connettività locale del dispositivo.
- Il sistema riprende la normale rotazione o visualizzazione dei pannelli alla chiusura del modale.
], image-path: "../../img/use_cases/UC2_Consultazione_diagnostica_locale.png") <uc-consultazione-stato>
\
#usecase(3, [Consultazione stato e telemetria remota tramite CRM RelAi], [Utente], [
- Il dispositivo ESP32 è operativo.
- Il dispositivo ESP32 è connesso a Internet tramite Wi-Fi.
- Il dispositivo ESP32 e connesso al CRM RelAi .
*Trigger:* L'utente desidera verificare lo stato di salute, la connettività o le metriche di un dispositivo dal pannello di controllo cloud.
], [
1. L'utente accede alla sezione di monitoraggio dei dispositivi all'interno della piattaforma CRM RelAi.
2. Il sistema cloud interroga i dati di telemetria più recenti memorizzati dal dispositivo (tra cui versione software, _uptime_ e RSSI del Wi-Fi).
3. L'interfaccia della piattaforma CRM elabora le informazioni e mostra all'utente la panoramica aggiornata sullo stato di salute e connettività del display.
], [
- L'utente ottiene una visione centralizzata e aggiornata dello stato operativo del dispositivo da remoto.
- La piattaforma cloud mantiene traccia delle metriche telemetriche ricevute.
], image-path: "../../img/use_cases/UC3_Consultazione_diagnostica_remota.png") <uc-consultazione-remota>
\
#usecase(4, [Condivisione Wi-Fi tramite QR Code], [Utente], [
- Il dispositivo ESP32 è acceso ed è connesso a una rete Wi-Fi.
*Trigger:* L'utente seleziona il pulsante "QR Rete" dal menu di diagnostica locale per contividere i dati di accesso alla rete .
], [
1. L'utente accede al menu sul display e seleziona la condivisione della rete.
2. Il sistema recupera l'SSID e la chiave di rete.
3. Il sistema formatta la stringa secondo lo standard di connessione mobile.
4. Il sistema genera dinamicamente un codice QR e lo renderizza a schermo all'interno di una _message box_ edicata.
5. Un dispositivo esterno scansiona il codice QR per connettersi rapidamnte alla medesima rete.
6. L'utente chiude il modale al termine dell'operazione.
], [
- Il codice QR con le credenziali correnti risulta visibile a schermo.
- Alla chiusura del modale, viene ripristinata la visualizzazione operativa standard e riattivato il timer di rotazione.
], image-path: "../../img/use_cases/UC4_Condivisione_Wi-Fi_QR.png") <uc-condivisione-wifi>
\
#usecase(5, [Riavvio locale del dispositivo], [Utente], [
- Il dispositivo ESP32 è operativo.
- L'interfaccia grafica è operativo.
*Trigger:* L'utente seleziona il tasto "Riavvio ESP32" sul display.
], [
1. L'utente seleziona l'opzione di riavvio dal menu locale touch.
2. Il sistema avvia un timer temporizzato di sicurezza per la chiusura ordinata dei task.
3. Il sistema esegue il comando software di riavvio.
4. Il microcontrollore si riavvia ricaricando il firmware e ripristinando le periferiche e le connessioni di rete.
], [
- Il dispositivo viene riavviato pulitamente preservando le configurazioni e le preferenze salvate in memoria persistente NVS.
], image-path: "../../img/use_cases/UC5_Riavvio_locale.png") <uc-riavvio-locale>
\
#usecase(6, [Riavvio remoto del dispositivo], [Utente], [
- Il dispositivo ESP32 è operativo.
- Il dispositivo ESP32 è connesso a Internet tramite Wi-Fi.
- Il dispositivo ESP32 e connesso al CRM RelAi .
*Trigger:* L'utente invia un comando di riavvio remoto dalla piattaforma cloud CRM RelAi.
], [
1. Il sistema riceve un payload JSON tramite WebSocket contenente il comando di riavvio.
2. Il sistema elabora il comando remoto e avvia la procedura di chiusura delle attività in corso.
3. Il microcontrollore esegue il comando di riavvio software.
4. Il dispositivo si riavvia da remoto ricaricando il firmware.
], [
- Il dispositivo viene riavviato da remoto preservando le configurazioni salvate in memoria persistente NVS.
], image-path: "../../img/use_cases/UC6_Riavvio_remoto.png") <uc-riavvio-remoto>
\
#usecase(7, [Reset di sistema locale], [Utente], [
- Il dispositivo ESP32 è acceso e operativo.
*Trigger:* L'utente seleziona il tasto "Reset ESP32" dal display.
], [
1. L'utente seleziona l'opzione di reset di fabbrica dal menu locale.
2. Il sistema avvia la procedura di cancellazione dei namespace di configurazione nella memoria flash.
3. Il sistema disconnette le interfacce di rete e azzera le preferenze salvate.
4. Il sistema esegue il riavvio automatico del microcontrollore.
5. Al nuovo avvio, il dispositivo si presenta nello stato iniziale di fabbrica con l'Access Point di provisioning attivo.
], [
- Tutti i dati salvati, le preferenze di rete e la cache locale risultano completamente cancellati.
- Il dispositivo torna allo stato di configurazione iniziale pronto per una nuova associazione.
], image-path: "../../img/use_cases/UC7_Reset_locale.png") <uc-reset-locale>
\
#usecase(8, [Reset di sistema remoto], [Utente], [
- Il dispositivo ESP32 è operativo.
- Il dispositivo ESP32 è connesso a Internet tramite Wi-Fi.
- Il dispositivo ESP32 e connesso al CRM RelAi .
*Trigger:* L'utente invia un comando di reset di fabbrica dalla piattaforma cloud CRM RelAi.
], [
1. Il sistema riceve un payload JSON tramite WebSocket contenente il comando di reset.
2. Il sistema avvia la procedura di cancellazione remota dei dati nei namespace di configurazione presenti nella memoria flash.
3. Il sistema ripulisce le preferenze e interrompe le interfacce di rete.
4. Il sistema esegue il riavvio automatico del dispositivo portandolo allo stato iniziale di fabbrica.
], [
- Tutte le preferenze e i dati memorizzati in precedenza risultano cancellati da remoto.
- Il dispositivo torna allo stato di configurazione iniziale con l'Access Point di provisioning attivo.
], image-path: "../../img/use_cases/UC8_Reset_remoto.png") <uc-reset-remoto>
\
#usecase(9, [Aggiornamento remoto dei dati tramite CRM RelAi], [Utente], [
- Il dispositivo ESP32 è operativo.
- Il dispositivo ESP32 è connesso a Internet tramite Wi-Fi.
- Il dispositivo ESP32 e connesso al CRM RelAi .
*Trigger:* Ricezione di un evento di aggiornamento in tempo reale sul canale WebSocket.
], [
1. Il sistema riceve i dati di configurazione aggiornati e la lista aggiornata degli eventi dal server.
2. Il modulo di gestione dati elabora il payload JSON ricevuto e verifica se vi sono variazioni rispetto alla cache corrente.
3. Se i dati differiscono, il sistema salva i nuovi eventi nella memoria persistente NVS.
4. Il sistema invia un segnale interno di aggiornamento  per ricostruire dinamicamente le schermate informative.
], [
- Le schermate informative, i dati degli eventi e i parametri di rotazione si aggiornano dinamicamente in base alle direttive del CRM RelAi.
], image-path: "../../img/use_cases/UC9_aggiornamento_remoto_dati.png") <uc-config-crm>
\
#usecase(9.1, [Gestione del fallback in assenza di connettività], [Utente], [
- Il dispositivo si trova in uno stato di assenza temporanea di connessione della rete o il server CRM RelAi risulta irragiungibile.
*Trigger:* Fallimento di una richiesta di aggiornamento dei dati in tempo reale.
], [
1. Il sistema rileva il fallimento della comunicazione di rete o l'assenza prolungata di connettività.
2. Il gestore delle API intercetta l'eccezione bloccando i tentativi non necessari e prevenendo la frammentazione della memoria RAM.
3. Il sistema legge in modo trasparente i dati precedentemente memorizzati nella cache persistente locale.
4. L'interfaccia grafica continua a mostrare l'ultimo stato valido degli eventi senza causare blocchi o riavvii anomali del display.
5. Il sistema avvia una procedura di tentativi schedulati di riconnessione in background.
], [
- Il dispositivo garantisce la continuità operativa in modalità _offline_ (fallback) sfruttando la cache locale.
- Il sistema riprende la sincronizzazione automatica non appena la connettività di rete viene ristabilita.
], image-path: "../../img/use_cases/UC9.1_Assenza_connettività_aggiornamento_remoto_dati.png") <uc-errore-crm>
\
#usecase(10, [Navigazione tra le schermate informative], [Utente], [
- Il dispositivo ESP32 è operativo.
- Il dispositivo ESP32 ha dei dati salvati da mostrare.
*Trigger:* Pressione dei pulsanti touch di navigazione o scadenza del timer di rotazione automatica; triplo tocco sullo schermo per abilitare/disabilitare la rotazione.
], [
1. Il sistema gestisce la rotazione automatica delle pagine in base al timer configurato (default 30 secondi, impostato remoto da CRM RelAi), oppure l'utente interagisce premendo i pulsanti freccia sulla barra di navigazione.
2. Il sistema esegue l'animazione di transizione tra la schermata corrente e la successiva.
3. L'utente visualizza la nuova schermata informativa o la pagina del menu diagnostico.
], [
- L'interfaccia grafica risponde fluidamente ai comandi di navigazione manuale o automatica.
- Lo stato della rotazione (attiva o in pausa) viene aggiornato visivamente sui pulsanti di controllo.
], image-path: "../../img/use_cases/UC10_Navigazione_schermate_informative.png") <uc-navigazione-schermate>
\
#usecase(11, [Visualizzazione dei dati nei pannelli informativi a display], [Utente], [
- Il dispositivo ESP32 è operativo.
- Il dispositivo ESP32 ha dei dati salvati da mostrare.
*Trigger:* Completamento dell'avvio del dispositivo e ricezione di nuovi dati.
], [
1. Il sistema esegue il rendering grafico dei pannelli degli eventi strutturati a schede.
2. Ciascun pannello mostra a schermo le informazioni principali dell'evento (nome dell'evento, contatore delle prenotazioni e dei partecipanti).
3. Il sistema genera e mostra la tile laterale associata contenente il codice QR dinamico di riferimento per l'evento.
4. L'utente consulta visivamente le informazioni o interagisce con il touch screen.
], [
- I dati aggiornati dell'evento risultano correttamente renderizzati e visibili a schermo con elevata fluidità visiva.
- Il sistema mantiene la rotazione attiva in base alle impostazioni correnti.
], image-path: "../../img/use_cases/UC11_Visualizzazione_dati_display.png") <uc-visualizzazione-display>

\
== Requisiti del sistema e stato di completamento <requisiti-del-sistema>

La definizione dei requisiti costituisce il fondamento dell'intero processo di progettazione del sistema. A partire dall'analisi del contesto aziendale, delle esigenze dei clienti e delle criticità tecniche legate all'hardware ESP32, sono stati individuati i requisiti funzionali, non funzionali e di vincolo necessari a garantire la corretta operatività del prototipo. L'obiettivo principale è stato la realizzazione di una soluzione in grado di mostrare informazioni rilevanti in modo affidabile, semplice e immediatamente leggibile, mantenendo un elevato livello di robustezza anche in condizioni di rete instabile o in presenza di aggiornamenti intermittenti da parte del sistema centrale.

In fase di sviluppo, tutti i requisiti individuati sono stati verificati in modo diretto e progressivo, con riferimento ai casi d'uso precedentemente definiti, alle attività di integrazione con RelAi e ai test eseguiti sul dispositivo. L'esito di questa valutazione ha confermato la completezza del sistema rispetto alle esigenze inizialmente dichiarate. Di conseguenza, il livello di copertura dei requisiti può essere considerato pienamente soddisfatto.

=== Requisiti funzionali e stato di attuazione <requisiti-funzionali>

I requisiti funzionali definiscono le capacità che il sistema deve mettere a disposizione dell'organizzazione cliente e dell'utente finale. Essi riguardano in particolare la configurazione del dispositivo, la lettura dei dati di evento, la visualizzazione dei contenuti sul display e la gestione delle operazioni di manutenzione.

Lo stato di attuazione dei requisiti funzionali è riepilogato nella @tab-requisiti-funzionali.

#figure(
  table(
  columns: (2cm, 1fr, 3.2cm),
  inset: 8pt,
  stroke: 0.5pt + rgb("b8b8bd"),
  fill: (_, row) => if calc.odd(row) { rgb("f5f5f7") } else { white },
  table.header([*Codice*], [*Requisito*], [*Stato*]),
  [RF01], [Configurazione iniziale della connessione Wi‑Fi tramite portale locale e salvataggio persistente delle credenziali.], [Completato],
  [RF02], [Abbinamento del dispositivo a RelAi e ricezione delle informazioni di configurazione e degli eventi.], [Completato],
  [RF03], [Visualizzazione sul display dei pannelli informativi relativi a iscritti, partecipanti, prenotazioni e codice QR.], [Completato],
  [RF04], [Rotazione automatica e navigazione manuale tra le schermate informative.], [Completato],
  [RF05], [Diagnostica locale del dispositivo con informazioni sullo stato della rete, dell'uptime e del firmware.], [Completato],
  [RF06], [Operazioni di manutenzione come riavvio, reset e condivisione della rete tramite QR Code.], [Completato],
  [RF07], [Gestione di fallback e cache locale in caso di assenza o instabilità della rete.], [Completato],
  [RF08], [Configurazione remota dei pannelli e della frequenza di aggiornamento da parte del CRM RelAi.], [Completato],
  ),
  caption: [Requisiti funzionali e stato di completamento],
) <tab-requisiti-funzionali>

=== Requisiti non funzionali, di qualità e vincolo <requisiti-qualita-vincolo>

I requisiti non funzionali descrivono le caratteristiche di qualità che un sistema embedded deve possedere per essere efficiente, affidabile e facilmente gestibile anche in contesti operativi reali. Tra questi, le criticità più rilevanti riguardano la stabilità del firmware, la reattività dell'interfaccia, l'usabilità del processo di configurazione e la sostenibilità del sistema sul lungo periodo.

I requisiti non funzionali e di vincolo sono riportati nella @tab-requisiti-non-funzionali.

#figure(
  table(
  columns: (2.2cm, 1fr, 3.2cm),
  inset: 8pt,
  stroke: 0.5pt + rgb("b8b8bd"),
  fill: (_, row) => if calc.odd(row) { rgb("f5f5f7") } else { white },
  table.header([*Codice*], [*Requisito*], [*Stato*]),
  [RNF01], [Affidabilità del sistema in presenza di disconnessioni temporanee e timeout nelle chiamate verso il CRM.], [Completato],
  [RNF02], [Robustezza del firmware con gestione degli errori, riconnessione automatica e recupero dalla cache locale.], [Completato],
  [RNF03], [Prestazioni adeguate per il rendering delle schermate e aggiornamento dei dati in tempo reale.], [Completato],
  [RNF04], [Usabilità delle operazioni locali per utenti non esperti, con procedure di approccio semplici e trasparenti.], [Completato],
  [RNF05], [Manutenibilità del codice e separazione dei moduli per facilitare aggiornamenti e test futuri.], [Completato],
  [RV01], [Esecuzione del sistema su piattaforma ESP32 con vincoli di memoria, potenza computazionale e rendering.], [Completato],
  [RV02], [Integrazione con l'ecosistema RelAi e compatibilità con i dati e i protocolli aziendali.], [Completato],
  [RV03], [Possibilità di configurazione del dispositivo anche senza accesso a internet tramite modalità locale.], [Completato],
  ),
  caption: [Requisiti non funzionali e di vincolo],
) <tab-requisiti-non-funzionali>

=== Conclusione sulla soddisfazione dei requisiti <conclusione-requisiti>

Dall'analisi condotta durante lo stage emerge che tutti i requisiti inizialmente individuati sono stati soddisfatti in modo completo, sia nei loro aspetti funzionali sia in quelli di qualità e di vincolo. La soluzione ottenuta dimostra quindi la validità dell'approccio progettuale adottato, confermando che il dispositivo embedded può essere integrato efficacemente con il CRM RelAi e utilizzare le risorse hardware disponibili in modo sostenibile ed efficiente.

In particolare, il sistema raggiunge l'obiettivo di trasformare dati aziendali complessi in informazioni facilmente leggibili e accessibili direttamente presso le sedi degli utenti, riducendo l'interazione richiesta e migliorando la fruibilità dell'informazione. La raggiunta completezza dei requisiti rappresenta inoltre una base solida per eventuali sviluppi futuri, come nuove tipologie di pannelli, aggiornamenti OTA o integrazioni con flussi dati ancora più avanzati.
\
#pagebreak()
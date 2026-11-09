#import "shared.typ": *

#pagebreak()
= Tecnologie utilizzate <tecnologie-utilizzate>
\
Questo capitolo descrive le principali tecnologie hardware e software adottate per realizzare il prototipo di interfaccia informativa integrato con il CRM RelAi. La scelta dei componenti è stata guidata dai requisiti individuati: disponibilità di un display interattivo, possibilità di comunicare tramite rete Wi‑Fi, compatibilità con un ambiente di sviluppo per microcontrollori e capacità di aggiornare i dati ricevuti dal sistema centrale.
\
La soluzione è stata sviluppata in C++ per microcontrollori della famiglia ESP32-S3, utilizzando la libreria grafica LVGL e l'ambiente di sviluppo PlatformIO. Per la comunicazione con il CRM RelAi è stato impiegato un canale WebSocket; la configurazione iniziale della rete avviene invece attraverso un Access Point generato dal dispositivo e un portale di provisioning locale.
\
== Piattaforma hardware <piattaforma-hardware>
\
Il dispositivo principale del prototipo è basato su ESP32-S3 ed è abbinato a un display rotondo da 1,75 pollici. Nel codice, questa configurazione sfrutta le specifiche impostazioni di pinout e driver ottimizzate per il chip, gestendo l'interazione touch e la visualizzazione delle informazioni di stato, contatori e codici QR attraverso la libreria grafica.
\
In coerenza con il requisito di supporto a più tipologie di display, l'architettura software gestisce tramite PlatformIO e direttive di compilazione condizionale (o ambienti separati) anche una seconda scheda basata su ESP32-S3, abbinata a un display quadrato da 1,8 pollici. Questa separazione consente di mantenere un codice comune per la logica applicativa e le schermate LVGL, differenziando unicamente i driver di inizializzazione dello schermo e delle periferiche specifiche.
\
Il firmware coordina l'esecuzione dei task di sistema, la connettività Wi‑Fi in modalità AP e STA, la ricezione dei messaggi JSON via WebSocket e l'aggiornamento dell'interfaccia. Sulle piattaforme embedded, la gestione della memoria dinamica e la frequenza di refresh dello schermo richiedono particolare attenzione per garantire la fluidità del rendering, specialmente durante il disegno di elementi complessi come i codici QR.
\
#align(center)[
  #image("../../img/esp32s3-display-rotondo.jpg", width: 65%)
  #v(5pt)
  #emph([Figura 4.1 - Scheda ESP32-S3 con display rotondo da 1,75 pollici utilizzata come dispositivo principale.])
] <fig-esp32s3-rotondo>

\

#align(center)[
  #image("../../img/esp32-display-quadrato.jpg", width: 65%)
  #v(5pt)
  #emph([Figura 4.2 - Scheda ESP32-S3 con display quadrato da 1,8 pollici utilizzata per verificare il requisito facoltativo multi-display.])
] <fig-esp32-quadrato>

\
== Linguaggio C++ <linguaggio-cpp>
\
Il firmware è stato implementato in C++, sfruttando i paradigmi della programmazione orientata agli oggetti per suddividere l'applicazione in moduli riutilizzabili e manutenibili. Questa scelta architetturale facilita l'intergazione tra i driver delle periferiche, lo stack di rete e la libreria grafica, isolando le diverse responsabilità del sistema.
\
La gestione delle risorse a memoria limitata dell'ESP32-S3 ha richiesto un'attenta ottimizzazione nella scrittura del codice, volto a garantire un bilanciamento efficiente tra i task di elaborazione dati, la reattività la reattività della rete e la fluidità del rendering grafico sull'interfaccia.
\
#align(center)[
  #image("../../img/logo_c++.png", width: 45%)
  #v(5pt)
  #emph([Figura 4.3 - Logo del linguaggio di programmazione C++.])
] <fig-logo-cpp>
\
== PlatformIO <platformio>
\
Per configurare e gestire il progetto è stato utilizzato PlatformIO, ambiente di sviluppo integrato con Visual Studio Code. Lo strumento permette di dichiarare la piattaforma hardware di destinazione e le dipendenze del firmware, oltre a gestire le operazioni di compilazione e caricamento del programma sulla scheda.
\
La configurazione del progetto raccoglie i parametri necessari a riprodurre la toolchain e distingue le impostazioni comuni del firmware da quelle legate alle singole schede. PlatformIO è stato inoltre utilizzato nel ciclo iterativo di sviluppo: dopo ogni modifica, il firmware viene compilato e caricato sul dispositivo per verificare il comportamento effettivo dell'interfaccia e delle funzioni di rete.
\
#align(center)[
  #image("../../img/platformIO_logo.png", width: 45%)
  #v(5pt)
  #emph([Figura 4.4 - Logo dell'ambiente di sviluppo PlatformIO.])
] <fig-logo-platformio>
\
== LVGL e interfaccia grafica <libreria-grafica-lvgl>
\
Per la realizzazione dell'interfaccia grafica è stata adottata LVGL (_Light and Versatile Graphics Library_), una libreria ottimizzata per sistemi embedded con display. LVGL mette a disposizione widget predefiniti e strumenti per la costruzione di schermate interattive, la gestione degli eventi di input e il rendering efficiente delle aree dello schermo, evitando di implementare da zero le primitive grafiche di basso livello.
\
Nel progetto, la libreria viene impiegata per strutturare i pannelli informativi, visualizzare metriche, contatori e codici QR, gestire i menu di navigazione e le schermate diagnostiche. L'adozione di un pattern architetturale pulito separa la logica applicativa dai componenti di presentazione, facilitando l'aggiornamento dinamico dei contenuti in base ai messaggi ricevuti dal CRM e garantendo un'interazione coerente su entrambe le tipologie di display.
\
L'adattamento dell'interfaccia alle differenti geometrie dello schermo ha richiesto una configurazione mirata dei driver di visualizzazione e del modulo touch. Poiché il layout deve risultare perfettamente leggibile sia sul pannello circolare che su quello quadrato, gli elementi grafici sono stati disposti tenendo conto dei vincoli fisici dello spazio utile, valorizzando le peculiarità di ciascun formato senza compromettere l'usabilità.
\

#align(center)[
  #image("../../img/interfaccia-lvgl.png", width: 80%)
  #v(5pt)
  #emph([Figura 4.5 - Esempio dell'interfaccia realizzata con LVGL sul display del dispositivo.])
] <fig-interfaccia-lvgl>

\
== Connettività e protocolli <connettivita-protocolli>
\
La connettività wireless si basa sul protocollo Wi‑Fi e prevede una gestione progressiva degli stati di connessione. All'avvio, il dispositivo si trova inizialmente in uno stato non connesso e verifica la presenza di credenziali memorizzate nella memoria non volatile tramite la libreria Preferences, avviando la connessione in modalità station (STA) in background.
\
Nel caso in cui le credenziali non siano configurate o il tentativo di connessione iniziale fallisca, il sistema attiva la modalità di provisioning Access Point (AP), generando una rete dedicata (ESP32-Config) e avviando un server HTTP locale supportato da un DNSServer per la gestione del captive portal. Questo permette all'utente di accedere al portale e visualizzare la scansione delle reti circostanti per configurare i parametri corretti.
\
Una volta stabilita con successo la connessione alla rete dell'organizzazione, il dispositivo adotta un'architettura ibrida in modalità WIFI_AP_STA. In questa configurazione, l'Access Point rimane permanentemente attivo e accessibile in parallelo alla modalità STA, offrendo all'utente la costante possibilità di verificare, modificare o reinserire le credenziali in ogni momento senza interrompere il funzionamento ordinario.
\
La comunicazione in tempo reale con il CRM RelAi sfrutta un canale WebSocket persistente. A differenza delle richieste HTTP tradizionali, la connessione bidirezionale consente al dispositivo di ricevere istantaneamente aggiornamenti e comandi remoti, quali la sincronizzazione dei dati, il riavvio o il reset. I messaggi scambiati sono strutturati in formato JSON e vengono elaborati dal firmware per aggiornare dinamicamente lo stato del sistema.
\
In caso di interruzione temporanea della connettività o di irraggiungibilità del CRM, il sistema si avvale dei dati validi conservati nella cache locale, avviando al contempo routine di riconnessione automatica. Questo meccanismo di fallback garantisce la continuità visiva delle informazioni sui pannelli e riduce l'impatto dei disservizi di rete sulla fruibilità del prototipo.
\
== Persistenza e gestione dei dati <persistenza-gestione-dati>
\
Le impostazioni necessarie al funzionamento del dispositivo e i dati utilizzati per il recupero dell'ultimo stato valido sono conservati in memoria non volatile. Nei casi d'uso la memoria persistente è identificata come NVS (_Non-Volatile Storage_): essa permette di mantenere le configurazioni anche in seguito a un riavvio. La procedura di reset elimina le informazioni previste e riporta il dispositivo alla fase di configurazione iniziale.
\
I dati ricevuti dal CRM vengono elaborati dal firmware e confrontati con quelli già disponibili. Quando è necessario, la copia locale viene aggiornata e l'interfaccia viene ridisegnata per riflettere i nuovi contenuti. La cache locale svolge inoltre la funzione di fallback: in assenza di connettività permette di continuare a visualizzare le informazioni dell'ultima sincronizzazione valida.
\
== Controllo di versione e documentazione
\
Lo sviluppo e la documentazione richiedono strumenti che consentano di mantenere tracciabili le modifiche, organizzare i materiali del progetto e produrre elaborati aggiornabili. A questo scopo sono stati utilizzati Gitea per il controllo di versione e Typst per la stesura della documentazione.
\
=== Gitea
\
Gitea è stato utilizzato come piattaforma di gestione dei repository del progetto firmware. Il controllo di versione permette di conservare la cronologia delle modifiche, isolare gli interventi in branch dedicati e sottoporre le modifiche a revisione tramite pull request e code review. Come descritto nel capitolo dedicato ai processi, questa organizzazione supporta la collaborazione con il tutor e facilita l'individuazione delle modifiche introdotte durante le diverse fasi di sviluppo.
\
=== Typst per la redazione della documentazione
\
La documentazione tecnica è stata redatta in Typst, un sistema di composizione tipografica basato su markup. L'elaborato è suddiviso in file sorgente distinti per i capitoli e utilizza un file principale per configurare il documento e includere i contenuti. Questa struttura modulare rende più agevole aggiornare le singole parti e mantenere uniformi titoli, riferimenti, figure e tabelle.
\
La compilazione dei sorgenti produce il documento PDF destinato alla consultazione e alla consegna. L'uso di un formato testuale versionabile permette inoltre di tracciare le revisioni della documentazione insieme ai materiali del progetto e di rigenerare il PDF dopo gli aggiornamenti.
\
== Riepilogo dello stack tecnologico <riepilogo-stack-tecnologico>
\
La tabella seguente riassume i principali elementi tecnologici impiegati e il ruolo svolto all'interno del prototipo.
\
#table(
  columns: (3.2cm, 3.2cm, 6.5cm),
  inset: 7pt,
  stroke: 0.5pt + rgb("b8b8bd"),
  fill: (_, row) => if calc.odd(row) { rgb("f5f5f7") } else { white },
  table.header([*Ambito*], [*Tecnologia*], [*Utilizzo nel progetto*]),
  [Linguaggio], [C++], [Implementazione del firmware orientata agli oggetti e suddivisa in moduli manutenibili.],
  [Microcontrollore], [Famiglia ESP32-S3], [Esecuzione del firmware e gestione delle periferiche su schede dotate rispettivamente di display rotondo da 1,75 pollici e quadrato da 1,8 pollici.],
  [Interfaccia grafica], [LVGL], [Composizione delle schermate, gestione dei componenti visuali e degli input touch.],
  [Toolchain], [PlatformIO], [Configurazione del progetto, compilazione, caricamento e verifica del firmware.],
  [Rete locale], [Wi‑Fi AP e STA], [Gestione ibrida permanente con Access Point locale per il provisioning e connessione station verso la rete dell'organizzazione.],
  [Comunicazione cloud], [WebSocket e JSON], [Ricezione bidirezionale in tempo reale di aggiornamenti e comandi remoti dal CRM RelAi.],
  [Persistenza], [NVS e LittleFS], [Conservazione delle configurazioni tramite Preferences, cache eventi e salvataggio del logo su file system.],
  [Controllo versione], [Gitea], [Gestione dei repository, cronologia delle modifiche, branch e revisioni del codice.],
  [Documentazione], [Typst], [Redazione modulare della documentazione tecnica e generazione del documento PDF.],
)
#align(center)[#emph([Tabella 4.1 - Riepilogo delle tecnologie utilizzate.])]
\
Le tecnologie descritte costituiscono la base per le successive attività di progettazione e implementazione del firmware. In particolare, la piattaforma hardware basata su ESP32-S3 e LVGL definiscono il contesto della presentazione grafica, mentre l'architettura di rete ibrida Wi‑Fi, i canali WebSocket e i meccanismi di persistenza locale consentono un'integrazione resiliente con il CRM RelAi e la continuità del servizio.
#pagebreak()
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
Il dispositivo principale del prototipo è basato su ESP32-S3 ed è abbinato a un display rotondo da 1,75 pollici. Questa configurazione è stata scelta per realizzare un pannello compatto, dotato di interazione touch e adatto alla visualizzazione delle informazioni sintetiche previste dai casi d'uso, come contatori, stato del dispositivo e codici QR.
\
In coerenza con il requisito facoltativo di supporto a più tipologie di display, è stata inoltre utilizzata una seconda scheda ESP32 con display quadrato da 1,8 pollici. La disponibilità di due formati consente di verificare l'adattabilità dell'interfaccia a geometrie differenti e costituisce un primo passo verso il supporto di ulteriori dispositivi. Le due configurazioni condividono la piattaforma software grafica, mentre la gestione delle periferiche dipende dalle caratteristiche specifiche della scheda e del display.
\
Il microcontrollore gestisce l'esecuzione del firmware, la connettività Wi‑Fi, l'elaborazione dei dati e l'aggiornamento dell'interfaccia. Le risorse limitate rispetto a un sistema desktop richiedono attenzione nell'uso della memoria e nella frequenza di ridisegno, soprattutto durante la visualizzazione di elementi grafici come codici QR e animazioni.
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
Il firmware è stato scritto in C++, linguaggio che permette di organizzare il programma in componenti riutilizzabili e di interagire con le periferiche e le librerie disponibili per la piattaforma ESP32. Il codice coordina la gestione della rete, la ricezione e l'elaborazione dei dati, la logica di navigazione e il disegno dei pannelli sul display.
\
L'impiego di C++ consente di integrare la logica applicativa con le librerie per la grafica, la connettività e la gestione delle periferiche. La struttura del firmware deve tenere conto delle risorse limitate del microcontrollore e coordinare in modo efficiente l'elaborazione dei dati, gli aggiornamenti dell'interfaccia e le operazioni di rete.
\
#align(center)[
  #image("../../img/logo_c++.png", width: 30%)
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
  #image("../../img/platformIO_logo.png", width: 40%)
  #v(5pt)
  #emph([Figura 4.4 - Logo dell'ambiente di sviluppo PlatformIO.])
] <fig-logo-platformio>
\
== LVGL e interfaccia grafica <libreria-grafica-lvgl>
\
Per la realizzazione dell'interfaccia grafica è stata utilizzata LVGL (_Light and Versatile Graphics Library_), libreria orientata a sistemi embedded con display. LVGL fornisce componenti visuali e strumenti per costruire schermate interattive, gestire gli eventi di input e aggiornare le aree dello schermo senza dover implementare da zero tutte le primitive grafiche.
\
Nel progetto la libreria viene utilizzata per comporre i pannelli informativi, mostrare testo, contatori e codici QR, gestire gli elementi di navigazione e presentare le schermate diagnostiche. La separazione tra logica applicativa e componenti visuali facilita l'aggiornamento dei contenuti quando arrivano nuovi dati dal CRM e permette di mantenere coerente l'interazione sulle due tipologie di display.
\
L'integrazione con l'hardware richiede inoltre i driver adatti al pannello e al sistema di input touch della scheda. Le dimensioni e la forma dello schermo influenzano la disposizione degli elementi: i contenuti devono rimanere leggibili e accessibili sia nel formato rotondo sia in quello quadrato.
\

#align(center)[
  #image("../../img/interfaccia-lvgl.png", width: 70%)
  #v(5pt)
  #emph([Figura 4.5 - Esempio dell'interfaccia realizzata con LVGL sul display del dispositivo.])
] <fig-interfaccia-lvgl>

\
== Connettività e protocolli <connettivita-protocolli>
\
La connettività wireless è basata su Wi‑Fi e viene utilizzata sia durante la configurazione sia durante il funzionamento ordinario. Nella fase di provisioning il dispositivo opera in modalità Access Point (AP), creando una rete alla quale l'utente può collegarsi per aprire il portale locale e configurare le credenziali della rete dell'organizzazione. Dopo la configurazione, il dispositivo opera in modalità station (STA), collegandosi al punto di accesso disponibile per raggiungere il CRM RelAi.
\
L'Access Point mantiene disponibile la procedura di configurazione quando il dispositivo non è ancora associato a una rete o quando le credenziali non sono valide. I casi d'uso prevedono il mantenimento del portale durante gli errori di scansione o connessione, così che l'utente possa correggere i parametri senza dover intervenire sul firmware. Il reset di fabbrica riporta il dispositivo allo stato iniziale e rende nuovamente disponibile la modalità di provisioning.
\
La comunicazione in tempo reale con il CRM RelAi utilizza WebSocket. A differenza di una sequenza di richieste indipendenti, il canale WebSocket consente di mantenere una connessione persistente attraverso la quale il dispositivo può ricevere aggiornamenti e comandi remoti, come la sincronizzazione dei dati, il riavvio e il reset. I messaggi applicativi descritti nei casi d'uso sono rappresentati in formato JSON; il firmware interpreta il contenuto e aggiorna i dati locali o lo stato del dispositivo.
\
Quando la connessione al CRM o alla rete non è disponibile, il sistema utilizza i dati validi conservati localmente e avvia tentativi di riconnessione. Questo comportamento consente ai pannelli di continuare a mostrare l'ultimo stato noto e limita l'impatto delle interruzioni temporanee sulla fruizione delle informazioni.
\
== Persistenza e gestione dei dati <persistenza-gestione-dati>
\
Le impostazioni necessarie al funzionamento del dispositivo e i dati utilizzati per il recupero dell'ultimo stato valido sono conservati in memoria non volatile. Nei casi d'uso la memoria persistente è identificata come NVS (_Non-Volatile Storage_): essa permette di mantenere le configurazioni anche in seguito a un riavvio. La procedura di reset elimina le informazioni previste e riporta il dispositivo alla fase di configurazione iniziale.
\
I dati ricevuti dal CRM vengono elaborati dal firmware e confrontati con quelli già disponibili. Quando è necessario, la copia locale viene aggiornata e l'interfaccia viene ridisegnata per riflettere i nuovi contenuti. La cache locale svolge inoltre la funzione di fallback: in assenza di connettività permette di continuare a visualizzare le informazioni dell'ultima sincronizzazione valida.
\
== Controllo di versione e documentazione <strumenti-versionamento-documentazione>
\
Lo sviluppo e la documentazione richiedono strumenti che consentano di mantenere tracciabili le modifiche, organizzare i materiali del progetto e produrre elaborati aggiornabili. A questo scopo sono stati utilizzati Gitea per il controllo di versione e Typst per la stesura della tesi.
\
=== Gitea <gitea>
\
Gitea è stato utilizzato come piattaforma di gestione dei repository del progetto firmware. Il controllo di versione permette di conservare la cronologia delle modifiche, isolare gli interventi in branch dedicati e sottoporre le modifiche a revisione tramite _pull request_ e _code review_. Come descritto nel capitolo dedicato ai processi, questa organizzazione supporta la collaborazione con il tutor e facilita l'individuazione delle modifiche introdotte durante le diverse fasi di sviluppo.
\
#align(center)[
  #image("../../img/gitea_logo.png", width: 25%)
  #v(5pt)
  #emph([Figura 4.6 - Logo dell'ambiente di sviluppo Gitea.])
] <fig-logo-gitea>
\
=== Typst per la redazione della tesi <typst-documentazione>
\
La documentazione finale è stata redatta in Typst, un sistema di composizione tipografica basato su markup. La tesi è suddivisa in file sorgente distinti per i capitoli e utilizza un file principale per configurare il documento e includere i contenuti. Questa struttura modulare rende più agevole aggiornare le singole parti e mantenere uniformi titoli, riferimenti, figure e tabelle.
\
La compilazione dei sorgenti produce il documento PDF destinato alla consultazione e alla consegna. L'uso di un formato testuale versionabile permette inoltre di tracciare le revisioni della documentazione insieme ai materiali del progetto e di rigenerare il PDF dopo gli aggiornamenti.
\
#align(center)[
  #image("../../img/typst_logo.png", width: 25%)
  #v(5pt)
  #emph([Figura 4.7 - Logo dell'ambiente di sviluppo Typst.])
] <fig-logo-typst>
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
  [Linguaggio], [C++], [Implementazione del firmware e della logica applicativa.],
  [Microcontrollore], [ESP32-S3 e scheda ESP32], [Esecuzione del firmware e gestione delle periferiche; rispettivamente con display rotondo da 1,75 pollici e quadrato da 1,8 pollici.],
  [Interfaccia grafica], [LVGL], [Composizione delle schermate, gestione dei componenti visuali e degli input touch.],
  [Toolchain], [PlatformIO], [Configurazione del progetto, compilazione, caricamento e verifica del firmware.],
  [Rete locale], [Wi‑Fi AP e STA], [Provisioning locale tramite Access Point e collegamento del dispositivo alla rete dell'organizzazione in modalità station.],
  [Comunicazione cloud], [WebSocket e JSON], [Ricezione di aggiornamenti e comandi dal CRM RelAi tramite messaggi applicativi.],
  [Persistenza], [NVS e cache locale], [Conservazione delle configurazioni e dei dati necessari al ripristino dell'ultimo stato valido.],
  [Controllo versione], [Gitea], [Gestione dei repository, cronologia delle modifiche, branch e revisioni del codice.],
  [Documentazione], [Typst], [Redazione modulare della tesi e generazione del documento PDF.],
)
#align(center)[#emph([Tabella 4.1 - Riepilogo delle tecnologie utilizzate.])]
\
Le tecnologie descritte costituiscono la base per le successive attività di progettazione e implementazione del firmware. In particolare, la piattaforma hardware e LVGL definiscono il contesto della presentazione grafica, mentre Wi‑Fi, WebSocket e la persistenza locale consentono l'integrazione con RelAi e la continuità del servizio.
#pagebreak()
#import "shared.typ": *

#pagebreak()
= Processi, metodologie e strumenti <processi-metodologie>
\
Il presente capitolo approfondisce il quadro metodologico e gli strumenti adottati nel corso delle 300 ore di stage svolto presso *Spazio Dev S.r.l.* (con sede a Tombolo, Padova). L'azienda è una realtà fortemente orientata allo sviluppo software di qualità e all'innovazione tecnologica, che promuove un ambiente collaborativo basato sulla condivisione delle competenze e sul miglioramento continuo. 
\
Per affrontare la complessità dello sviluppo _embedded_ e garantire standard qualitativi coerenti con le esigenze aziendali, l'attività è stata pianificata seguendo un approccio strutturato. L'integrazione del prototipo basato su microcontrollore ESP32 con la piattaforma CRM RelAi ha richiesto non solo competenze tecniche di programmazione e interfacciamento con API, ma anche una rigorosa aderenza ai flussi di lavoro interni, garantendo il rispetto delle tempistiche e un costante allineamento sugli obiettivi strategici del prodotto.
\
== Pianificazione e ripartizione delle attività <pianificazione-e-ripartizione-delle-attivita>
\
Il percorso di stage è stato distribuito nell'arco di otto settimane (sette settimane da 40 ore e una settimana finale da 20 ore), per un totale di 300 ore complessive. Le attività sono state pianificate bilanciando la fase di studio iniziale, lo sviluppo del firmware e la validazione finale. La progressione temporale si articola nelle seguenti fasi:
\
- Prima Settimana - Analisi iniziale e setup (40 ore): onboarding sul progetto, configurazione dell'ambiente di lavoro e del repository, raccolta dei requisiti con il tutor e comprensione dei casi d'uso principali.
- Seconda Settimana - Studio dell'ESP32, del display e delle librerie grafiche (40 ore): studio dell'architettura del microcontrollore e del display, configurazione della toolchain e valutazione delle librerie grafiche e per i codici QR.
- Terza Settimana - Configurazione iniziale del dispositivo: provisioning WiFi e reset (40 ore): implementazione dell'avvio in modalità access point con portale di configurazione, salvataggio persistente e reset alle impostazioni di fabbrica.
- Quarta Settimana - Abbinamento a RelAi, client API e cache locale (40 ore): sviluppo della procedura di abbinamento al CRM, del client verso le API, della gestione degli errori e della cache locale dell'ultimo dato valido.
- Quinta Settimana - Pannello codice QR e gestione delle schermate (40 ore): generazione e rendering del codice QR e realizzazione della macchina a stati per la gestione delle schermate di stato e di errore.
- Sesta Settimana - Pannelli contatori e prenotazioni, rotazione automatica (40 ore): sviluppo dei pannelli relativi a iscritti, partecipanti e prenotazioni, con rotazione automatica e rifinitura grafica.
- Settima Settimana - Configurazione remota, diagnostica e robustezza (40 ore): recupero della configurazione da RelAi, esposizione della pagina di diagnostica locale e introduzione di meccanismi di robustezza come il _watchdog_ e la riconnessione automatica.
- Ottava Settimana - Test, rifinitura e confronto finale (20 ore): esecuzione dei test funzionali e di durata prolungata, correzione dei bug, stesura della relazione finale e preparazione della demo conclusiva.
\
A supporto della pianificazione temporale, la ripartizione analitica delle ore in base all'impegno richiesto dai singoli moduli è definita come segue:
\
- *18 ore:* Onboarding, analisi dei requisiti e definizione dei pannelli informativi con il tutor aziendale.
- *14 ore:* Setup dell'ambiente di sviluppo (toolchain ESP32, repository, strumenti di flashing e di test).
- *30 ore:* Studio della piattaforma ESP32, del display e delle librerie grafiche e per la generazione dei codici QR.
- *22 ore:* Progettazione dei layout dei pannelli e analisi delle API di RelAi e dei dati da visualizzare.
- *38 ore:* Provisioning della rete Wi-Fi con portale di configurazione, salvataggio persistente delle impostazioni e reset del dispositivo.
- *28 ore:* Abbinamento del dispositivo a RelAi, gestione delle credenziali di accesso e del ciclo di vita dell'associazione.
- *28 ore:* Client verso le API, aggiornamento periodico dei dati, cache locale e sincronizzazione dell'ora.
- *45 ore:* Rendering dei pannelli sul display (codice QR, contatori e prenotazioni evento) e gestione delle schermate di stato.
- *18 ore:* Configurazione remota dei pannelli da RelAi e pagina di diagnostica locale del dispositivo.
- *14 ore:* Robustezza del dispositivo (watchdog, riconnessione, riavvio automatico) e predisposizione dell'aggiornamento del firmware.
- *25 ore:* Test funzionali e di durata sul dispositivo, bug fixing e miglioramenti grafici.
- *20 ore:* Documentazione tecnica, relazione finale e preparazione della presentazione.
\
== Requisiti e obiettivi <requisiti-e-obiettivi>
\
Per dimensionare correttamente il progetto rispetto alle trecento ore di stage e monitorare il grado di completamento delle funzionalità, gli obiettivi e i requisiti sono stati classificati in tre livelli gerarchici:
\
=== Requisiti Obbligatori (O) <requisiti-obbligatori>
\
- *O01 (Analisi e Progettazione):* Analizzare i requisiti dei pannelli informativi e progettare l'interfaccia del dispositivo, definendo i dati da mostrare, la frequenza di aggiornamento e i vincoli imposti dal display.
- *O02 (Configurazione e Provisioning):* Realizzare la procedura di configurazione iniziale del dispositivo, comprendendo il provisioning della rete Wi-Fi tramite portale di configurazione, il salvataggio persistente delle impostazioni e la funzione di reset alle impostazioni di fabbrica.
- *O03 (Integrazione CRM e API):* Sviluppare l'abbinamento del dispositivo al CRM RelAi e implementare il client verso le API aziendali, garantendo l'aggiornamento periodico dei dati e la cache locale dell'ultimo valore valido.
- *O04 (Visualizzazione e Gestione Stati):* Visualizzare sul display il codice QR, il contatore degli iscritti, il contatore dei partecipanti e le prenotazioni dell'evento, implementando schermate dedicate per gestire gli stati di errore e l'assenza di rete.
- *O05 (Validazione e Documentazione):* Eseguire test funzionali e di durata prolungata sul dispositivo, redigendo contestualmente la documentazione tecnica e la relazione finale di stage.
\
=== Requisiti Desiderabili (D) <requisiti-desiderabili>
\
- *D01 (Configurazione Remota):* Permettere la configurazione remota da RelAi dei pannelli mostrati e dell'intervallo di aggiornamento, evitando la necessità di riflashare il dispositivo.
- *D02 (Diagnostica Locale):* Esporre una pagina di diagnostica locale servita direttamente dal dispositivo, utile per monitorare lo stato della rete, l'ultima sincronizzazione, la versione del firmware e per attivare azioni di riavvio e reset.
- *D03 (Rotazione Automatica):* Introdurre la rotazione automatica tra più pannelli attivi configurando intervalli di durata personalizzabili.
- *D04 (Aggiornamento Firmware OTA):* Predisporre meccanismi di aggiornamento del firmware over-the-air (OTA) con controllo della versione disponibile.
\
=== Requisiti Facoltativi (F) <requisiti-facoltativi>
\
- *F01 (Aggiornamento Near-Real-Time):* Sostituire o integrare l'aggiornamento periodico con un flusso di dati _near-real-time_ basato su protocolli come WebSocket o MQTT.
- *F02 (Check-in Partecipanti):* Gestire la registrazione del check-in dei partecipanti a un evento mostrando sul pannello un codice QR identificativo, che il socio può inquadrare con il proprio smartphone per completare la registrazione lato server su RelAi.
- *F03 (Supporto Multi-display e Temi):* Estendere il supporto ad altri modelli di display e introdurre la personalizzazione grafica dei pannelli tramite temi e loghi dell'organizzazione.
\
== Modello Agile e gestione iterativa <modello-agile-e-gestione-iterativa>
\
L'organizzazione del lavoro ha ripreso i principi chiave delle metodologie *Agile*, suddividendo lo sviluppo complessivo in cicli iterativi brevi orientati al rilascio incrementale delle funzionalità. Questo approccio ha permesso di validare progressivamente i singoli componenti del sistema — dalla connettività Wi-Fi al rendering grafico su display — riducendo i rischi di regressione e consentendo correzioni tempestive in corso d'opera.
\
La comunicazione e la collaborazione con il tutor aziendale (Matteo Forzan) sono state strutturate attraverso incontri periodici fissati con cadenza regolare (due o tre volte a settimana), articolati secondo una precisa suddivisione dei ruoli operativi:
\
- *Primo incontro (inizio settimana):* dedicato alla pianificazione e revisione dei task settimanali, con l'individuazione dei pannelli o delle funzionalità da realizzare, la stima dell'impegno richiesto e l'assegnazione delle priorità operative in base agli obiettivi dello stage.
- *Incontro intermedio (metà settimana):* volto all'analisi tecnica e alla risoluzione di dubbi o criticità emerse durante lo sviluppo, con particolare focus sui colli di bottiglia legati alla connettività del dispositivo e al rendering sul display.
- *Ultimo incontro (fine settimana):* finalizzato alla verifica delle mansioni svolte attraverso test empirici e prove dirette dei pannelli sul dispositivo fisico, alla raccolta di feedback costruttivi e alla validazione dello stato di avanzamento rispetto al cronoprogramma.
\
In aggiunta ai momenti di confronto, il codice sorgente del firmware ESP32 è stato sottoposto a regolari sessioni di *code review* con il tutor. Tale pratica ha garantito un costante controllo sulla qualità del codice, sulla leggibilità, sul rispetto delle convenzioni di stile e sulla correttezza funzionale prima di procedere all'integrazione definitiva.
\
== Issue Tracking e Controllo di Versione <issue-tracking-e-controllo-di-versione>
\
Per il monitoraggio delle attività, la pianificazione operativa e la gestione centralizzata del codice sorgente, sono stati adottati strumenti open-source moderni ed efficienti, perfettamente integrati nei flussi di lavoro aziendali:
\
- *Controllo di versione:* La gestione del codice è stata affidata a *Gitea*, che ha ospitato i repository del progetto. Il flusso di lavoro è stato modellato attraverso l'uso di branch dedicati per singola funzionalità o correzione (`feature/`), l'apertura sistematica di _pull request_ mirate e la supervisione tramite code review. Questa organizzazione ha permesso di isolare le modifiche sperimentali, preservare la stabilità del ramo principale e mantenere una cronologia pulita e tracciabile di tutte le evoluzioni del software.
- *Issue Tracking:* La tracciabilità e la pianificazione delle attività giornaliere e settimanali sono state gestite mediante la piattaforma *Plane*. Ogni requisito funzionale o correzione di bug è stato censito sotto forma di _issue_, suddiviso in task granulari e associato a specifiche etichette di priorità. Questo strumento ha consentito di monitorare visivamente lo stato di avanzamento delle 300 ore di stage, offrendo un riscontro immediato sul carico di lavoro corrente e facilitando la rendicontazione delle attività svolte.
\

== Analisi preventiva dei rischi <analisi-preventiva-dei-rischi>

Prima dell'avvio dello sviluppo, sono stati identificati i principali fattori di rischio associati all'hardware e all'integrazione software, definendo contestualmente le relative strategie di mitigazione:
\ \

- *Complessità di integrazione hardware-software e concorrenza:*
  - *Descrizione:* La gestione simultanea del rendering grafico avanzato sul display e delle comunicazioni di rete asincrone con le API del CRM poteva generare colli di bottiglia o blocchi del microcontrollore.
  - *Mitigazione:* Adozione di un'architettura software strutturata in task paralleli, separando la logica di rete dalle routine di aggiornamento grafico e sincronizzando l'accesso alle risorse condivise in modo sicuro.
  - *Probabilità:* Media
  - *Impatto:* Alto
\ \

- *Gestione delle risorse, vincoli di memoria e resilienza di rete:*
  - *Descrizione:* I limiti fisici della memoria interna dell'ESP32 e la potenziale instabilità della connessione Wi-Fi in ambienti operativi reali.
  - *Mitigazione:* Ottimizzazione dell'uso della memoria RAM attraverso il rilascio mirato dei buffer grafici non utilizzati e implementazione della cache locale per garantire la continuità d'uso in caso di disconnessione temporanea della rete.
  - *Probabilità:* Media
  - *Impatto:* Medio-Alto
\ \

- *Evoluzione o instabilità delle API del CRM:*
  - *Descrizione:* Il rischio che modifiche impreviste agli endpoint o ai contratti delle API del sistema CRM esterno compromettessero la corretta ricezione e trasmissione dei dati.
  - *Mitigazione:* Astrazione del layer di comunicazione di rete tramite interfacce modulari e implementazione di robusti controlli di validazione e gestione delle eccezioni sui payload in ingresso e in uscita.
  - *Probabilità:* Bassa
  - *Impatto:* Alto
\ \ 

- *Prestazioni e fluidità dell'interfaccia grafica:*
  - *Descrizione:* La visualizzazione di informazioni aggiornate in tempo reale e la gestione delle animazioni dell'interfaccia potrebbero causare rallentamenti o ridurre la reattività del sistema sui dispositivi ESP32.
  - *Mitigazione:* Ottimizzazione dei componenti grafici, riduzione degli aggiornamenti non necessari e monitoraggio dell'utilizzo delle risorse durante le attività di sviluppo e test.
  - *Probabilità:* Media
  - *Impatto:* Medio
\ \ 

- *Disallineamento dei requisiti:*
  - *Descrizione:* Il rischio di discostarsi dalle aspettative aziendali o di accumulare criticità non previste durante il ciclo di vita del prototipo.
  - *Mitigazione:* Gestione costante attraverso gli incontri periodici e regolari di allineamento e le sessioni di revisione con il tutor aziendale.
  - *Probabilità:* Bassa
  - *Impatto:* Medio
\ \ 

- *Tempi di sviluppo superiori alle previsioni:*
  - *Descrizione:* La complessità del progetto, l'apprendimento di nuove tecnologie embedded e la risoluzione di problematiche hardware e software potrebbero richiedere un numero di ore superiore a quanto inizialmente stimato.
  - *Mitigazione:* Pianificazione incrementale delle attività, definizione delle priorità in funzione dei requisiti obbligatori e monitoraggio costante dell'avanzamento mediante incontri periodici con il tutor aziendale, così da individuare tempestivamente eventuali ritardi.
  - *Probabilità:* Media
  - *Impatto:* Medio-Alto
\ \ 
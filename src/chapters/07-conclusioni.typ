#import "shared.typ": *

#pagebreak()
= Conclusioni <conclusioni>
\
Il progetto di stage ha affrontato la progettazione e la realizzazione di un'interfaccia embedded capace di presentare su display le informazioni gestite dal CRM RelAi. Il lavoro ha integrato aspetti diversi: configurazione della rete, comunicazione con servizi remoti, persistenza locale dei dati, gestione di periferiche grafiche e progettazione dell'interazione touch. Le attività si sono svolte in modo iterativo, alternando implementazione, prove sulla macchina e confronto con il tutor aziendale.
\
== Consuntivo del progetto <consuntivo-progetto>
\
Il risultato dello stage è un prototipo basato su ESP32-S3, sviluppato per due configurazioni hardware con display da 1,75 e 1,8 pollici. Il firmware avvia un Access Point utilizzabile per la configurazione Wi-Fi, si collega alla rete dell'organizzazione quando sono disponibili credenziali valide e comunica con RelAi tramite heartbeat HTTP e WebSocket. I dati degli eventi ricevuti vengono organizzati in una cache locale persistente, così da poter essere consultati anche in seguito a riavvio o in assenza temporanea della rete.
\
Sul display vengono presentate schermate dedicate agli eventi, ai rispettivi codici QR, al logo dell'organizzazione e alle funzioni di menu e diagnostica. La navigazione può avvenire attraverso i controlli touch o mediante rotazione automatica. La separazione tra task di rete e task grafico, insieme alla sincronizzazione dell'accesso a LVGL, consente di organizzare le operazioni concorrenti del sistema. Nel corso dello sviluppo sono state affrontate criticità specifiche dell'hardware, tra cui la persistenza del logo, la reattività dell'interfaccia durante le operazioni di rete e la risposta del touch sulla variante da 1,8 pollici.
\
Il prototipo è stato compilato e provato sulle schede fisiche. Il collaudo ha compreso l'interazione diretta con display e touch, le procedure di provisioning, l'osservazione degli aggiornamenti ricevuti e il recupero dei dati locali. La verifica è stata prevalentemente manuale e qualitativa: il repository non contiene test automatici e non sono disponibili misurazioni sistematiche delle prestazioni o della stabilità a lungo termine. Il risultato va pertanto considerato una base funzionante verificata sui dispositivi disponibili, non una certificazione di prodotto per il rilascio in produzione.
\
== Raggiungimento degli obiettivi <raggiungimento-obiettivi>
\
Gli obiettivi fondamentali dello stage, relativi alla visualizzazione delle informazioni su hardware embedded e all'integrazione con RelAi, sono stati concretizzati nel prototipo. Sono presenti la configurazione Wi-Fi locale, la ricezione e la visualizzazione degli eventi, la generazione dei codici QR, la navigazione tra schermate e il recupero della cache dopo una disconnessione o un riavvio. La validazione svolta sulla macchina ha permesso di controllare questi flussi nel contesto d'uso reale, includendo le differenze tra le due varianti di display.
\
Alcuni obiettivi devono essere interpretati con maggiore cautela. La comunicazione near-real-time è supportata dal canale WebSocket, ma la configurazione remota della rotazione non aggiorna necessariamente il timer già attivo, poiché il valore ricevuto viene conservato nel modulo API e letto alla creazione del timer. La diagnostica è disponibile sul display e tramite endpoint del portale locale, ma non tutte le informazioni rappresentano una reale ultima sincronizzazione con il CRM. L'aggiornamento OTA è predisposto e attivabile da comando remoto, ma non è attivo un controllo periodico autonomo e il percorso necessita di ulteriori misure di sicurezza. Inoltre, le diverse procedure di reset non cancellano esattamente lo stesso insieme di dati. Questi aspetti non annullano il raggiungimento degli obiettivi principali, ma definiscono con precisione il perimetro del prototipo e le funzionalità da consolidare.
\
== Competenze acquisite <competenze-acquisite>
\
L'attività ha permesso di approfondire lo sviluppo firmware in C++ su ESP32-S3 e l'organizzazione di applicazioni basate su FreeRTOS. In particolare, sono state acquisite competenze nella gestione di task concorrenti, mutex e risorse condivise, oltre che nell'integrazione di LVGL con display e controller touch differenti.
\
La parte di rete ha richiesto di lavorare con Wi-Fi in modalità AP e STA, server HTTP locale, DNS per il captive portal, richieste HTTP autenticate e connessioni WebSocket. È stata inoltre approfondita la gestione della memoria non volatile tramite NVS, del file system LittleFS e delle strategie di cache per mantenere disponibili i dati durante le interruzioni di rete. Il lavoro ha evidenziato l'importanza di verificare le ipotesi direttamente sul dispositivo: tempi di risposta, comportamento del touch e disponibilità di memoria dipendono dall'interazione tra firmware, librerie e componenti fisici.
\
Dal punto di vista del processo, lo sviluppo iterativo, le prove frequenti e il confronto con il tutor hanno consentito di rivedere le scelte tecniche sulla base dei problemi osservati. La documentazione dei moduli e la ricostruzione dei flussi di errore hanno contribuito a sviluppare un approccio più sistematico alla diagnosi e alla manutenzione del software embedded.
\
== Limiti e sviluppi futuri <sviluppi-futuri>
\
Prima di un eventuale impiego produttivo, il firmware dovrebbe essere sottoposto a un ciclo di verifica più ripetibile e documentato. Un primo intervento consiste nell'introdurre test automatici per il parsing dei payload, il confronto e la persistenza della cache, affiancati da prove d'integrazione degli endpoint e del flusso di aggiornamento con un ambiente CRM dedicato. Per le prove sulla macchina sarebbe utile conservare i log e annotare configurazione hardware, versione firmware, condizioni di rete ed esito, così da rendere confrontabili le sessioni.
\
Sul piano funzionale è opportuno uniformare le operazioni di reset, rendere effettivo l'aggiornamento delle impostazioni remote durante l'esecuzione e registrare un timestamp reale dell'ultima sincronizzazione riuscita. Le sessioni di durata dovrebbero inoltre monitorare in modo sistematico heap libero, blocco massimo disponibile, riavvii e perdita di connettività, per poter valutare la stabilità con dati osservabili.
\
La sicurezza richiede particolare attenzione: il codice esaminato contiene credenziali di autenticazione definite nel sorgente, disabilita la verifica dei certificati TLS per le richieste HTTPS e utilizza un client non cifrato per il download OTA. Un'evoluzione dovrebbe adottare credenziali individuali gestite fuori dal codice condiviso, autenticazione verificata del server e controllo d'integrità e autenticità del firmware prima dell'installazione. Anche l'Access Point di configurazione e gli endpoint locali dovrebbero essere protetti in modo adeguato al contesto di distribuzione.
\
Infine, il supporto alle due varianti hardware offre una base per ampliare la compatibilità con ulteriori display, mentre la personalizzazione dei pannelli, dei temi e delle informazioni visualizzate può essere sviluppata in accordo con le necessità delle organizzazioni clienti. Tali estensioni dovrebbero seguire una priorità chiara: consolidare prima sicurezza e affidabilità, quindi ampliare le funzionalità.
\
== Valutazione conclusiva <valutazione-conclusiva>
\
Il lavoro ha mostrato che è possibile portare informazioni provenienti da un CRM su un dispositivo compatto, configurabile localmente e utilizzabile senza interazione continua con un computer. La realizzazione ha richiesto di conciliare vincoli di memoria, aggiornamento grafico, connettività e differenze hardware, rendendo il collaudo fisico una parte essenziale del processo e non una semplice verifica finale.
\
Considero il risultato raggiunto un prototipo significativo rispetto agli obiettivi dello stage: le funzioni centrali sono state implementate e provate sulle schede disponibili, mentre i limiti emersi sono stati esplicitati e forniscono indicazioni concrete per il lavoro successivo. L'esperienza ha consolidato le competenze nello sviluppo embedded e ha mostrato quanto la qualità di una soluzione dipenda non solo dalla sua funzionalità nominale, ma anche dalla capacità di osservarne il comportamento reale, riconoscere i vincoli e documentare con precisione ciò che è stato verificato.

== Consuntivo finale
Esempio di aggiunta di un termine con glossario e acronimo:

Lorem _SDK_ (Software Development Kit) ipsum dolor.

Nel successivo utilizzo apparira solo l'acronimo:

Lorem _SDK_.

Nel caso si voglia invece mettere solo il termine per esteso:

Lorem _Software Development Kit_.

== Raggiungimento degli obiettivi
Esempio di termine con solo acronimo: Lorem _TSA_, ipsum dolor sit amet.

Termine costruito senza acronimo: _Nome del termine_, ipsum dolor sit amet.

== Conoscenze acquisite
Lorem ipsum dolor, Lorem _API_.

Lorem ipsum dolor, Lorem _Application Program Interface_.

Si puo consultare la sezione Glossario per alcuni esempi di utilizzo.

== Valutazione personale


== Valutazione personale

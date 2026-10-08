#import "shared.typ": *

#pagebreak()

= Processi e metodologie <processi-metodologie>

Questo capitolo descrive i processi, le metodologie di sviluppo e gli strumenti adottati durante il periodo di stage curricolare, della durata complessiva di 300 ore, per la realizzazione del prototipo di interfaccia ESP32 integrato con il CRM RelAi. L'adozione di un approccio ingegneristico strutturato ha permesso di coniugare i vincoli tipici dello sviluppo _embedded_ con standard di qualità aziendali elevati.

== Descrizione del contesto aziendale <descrizione-contesto>

Il presente lavoro di stage si è svolto presso *Spazio Dev S.r.l.*, con sede a Tombolo (Padova), una realtà aziendale fortemente orientata allo sviluppo software di qualità, all'innovazione tecnologica e all'adozione di metodologie di lavoro strutturate. L'azienda promuove un ambiente collaborativo in cui la condivisione delle competenze e il miglioramento continuo rappresentano pilastri fondamentali per la crescita professionale dei team e la riuscita dei progetti.

All'interno di questo ecosistema, le attività si sono inserite nello sviluppo di un prototipo basato su microcontrollore ESP32 integrato con la piattaforma CRM RelAi. Questo progetto ha richiesto non solo competenze tecniche di programmazione embedded e interfacciamento con API, ma anche una rigorosa aderenza ai flussi di lavoro interni, garantendo il rispetto delle tempistiche e un costante allineamento sugli obiettivi tecnici e strategici del prodotto.

=== Modello Agile e gestione iterativa
L'organizzazione del lavoro ha ripreso i principi delle metodologie *Agile*, suddividendo lo sviluppo complessivo in cicli iterativi brevi orientati al rilascio incrementale delle funzionalità. La comunicazione e la collaborazione con il tutor aziendale (Matteo Forzan) sono state strutturate attraverso incontri regolari (due o tre volte a settimana):
- *Primo incontro (inizio settimana):* dedicato alla definizione e revisione dei task settimanali, con l'individuazione dei pannelli da realizzare e delle risorse necessarie.
- *Incontro intermedio:* volto a risolvere dubbi o criticità emerse nello sviluppo, in particolare sulla connettività e sul rendering grafico.
- *Ultimo incontro (fine settimana):* per verificare le mansioni svolte tramite prova diretta sul dispositivo e raccogliere feedback costruttivi.

Inoltre, il codice firmware è stato sottoposto a regolari sessioni di _code review_ da parte del tutor per verificarne la qualità, la leggibilità e la correttezza funzionale.

=== Issue Tracking e Controllo di Versione
Per il monitoraggio delle attività e la gestione del codice sorgente sono stati adottati strumenti standard di mercato:
- *Controllo di versione:* Gestione tramite *Git* con flussi di lavoro basati su branch dedicati, _pull request_ e revisioni del codice.
- *Issue Tracking:* Tracciabilità delle attività giornaliere e settimanali tramite piattaforme di gestione dei task.

== Analisi preventiva dei rischi
Prima dell'avvio dello sviluppo, sono stati identificati i principali fattori di rischio associati all'hardware e all'integrazione software, definendo contestualmente le relative strategie di mitigazione:

- *Complessità di integrazione hardware-software e concorrenza:* La gestione simultanea del rendering grafico avanzato tramite la libreria LVGL sul display touch e delle comunicazioni di rete asincrone con le API del CRM RelAi poteva generare colli di bottiglia o blocchi del microcontrollore. 
  - *Mitigazione:* Adozione di un'architettura software basata su *FreeRTOS* in ambiente dual-core, separando nettamente il Core 0 (connettività, chiamate di rete e provisioning) dal Core 1 (rendering grafico e gestione del touch), sincronizzati in modo sicuro tramite l'uso di appositi mutex.

- *Gestione delle risorse, vincoli di memoria e resilienza di rete:* I limiti fisici della memoria interna dell'ESP32-S3 e la potenziale instabilità della connessione Wi-Fi in scenari operativi reali. 
  - *Mitigazione:* Implementazione di un fallback dinamico per l'allocazione dei buffer di display (dalla SRAM interna alla PSRAM esterna) e utilizzo della memoria non volatile (NVS) tramite la libreria `Preferences` per il salvataggio sicuro delle credenziali e la cache locale dei dati (partner ed eventi), garantendo la continuità d'uso in caso di disconnessione temporanea.

- *Disallineamento dei requisiti:* Il rischio di discostarsi dalle aspettative aziendali o di accumulare criticità non previste. 
  - *Mitigazione:* Gestito attraverso gli incontri periodici e regolari di allineamento con il tutor aziendale.

== Requisiti e obiettivi
Al fine di dimensionare correttamente il progetto rispetto alle trecento ore di stage, le attività sono state classificate in tre livelli:
- *Requisiti Obbligatori (O):* Analisi dei pannelli, provisioning della rete Wi-Fi, abbinamento a RelAi, client API con cache locale, visualizzazione dei contenuti principali (codice QR, contatore iscritti, contatore partecipanti e prenotazioni evento), test funzionali e documentazione.
- *Requisiti Desiderabili (D):* Configurazione remota dei pannelli da RelAi, pagina di diagnostica locale, rotazione automatica tra più pannelli e predisposizione dell'aggiornamento OTA del firmware.
- *Requisiti Facoltativi (F):* Aggiornamento near-real-time (WebSocket/MQTT), registrazione check-in tramite codice QR per i partecipanti, e supporto a più modelli di display.

== Pianificazione e ripartizione delle attività

Il percorso di stage è stato distribuito nell'arco di otto settimane (sette settimane da 40 ore e una settimana finale da 20 ore), per un totale di 300 ore complessive. Le attività sono state pianificate bilanciando la fase di studio iniziale, lo sviluppo firmware e la validazione finale, integrando la progressione temporale con la seguente ripartizione analitica delle ore:
- *Analisi iniziale e setup (32 ore totali):* suddivise tra l'onboarding e l'analisi dei requisiti con il tutor (18 ore) e il setup dell'ambiente di sviluppo e della toolchain ESP32 (14 ore).
- *Studio hardware e progettazione (52 ore totali):* dedicate allo studio dell'architettura ESP32, del display e delle librerie grafiche e per i codici QR (30 ore), affiancate alla progettazione dei layout e all'analisi delle API di RelAi (22 ore).
- *Connettività e provisioning (66 ore totali):* 38 ore dedicate al provisioning della rete Wi-Fi con portale di configurazione e salvataggio persistente, e 28 ore per l'abbinamento del dispositivo al CRM e la gestione delle credenziali.
- *Sviluppo applicativo e interfaccia (73 ore totali):* 28 ore per lo sviluppo del client API, la cache locale e la sincronizzazione temporale, e 45 ore focalizzate sul rendering dei pannelli a display e sulla gestione delle schermate di stato.
- *Robustezza, diagnostica e test (57 ore totali):* 18 ore per la configurazione remota e la diagnostica locale, 14 ore per i meccanismi di robustezza e aggiornamento OTA, e 25 ore di test funzionali, di durata e risoluzione bug.
- *Documentazione finale (20 ore totali):* per la stesura della relazione tecnica e la preparazione della presentazione.

Questo piano di marcia è stato costantemente supervisionato attraverso i riscontri periodici con il tutor aziendale, garantendo il rispetto delle scadenze e la qualità del prototipo realizzato.
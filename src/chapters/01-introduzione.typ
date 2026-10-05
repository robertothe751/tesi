#import "shared.typ": *

= Introduzione <introduzione>
\
La gestione in tempo reale delle informazioni legate agli eventi e alle organizzazioni rappresentano un requisito fondamentale per l'efficienza dei sistemi aziendali moderni. La necessità di esporre dati aggiornati in modo affidabile si estende spesso anche al di fuori dei tradizionali client software, richiedendo l'impiego di soluzioni hardware dedicate collocate presso le sedi delle organizzazioni clienti.

\

Questo elaborato presenta il progetto di stage svolto presso l'azienda *Spazio Dev S.r.l.*, situata a Tombolo (Padova), avente a oggetto lo sviluppo di un'interfaccia utente su microcontrollori ESP32 dotati di display . Il sistema è progettato per comunicare direttamente con *RelAi*, il CRM aziendale , visualizzando in tempo reale informazioni chiave quali codici QR, prenotazioni di eventi, il contatore degli iscritti a un'organizzazione e il contatore dei partecipanti a un evento .
\
== L’azienda
\
Spazio Dev S.r.l. opera nel settore dello sviluppo software e della consulenza informatica, offrendo soluzioni tecnologiche avanzate per la gestione aziendale e dei flussi operativi. Il progetto di stage si inserisce nel contesto dell'ecosistema software aziendale, integrandosi con la piattaforma CRM RelAi per estendere le funzionalità di monitoraggio e interazione visiva direttamente su dispositivi _embedded_ installati presso gli utenti finali .
\
== Il progetto e gli obiettivi
\
Il progetto prevede la realizzazione di un firmware robusto e di un'interfaccia grafica ottimizzata per dispositivi ESP32 . Gli obiettivi dello stage sono suddivisi in requisiti obbligatori, desiderabili e facoltativi, definiti in accordo con il tutor aziendale Matteo Forzan .
\
I *requisiti obbligatori* comprendono:
- *O01:* L'analisi dei requisiti dei pannelli informativi e la progettazione dell'interfaccia, tenendo conto dei vincoli di risoluzione, memoria e prestazioni del display.
- *O02:* La realizzazione della procedura di configurazione iniziale, inclusi il provisioning della rete Wi-Fi tramite portale dedicato, il salvataggio persistente delle impostazioni e la funzione di reset.
- *O03:* L'abbinamento del dispositivo al CRM RelAi e lo sviluppo del client per il consumo delle API aziendali, supportato da un aggiornamento periodico e da una cache locale dell'ultimo dato valido.
- *O04:* La visualizzazione sul display dei codici QR, dei contatori (iscritti e partecipanti) e delle prenotazioni degli eventi, gestendo opportunamente le schermate di stato e di errore (come l'assenza di rete).
- *O05:* L'esecuzione di test funzionali e di durata sull'hardware, completati dalla stesura della documentazione tecnica.
\
Tra i *requisiti desiderabili* figurano la configurazione remota dei pannelli direttamente da RelAi, l'esposizione di una pagina di diagnostica locale, la rotazione automatica tra più schermate e la predisposizione per l'aggiornamento del firmware _over-the-air_ (OTA). Sono inoltre previsti requisiti facoltativi orientati all'estensione delle funzionalità in tempo reale e al supporto multi-display.
\
== Perimetro e vincoli
\
Lo sviluppo su microcontrollore ESP32 impone vincoli rigorosi in termini di risorse computazionali, gestione della memoria e consumi energetici. Il sistema deve inoltre garantire un livello elevato di robustezza operativa in esercizio, gestendo scenari di disconnessione della rete Wi-Fi o interruzioni temporanee della comunicazione con le API di RelAi attraverso meccanismi di cache locale, riconnessione automatica e controllo tramite _watchdog_.
\
== Organizzazione dello stage
\
Il piano di attività ha una durata complessiva di 300 ore, suddivise indicativamente in otto settimane (dal 21 settembre al 20 novembre 2026)[cite: 17, 18]. Le prime settimane sono dedicate all'analisi preliminare, allo studio della piattaforma hardware ESP32 e delle librerie grafiche, per poi procedere con lo sviluppo incrementale del provisioning di rete, del client API, del rendering dei pannelli e delle funzioni di diagnostica e test finali[cite: 18].
\
== Organizzazione del testo
\
- Il *secondo capitolo* descrive i processi e le metodologie di sviluppo adottati.
- Il *terzo capitolo* presenta la descrizione dettagliata dello stage, degli obiettivi e della pianificazione temporale.
- Il *quarto capitolo* analizza approfonditamente i requisiti funzionali e di sistema.
- Il *quinto capitolo* tratta la progettazione architetturale e la codifica del firmware ESP32.
- Il *sesto capitolo* descrive le attività di verifica, validazione e testing sul campo.
- Il *settimo capitolo* riassume i risultati conseguiti e le conclusioni.
- L’*ottavo capitolo* raccoglie la bibliografia e i riferimenti sitografici.
\
Gli acronimi sono sciolti alla prima occorrenza e i termini tecnici o stranieri sono evidenziati in _corsivo_.
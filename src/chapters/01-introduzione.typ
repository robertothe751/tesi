#import "shared.typ": *

= Introduzione <introduzione>
\
La gestione in tempo reale delle informazioni legate agli eventi e alle organizzazioni rappresentano un requisito fondamentale per l'efficienza dei sistemi aziendali moderni. La necessità di esporre dati aggiornati in modo affidabile si estende spesso anche attraverso l'impiego di soluzioni hardware dedicate collocate presso le sedi delle organizzazioni clienti senza richiedere l'utilizzo diretto di computer o applicazioni gestionali.

\

Questo elaborato presenta il progetto di stage svolto presso l'azienda *Spazio Dev S.r.l.*, situata a Tombolo (Padova), avente a oggetto lo sviluppo di un'interfaccia utente su microcontrollori ESP32 dotati di display. Il sistema è progettato per comunicare direttamente con *RelAi*, il CRM aziendale, visualizzando in tempo reale informazioni chiave quali codici QR, prenotazioni di eventi, il contatore degli iscritti ad un'organizzazione e il contatore dei partecipanti ad un evento.
\
== L’azienda
\
Spazio Dev S.r.l. opera nel settore dello sviluppo software e della consulenza informatica, offrendo soluzioni tecnologiche avanzate per la gestione aziendale e dei flussi operativi. Il progetto di stage si inserisce nel contesto dell'ecosistema software aziendale, integrandosi con la piattaforma CRM RelAi per estendere le funzionalità di monitoraggio e interazione visiva direttamente su dispositivi _embedded_ installati presso gli utenti finali .
\
== Il progetto
\
L'attività di stage riguarda la progettazione e lo sviluppo di una piattaforma firmware per microcontrollori ESP32 dotati di display. I dispositivi realizzati devono essere in grado di comunicare con il CRM RelAi e di presentare informazioni aggiornate in tempo reale mediante un'interfaccia grafica semplice e facilmente leggibile.
\
La soluzione proposta prevede l'utilizzo di pannelli informativi intelligenti capaci di visualizzare differenti tipologie di contenuto, tra cui codici QR, informazioni relative agli eventi e dati statistici riguardanti organizzazioni e partecipanti. Il progetto comprende inoltre tutti gli aspetti necessari alla configurazione, all'integrazione e alla gestione operativa dei dispositivi.
\
== Obiettivi dello stage
\
Lo stage si pone l'obiettivo di sviluppare una soluzione affidabile e facilmente utilizzabile, in grado di collegare il mondo dei sistemi gestionali aziendali con quello dei dispositivi embedded.
\
Le attività previste comprendono:

- l'analisi dei requisiti funzionali e tecnici del sistema;
- lo studio della piattaforma hardware ESP32 e delle tecnologie software necessarie;
- la progettazione dell'architettura firmware;
- lo sviluppo dell'interfaccia grafica e dei meccanismi di comunicazione con il CRM;
- la verifica del corretto funzionamento della soluzione mediante attività di test;
- la produzione della documentazione tecnica relativa al progetto.
\
Nel corso delle prime settimane di attività è stata svolta un'intensa fase di analisi e studio preliminare, finalizzata alla comprensione della piattaforma hardware, delle librerie software e delle modalità di integrazione con il sistema RelAi. Tale fase costituisce la base per le successive attività di sviluppo e validazione previste dal piano di lavoro.
\
== Perimetro e vincoli
\
Lo sviluppo su microcontrollore ESP32 impone vincoli rigorosi in termini di risorse computazionali, gestione della memoria e consumi energetici. Il sistema deve inoltre garantire un livello elevato di robustezza operativa in esercizio, gestendo scenari di disconnessione della rete Wi-Fi o interruzioni temporanee della comunicazione con le API di RelAi attraverso meccanismi di cache locale, riconnessione automatica e controllo tramite _watchdog_.
\
== Organizzazione dello stage
\
Il piano di attività ha una durata complessiva di 300 ore, suddivise indicativamente in otto settimane (dal 21 settembre al 20 novembre 2026). Le prime settimane sono dedicate all'analisi preliminare, allo studio della piattaforma hardware ESP32 e delle librerie grafiche, per poi procedere con lo sviluppo incrementale del provisioning di rete, del client API, del rendering dei pannelli e delle funzioni di diagnostica e test finali.
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
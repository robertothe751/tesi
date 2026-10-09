#import "shared.typ": *

= Introduzione <introduzione>
\
La gestione operativa delle organizzazioni e il monitoraggio in tempo reale delle attività aziendali richiedono spesso di coordinare flussi informativi complessi, tradizionalmente confinati all'interno di piattaforme software gestionali o pannelli web di controllo. Quando sorge l'esigenza di rendere questi indicatori immediatamente accessibili in contesti fisici distribuiti — come uffici, postazioni di accoglienza o spazi espositivi — l'utilizzo di soluzioni hardware dedicate consente di superare l'attrito dei sistemi tradizionali, offrendo informazioni visive immediate senza la necessità di postazioni informatiche complesse.

\

Questo elaborato presenta il progetto di stage svolto presso l'azienda *Spazio Dev S.r.l.*, che prevede la realizzazione e lo sviluppo di un prototipo di dispositivo interattivo basato su microcontrollore e display, progettato per integrarsi direttamente con la piattaforma CRM *RelAi*. Il progetto prende come riferimento i requisiti operativi e l'architettura aziendale, ponendosi l'obiettivo di verificare la fattibilità e l'efficacia di un'interfaccia _embedded_ per la visualizzazione in tempo reale di dati chiave quali iscrizioni, metriche di eventi e codici di servizio attraverso un prototipo funzionante.
\
== L’azienda <lazienda>
\
Spazio Dev S.r.l. opera nel settore dello sviluppo software e della consulenza informatica, offrendo soluzioni tecnologiche avanzate per la gestione aziendale e dei flussi operativi. Il progetto di stage si inserisce nel contesto dell'ecosistema software aziendale, integrandosi con la piattaforma CRM RelAi per estendere le funzionalità di monitoraggio e interazione visiva direttamente su dispositivi _embedded_ installati presso gli utenti finali 

#v(0.5cm)

#figure(
  image("../../img/logo_spaziodev.jpeg", width: 50%),
  caption: [Logo di Spazio Dev S.r.l.],
).
\
== Il progetto <il-progetto>
\
L'attività di stage riguarda la progettazione e lo sviluppo di una piattaforma firmware per microcontrollori ESP32 dotati di display. I dispositivi realizzati devono essere in grado di comunicare con il CRM RelAi e di presentare informazioni aggiornate in tempo reale mediante un'interfaccia grafica semplice e facilmente leggibile.
\
La soluzione proposta prevede l'utilizzo di pannelli informativi intelligenti capaci di visualizzare differenti tipologie di contenuto, tra cui codici QR, informazioni relative agli eventi e dati statistici riguardanti organizzazioni e partecipanti. Il progetto comprende inoltre tutti gli aspetti necessari alla configurazione, all'integrazione e alla gestione operativa dei dispositivi.
\
== Obiettivi dello stage <obiettivi-dello-stage>
\
Lo stage si pone l'obiettivo di sviluppare una soluzione affidabile e facilmente utilizzabile, in grado di collegare il mondo dei sistemi gestionali aziendali con quello dei dispositivi embedded.
\
Le attività previste comprendono:

- l'analisi dei requisiti funzionali e tecnici del sistema;
- lo studio della piattaforma hardware ESP32 e delle tecnologie software necessarie;
- la progettazione dell'architettura del sistema;
- lo sviluppo dell'interfaccia grafica e dei meccanismi di comunicazione con il CRM;
- la verifica del corretto funzionamento della soluzione mediante attività di test;
- la produzione della documentazione tecnica relativa al progetto.
\
Nel corso delle prime settimane di attività è stata svolta un'intensa fase di analisi e studio preliminare, finalizzata alla comprensione della piattaforma hardware, delle librerie software e delle modalità di integrazione con il sistema RelAi. Tale fase costituisce la base per le successive attività di sviluppo e validazione previste dal piano di lavoro.
\
== Perimetro e vincoli <perimetro-e-vincoli>
\
Lo sviluppo su microcontrollore ESP32 impone vincoli rigorosi in termini di risorse computazionali e gestione della memoria. Il sistema deve inoltre garantire un livello elevato di robustezza operativa in esercizio, gestendo scenari di disconnessione della rete Wi-Fi o interruzioni temporanee della comunicazione con le API di RelAi attraverso meccanismi di cache locale, riconnessione automatica e controllo tramite _watchdog_.
\
== Organizzazione dello stage <organizzazione-dello-stage>
\
Il piano di attività ha una durata complessiva di 300 ore, suddivise indicativamente in otto settimane (dal 21 settembre al 20 novembre 2026). Le prime settimane sono dedicate all'analisi preliminare, allo studio della piattaforma hardware ESP32 e delle librerie grafiche, per poi procedere con lo sviluppo incrementale del provisioning di rete, del client API, del rendering dei pannelli e delle funzioni di diagnostica e test finali.
\
== Organizzazione del testo <organizzazione-del-testo>
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
\
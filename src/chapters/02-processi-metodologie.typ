
#import "shared.typ": *

#pagebreak()

= Processi e metodologie <processi-metodologie> //= Descrizione delle metodologie <descrizione-metodologie>
\
Questo capitolo descrive i processi, le metodologie di sviluppo e gli strumenti adottati durante il periodo di stage per la realizzazione del prototipo di interfaccia ESP32 integrato con il CRM RelAi. 
//L'organizzazione del lavoro è stata strutturata per garantire un elevato standard qualitativo, una costante tracciabilità delle attività e un confronto strutturato e regolare con il tutor aziendale.
\

== Descrizione del contesto aziendale
Spazio Dev adotta modelli organizzativi orientati alla qualità e alla collaborazione continua. In questo contesto, le attività di sviluppo del prototipo ESP32 integrato con il CRM RelAi sono state pianificate per garantire tracciabilità e confronto costante con il tutor aziendale.

=== Modello Agile e gestione iterativa
L'organizzazione del lavoro riprende i principi delle metodologie Agile, suddividendo lo sviluppo in cicli iterativi orientati al rilascio incrementale delle funzionalità.

=== Issue Tracking e Controllo di Versione
Per il monitoraggio delle attività e la gestione del codice sorgente sono stati adottati strumenti standard di mercato, affiancati da flussi di lavoro strutturati basati su pull request e code review.

== Analisi preventiva dei rischi
Prima dell'avvio dello sviluppo, sono stati identificati i principali fattori di rischio associati all'hardware e all'integrazione software:
- *Complessità di integrazione hardware-software:* criticità legate alla comunicazione tra i dispositivi ESP32 e le API del CRM RelAi.
- *Gestione delle risorse e dei vincoli energetici/di rete:* possibili limitazioni operative dell'hardware in scenari reali.
- *Disallineamento dei requisiti:* mitigato attraverso incontri periodici e regolari di allineamento con il tutor aziendale.

== Requisiti e obiettivi
Le attività sono state classificate in obiettivi obbligatori, desiderabili e facoltativi per garantire il corretto dimensionamento del progetto rispetto alle ore di stage previste.

== Pianificazione
=== Ripartizione delle attività
Il percorso di stage è stato distribuito nell'arco delle settimane previste, bilanciando la fase di studio iniziale, la prototipazione firmware/software e la validazione finale sul campo.

=== Interazione con l’azienda e il tutor
Il confronto costante con il tutor ha permesso di monitorare l'avanzamento dei task e di correggere tempestivamente eventuali ostacoli tecnici incontrati durante lo sviluppo.


/*
Lorem ipsum:

#figure(```c
#include <stdio.h>
int main() {
    print("Hello, world!");
    return 0;
}
```, caption: [Example of code], kind: raw) <listing-b-3>
*/
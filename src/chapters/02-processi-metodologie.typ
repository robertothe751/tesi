#import "shared.typ": *

#pagebreak()

= Processi e metodologie <processi-metodologie>
\
Questo capitolo descrive i processi, le metodologie di sviluppo e gli strumenti adottati durante il periodo di stage per la realizzazione del prototipo di interfaccia ESP32 integrato con il CRM RelAi. L'organizzazione del lavoro è stata strutturata per garantire un elevato standard qualitativo, una costante tracciabilità delle attività e un confronto strutturato e regolare con il tutor aziendale.
\
== Processo sviluppo prodotto
\
Lo sviluppo del firmware e delle interfacce grafiche è stato condotto seguendo un approccio iterativo e incrementale, suddiviso nelle otto settimane previste dal piano di attività. Tale suddivisione ha permesso di procedere per milestone progressive:
+ *Fase preliminare:* analisi dei requisiti, studio della piattaforma hardware ESP32 e valutazione delle librerie grafiche e di generazione dei codici QR.
+ *Fase implementativa:* sviluppo modulare della configurazione di rete (provisioning Wi-Fi), integrazione del client API verso il CRM RelAi con gestione della cache locale, e rendering dei pannelli informativi sul display.
+ *Fase di chiusura:* implementazione dei meccanismi di robustezza (watchdog e riavvio automatico), test funzionali e di durata, e stesura della documentazione tecnica.


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
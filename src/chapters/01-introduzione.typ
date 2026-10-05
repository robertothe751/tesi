#import "shared.typ": *

= Introduzione <introduzione>

La vendita di titoli di accesso per conto di organizzatori terzi richiede di coordinare le operazioni di vendita con la gestione degli eventi e il controllo degli ingressi. Quando il sistema tratta titoli soggetti a specifici obblighi fiscali, i flussi applicativi devono inoltre tenere conto dei dati richiesti per i titoli, delle operazioni di annullamento e della registrazione dei movimenti.

Questo elaborato presenta il progetto di stage presso Spazio Dev S.r.l., che prevede la realizzazione di un prototipo di biglietteria automatizzata destinato alla vendita online di titoli di accesso. Il progetto prende come riferimento i requisiti normativi e l’architettura aziendale descritti nel piano di lavoro e ha come obiettivo la verifica dei flussi principali attraverso un prototipo, non la certificazione di un sistema pronto per l’esercizio.

== L’azienda

Spazio Dev S.r.l. ha sede a Tombolo, in provincia di Padova. Il progetto di stage riguarda un sistema di biglietteria da integrare con RelAi, il CRM aziendale. L’integrazione dovrà mettere in relazione le informazioni sugli organizzatori e sugli eventi con quelle relative alle vendite e agli accessi; la sua realizzazione è indicata nel piano di lavoro tra le attività da affrontare se il tempo disponibile lo consente.

== Il progetto e gli obiettivi

Il prototipo è pensato per permettere a organizzatori terzi di vendere titoli online con una modalità _white-label_, sul dominio di ciascun organizzatore. Il perimetro comprende la gestione dei dati di organizzatori, locali, eventi, prezzi e utenti, insieme alle operazioni sui titoli e alla registrazione delle transazioni.

Il piano di lavoro individua cinque obiettivi obbligatori: analizzare i requisiti normativi e l’architettura di riferimento; definire il modello dei dati e simulare la carta di attivazione; realizzare emissione, annullamento e registrazione dei movimenti; generare riepiloghi e funzioni di consultazione; verificare il prototipo con test funzionali e di concorrenza e documentarne risultati e limiti. L’analisi dei requisiti dovrà essere accompagnata da una matrice che colleghi ciascun requisito al componente interessato, ai test e alle relative evidenze.

Tra le estensioni desiderabili sono previsti la vendita online _white-label_, la gestione dei titoli nominativi e dei cambi nominativo, la rimessa in vendita e il controllo degli accessi. Il piano elenca inoltre, come attività facoltative compatibilmente con il tempo, l’emissione di _wallet pass_, la gestione delle procedure in caso di guasto e l’integrazione con RelAi.

== Perimetro e vincoli

Il riferimento normativo indicato nel piano comprende il D.M. 13 luglio 2000 e i provvedimenti dell’Agenzia delle Entrate del 23 luglio 2001, 22 ottobre 2002, 4 marzo 2008 e i numeri 223774/2019 e 356768/2025. La traduzione dei requisiti in funzionalità e verifiche è circoscritta al perimetro dello stage e sarà documentata nella matrice requisito, componente, test ed evidenza.

Le specifiche di interazione con la carta di attivazione sono fornite da SIAE su richiesta e il prototipo non è oggetto di certificazione durante lo stage. Di conseguenza, la carta di attivazione, il sigillo fiscale e il supporto immodificabile sono simulati e devono essere presentati come tali. La stessa cautela vale per le operazioni di firma indicate nel piano come simulate. Il prototipo ha quindi lo scopo di dimostrare i flussi _end-to-end_ previsti e di costituire una base tecnica per gli sviluppi successivi, non di attestare la conformità certificata del sistema definitivo.

== Organizzazione dello stage

Il piano prevede 300 ore complessive, distribuite su otto settimane, dal 28 settembre al 20 novembre 2026. Le prime attività sono dedicate allo studio dei requisiti e dell’architettura e alla configurazione dell’ambiente di sviluppo. Il lavoro prosegue con il modello dei dati, la simulazione della carta e le funzioni di emissione, annullamento, log e riepilogo; le settimane successive sono riservate alle estensioni di vendita online e controllo accessi, ai test, alla documentazione e alla presentazione finale.

L’avanzamento è organizzato con confronti regolari con il tutor aziendale, revisione delle attività e dimostrazioni dei flussi realizzati. Le tecnologie e lo stack applicativo sono da concordare con il tutor durante la fase di configurazione dell’ambiente; per questo motivo non vengono anticipati in questa introduzione.

== Organizzazione del testo

- Il *secondo capitolo* descrive i processi e le metodologie adottati.
- Il *terzo capitolo* presenta lo stage, i suoi obiettivi e la pianificazione.
- Il *quarto capitolo* analizza i requisiti.
- Il *quinto capitolo* tratta la progettazione e la codifica.
- Il *sesto capitolo* descrive la verifica e la validazione.
- Il *settimo capitolo* riassume i risultati e le conclusioni.
- L’*ottavo capitolo* raccoglie la bibliografia.

Gli acronimi sono sciolti alla prima occorrenza, quando necessario. I termini stranieri e quelli appartenenti al gergo tecnico sono riportati in _corsivo_.

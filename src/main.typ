#set document(
  title: "Interfaccia UI per dispositivi ESP32 per la visualizzazione di informazioni in tempo reale",
  author: "Roberto Mariano Doroftei",
  keywords: ("tesi", "informatica", "Università di Padova"),
)

#set page(
  paper: "a4",
  margin: (top: 2.75cm, bottom: 2.75cm, left: 3.75cm, right: 3cm),
  numbering: "i",
  number-align: center,
)
#set text(font: "New Computer Modern", size: 12pt, lang: "it")
#set par(justify: true, leading: 0.75em, first-line-indent: 1.25em)
#set heading(numbering: "1.1")
#set quote(block: true)
#set figure.caption(position: bottom)
#show figure.caption: set text(weight: "bold")

#import "chapters/shared.typ": *

// Frontespizio
#page(numbering: none)[
  #align(center)[
    #v(1.5cm)
    #text(size: 15pt, weight: "bold")[#uni]
    #v(5pt)
    #text(size: 13pt)[#smallcaps[#department]]
    #v(5pt)
    #text(size: 13pt)[#smallcaps[#facoltà]]
    #v(1.25cm)
    #image("../img/logo_unipd.jpeg", height: 6cm, alt: "Emblema dell'Universita degli Studi di Padova")
    #v(1cm)
    #text(size: 15pt, weight: "bold")[#titolo]
    #v(5pt)
    #text(size: 13pt, style: "italic")[#degree]
    #v(2cm)
    #grid(columns: (1fr, 1fr),
      align(left)[
        #emph[Relatore]\
        #relatore
      ],
      align(right)[
        #emph[Laureando]\
        #io\
        Matricola #matricola
      ],
    )
    #v(1fr)
    #line(length: 100%)\
    #text(size: 11pt)[#smallcaps[Anno Accademico #anno]]
  ]
]

// Frontmatter
#page(numbering: none)[
  #v(1fr)
  #text(size: 9pt)[© #io, #date. Tutti i diritti riservati. #degree: "#titolo", #uni, #department, #facoltà.]
]

#pagebreak()
/*
#align(right)[
  #emph["Colui il quale ha inseguito e sconfitto i demoni Sem, che ora vagano per il mondo, domandandosi: «ma nu, chi sem?»"]\
  #v(0.5em)
  --- Il grande Pdor, figlio di Kmer, della tribu di Ishtar, della terra desolata dei Kfnir, uno degli ultimi sette saggi: Pfulur, Galer, Astaparigna, Susar, Param, Fusus e Tarim.
]
#v(2em)
= Ringraziamenti <ringraziamenti>

Desidero esprimere la mia gratitudine al professor #relatore, mio relatore, per l'aiuto e il sostegno che mi ha dato durante la stesura dell'elaborato.

Vorrei anche ringraziare, con affetto, i miei genitori per il loro sostegno, il grande aiuto e la loro presenza in ogni momento durante gli anni di studio.

Desidero poi ringraziare i miei amici per i bellissimi anni trascorsi insieme e le mille avventure vissute.

#v(1em)
#align(right)[#location, #date \\ #emph[#io]]
*/

#set heading(numbering: none)

= Sommario <sommario>
\
Il presente elaborato descrive l'attività di stage svolta presso #azienda nell'ambito del progetto finalizzato alla realizzazione di un sistema basato su microcontrollori ESP32 per la visualizzazione in tempo reale delle informazioni gestite dal CRM aziendale RelAi.

L'obiettivo del progetto consiste nello sviluppo di una piattaforma firmware in grado di integrare dispositivi dotati di display con il sistema gestionale aziendale, permettendo l'esposizione di dati aggiornati relativi a organizzazioni ed eventi. Tra le informazioni previste figurano codici QR, prenotazioni, contatori degli iscritti e dei partecipanti, nonché ulteriori dati configurabili tramite il CRM.

L'attività di stage ha richiesto una fase preliminare di analisi dei requisiti e di studio delle tecnologie coinvolte, comprendente l'approfondimento dell'architettura ESP32, delle librerie grafiche per la realizzazione dell'interfaccia utente e delle modalità di comunicazione con i servizi software aziendali. Successivamente sono state affrontate le attività di progettazione dell'architettura della soluzione e della struttura del firmware, tenendo conto dei vincoli tipici dei sistemi embedded, quali risorse hardware limitate, affidabilità operativa e semplicità di configurazione.

Il documento presenta il contesto aziendale nel quale si colloca il progetto, descrive le metodologie adottate durante lo stage e approfondisce l'analisi dei requisiti funzionali e non funzionali del sistema. Vengono inoltre illustrate le principali scelte progettuali e implementative, con particolare attenzione agli aspetti relativi alla comunicazione con il CRM, alla gestione dell'interfaccia grafica e alla robustezza della soluzione. Infine, sono riportate le attività di verifica e validazione svolte, i risultati ottenuti e alcune possibili evoluzioni future del progetto.

L'elaborato conclude con una valutazione complessiva dell'esperienza di stage e del contributo formativo e professionale derivato dallo svolgimento del progetto.
\
#pagebreak()
= Ringraziamenti <ringraziamenti>

#pagebreak()
= Indice <indice>
#outline(title: none, depth: 5)

#pagebreak()
= Elenco delle figure <figure>
#outline(target: figure.where(kind: image), title: none)

#pagebreak()
= Elenco delle tabelle <tabelle>

#pagebreak()
#counter(page).update(1)
#set page(numbering: "1.")
#set heading(numbering: "1.1")

#include "chapters/01-introduzione.typ"
#include "chapters/02-processi-metodologie.typ"
#include "chapters/03-descrizione-stage.typ"
#include "chapters/04-analisi-requisiti.typ"
#include "chapters/05-progettazione-codifica.typ"
#include "chapters/06-verifica-validazione.typ"
#include "chapters/07-conclusioni.typ"
#include "chapters/08-bibliografia.typ"

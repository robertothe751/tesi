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
Il presente documento descrive il lavoro svolto durante il periodo di stage curricolare, della durata di trecento ore, dal laureando #io (matricola #matricola) presso l’azienda #azienda. Lo stage è stato condotto sotto la supervisione del tutor aziendale Matteo Forzan, mentre il #relatore ha ricoperto il ruolo di tutor accademico.

Questa tesi tratta la progettazione e lo sviluppo di un'interfaccia utente su microcontrollori ESP32 dotati di display, finalizzata alla visualizzazione in tempo reale delle informazioni gestite da RelAi, il CRM aziendale di #azienda. Il sistema permette di esporre dati chiave quali codici QR, prenotazioni di eventi, il contatore degli iscritti a un'organizzazione e il contatore dei partecipanti a un evento direttamente presso le sedi delle organizzazioni clienti.

Lo scopo del progetto è duplice: da un lato, realizzare un firmware robusto e ottimizzato per dispositivi _embedded_ con rigidi vincoli di memoria e risorse grafiche; dall'altro, implementare una connettività affidabile tramite provisioning Wi-Fi, gestione della cache locale dei dati e sincronizzazione periodica con le API aziendali, garantendo la continuità operativa anche in condizioni di assenza di rete.

Il testo è suddiviso in sette capitoli. Il primo capitolo introduce il contesto aziendale, gli obiettivi del progetto e la pianificazione complessiva dello stage. Il secondo capitolo descrive i processi, le metodologie di sviluppo adottate e le modalità di interazione e revisione con il tutor aziendale. Il terzo capitolo presenta l'analisi dei requisiti, l'analisi degli utenti e la modellazione dei casi d'uso. Il quarto capitolo illustra le scelte tecnologiche e i criteri adottati per lo sviluppo software ed _embedded_. Il quinto capitolo descrive l'architettura del firmware e l'implementazione dei moduli di connettività e provisioning. Il sesto capitolo approfondisce la realizzazione grafica dei pannelli, la gestione delle schermate e i meccanismi di robustezza, quali il _watchdog_ e la diagnostica locale. Infine, il settimo capitolo traccia le conclusioni, il consuntivo finale delle ore, i requisiti soddisfatti e le possibili evoluzioni future del progetto.
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

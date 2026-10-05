#let uni = [Università degli Studi di Padova]
#let department = [Dipartimento di Matematica "Tullio Levi-Civita"]
#let facoltà = [Corso di Laurea in Informatica]
#let titolo = [Interfaccia UI per dispositivi ESP32 per la visualizzazione di informazioni in tempo reale]
#let degree = [Tesi di Laurea]
#let relatore = [Prof. Zanella Marco]
#let io = [Roberto Mariano Doroftei]
#let matricola = [2111031]
#let anno = [2025-2026]
#let location = [Padova]
#let date = [Ottobre 2026]
#let azienda = [Spazio Dev S.r.l.]

#let placeholder = [
  Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget
  dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes,
  nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis,
  sem. Nulla consequat massa quis enim.
]

#let usecase(id, title, actors, pre, description, post, alternative: none) = {
  block(spacing: 1em)[
    *UC #id: #title*
    \
    *Attori principali:* #actors \
    *Precondizioni:* #pre \
    *Descrizione:* #description \
    *Postcondizioni:* #post
    if alternative != none [\
      *Scenario alternativo:* #alternative
    ]
  ]
}

#let risk(number, title, description, solution) = {
  block(spacing: 0.75em)[
    *#number. #title* \
    *Descrizione:* #description. \
    *Soluzione:* #solution.
  ]
}

#let requirement-table(rows, caption: none) = {
  table(
    columns: (2.25cm, 1fr, 2.25cm),
    inset: 6pt,
    stroke: 0.5pt + rgb("b8b8bd"),
    fill: (_, row) => if calc.odd(row) { rgb("f5f5f7") } else { white },
    table.header([*Requisito*], [*Descrizione*], [*Use Case*]),
    ..rows.flatten(),
  )
  if caption != none {
    align(center)[#emph(caption)]
  }
}

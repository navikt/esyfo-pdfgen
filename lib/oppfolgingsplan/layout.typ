// Shared layout components for follow-up plan documents.
#let text-color = rgb("#3e3832")
#let title-background = rgb("#e6f0ff")
#let separator-color = rgb("#cccccc")

#let is-present(value) = value != none and value != ""

#let multiline(value) = {
  for (index, line) in value.split("\n").enumerate() {
    if index > 0 {
      linebreak()
    }
    line
  }
}

#let document-layout(title: "", footer-title: title, body) = {
  set document(title: title)
  set page(
    paper: "a4",
    margin: (top: 48pt, bottom: 48pt, left: 48pt, right: 48pt),
    footer: context [
      #set text(size: 9pt)
      #grid(
        columns: (1fr, auto),
        column-gutter: 12pt,
        footer-title,
        [side #counter(page).display() av #counter(page).final().first()],
      )
    ],
  )
  set text(
    font: "Source Sans 3",
    lang: "nb",
    size: 9pt,
    fill: text-color,
    fallback: false,
  )
  set par(leading: 4pt)

  body
}

#let title-banner(body) = block(
  width: 100%,
  fill: title-background,
  inset: (x: 10pt, y: 10pt),
  breakable: false,
  text(size: 18pt, weight: "medium", body),
)

#let detail-row(label, value) = block(above: 7.5pt)[
  #strong(label): #multiline(value)
]

#let section-header(title, description: none) = block(
  above: 37.5pt,
  below: 7.5pt,
  breakable: false,
)[
  #text(size: 15pt, weight: "medium")[#title]
  #if is-present(description) {
    v(7.5pt)
    description
  }
]

#let answer-field(title, description: none, value) = block(above: 7.5pt)[
  #block(breakable: false)[
    #line(length: 100%, stroke: 0.75pt + separator-color)
    #v(7.5pt)
    #text(size: 10.5pt, weight: "bold")[#title]
    #if is-present(description) {
      v(7.5pt)
      strong(description)
    }
  ]
  #v(7.5pt)
  #multiline(value)
]

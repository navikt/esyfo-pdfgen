// Shared layout components for follow-up plan documents.
#let text-color = rgb("#3e3832")
#let title-background = rgb("#e6f0ff")
#let separator-color = rgb("#cccccc")

#let is-present(value) = value != none and value != ""

// Handlebars `{{#if}}` semantics.
#let is-truthy(value) = value not in (none, false, "", 0, ())

#let multiline(value) = {
  for (index, line) in value.split("\n").enumerate() {
    if index > 0 {
      linebreak()
    }
    line
  }
}

// Components carry no spacing of their own: templates set `above`/`below`
// (and gaps inside components), typically once with `.with()`.

// Page and text defaults. `footer-title` adds a footer with page numbers.
#let document-layout(
  title: "",
  footer-title: none,
  text-size: 12pt,
  leading: 6pt,
  paragraph-spacing: 1.2em,
  margin: 48pt,
  body,
) = {
  set document(title: title)
  set page(
    paper: "a4",
    margin: margin,
    footer: if footer-title != none {
      context [
        #set text(size: 9pt)
        #grid(
          columns: (1fr, auto),
          column-gutter: 12pt,
          footer-title,
          [side #counter(page).display() av #counter(page).final().first()],
        )
      ]
    },
  )
  set text(
    font: ("Source Sans 3", "Noto Color Emoji"),
    lang: "nb",
    size: text-size,
    fill: text-color,
    fallback: false,
  )
  set par(leading: leading, spacing: paragraph-spacing)

  body
}

#let styled-heading(level, size, weight, body) = {
  show heading: set text(size: size, weight: weight)
  show heading: set block(above: 0pt, below: 0pt)
  heading(level: level, bookmarked: false, body)
}

// Document title, optionally on a coloured banner.
#let title(body, size: 18pt, weight: "bold", background: none, inset: 0pt, above: 0pt, below: 0pt) = block(
  width: 100%,
  fill: background,
  inset: inset,
  breakable: false,
  above: above,
  below: below,
  styled-heading(1, size, weight, body),
)

#let section-title(body, description: none, description-gap: 0pt, size: 15pt, weight: "bold", above: 0pt, below: 0pt) = block(
  above: above,
  below: below,
  breakable: false,
)[
  #styled-heading(2, size, weight, body)
  #if is-present(description) {
    v(description-gap)
    description
  }
]

#let question(body, description: none, description-gap: 0pt, size: 10.5pt, weight: "bold", above: 0pt, below: 0pt) = block(
  above: above,
  below: below,
  breakable: false,
)[
  #styled-heading(3, size, weight, body)
  #if is-present(description) {
    v(description-gap)
    strong(description)
  }
]

// Renders nothing when the value is empty.
#let answer(value, size: auto, above: 0pt, below: 0pt) = if value != none and is-present(str(value)) {
  let content = multiline(str(value))
  block(above: above, below: below, if size == auto { content } else { text(size: size, content) })
}

#let separator(above: 0pt, below: 0pt) = block(
  above: above,
  below: below,
  line(length: 100%, stroke: 0.75pt + separator-color),
)

#let detail-row(label, value, above: 0pt, below: 0pt) = block(above: above, below: below)[
  #strong(label): #multiline(value)
]

#let text-line(value, above: 0pt, below: 0pt) = block(above: above, below: below, multiline(str(value)))

// Keeps its content on one page.
#let keep-together(above: 0pt, below: 0pt, body) = block(
  above: above,
  below: below,
  breakable: false,
  width: 100%,
  body,
)

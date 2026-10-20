// Shared look for the "Snart slutt på sykepenger" letters (mer veiledning).
#import "/lib/oppfolgingsplan/layout.typ" as base

#let letter-color = rgb("#262626")

#let letter-layout(title: "", body) = {
  show: base.document-layout.with(
    title: title,
    text-size: 13.5pt,
    text-fill: letter-color,
    leading: 12pt,
    paragraph-spacing: 0pt,
    margin: 40pt,
  )
  set list(indent: 18pt, body-indent: 8pt)
  show list: set block(above: 25.5pt, below: 25.5pt)

  body
}

#let title = base.title.with(size: 24pt, above: 29pt, below: 29pt)
#let section-title = base.section-title.with(size: 18pt, above: 27pt, below: 27pt)
#let paragraph = base.paragraph.with(above: 25.5pt, below: 25.5pt)
#let separator = base.separator.with(above: 19pt, below: 19pt)
#let framed = base.framed.with(stroke: 2.25pt + letter-color, breakable: false)

#let sent-date(date) = paragraph(below: 39pt)[Sendt #date]

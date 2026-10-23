// Domain-neutral, static Nav-style document components.
// Components have no outer spacing unless explicitly parameterised.
#import "/lib/common/layout.typ" as base

#let is-truthy = base.is-truthy
// HTML line boxes include space above the cap height and below the baseline.
// Keep that 12pt around each paragraph as well as the inter-line leading.
#let paragraph(body, above: 0pt, below: 0pt) = block(
  above: above, below: below, inset: (y: 6pt), body,
)
#let multiline = base.multiline
#let keep-together = base.keep-together
#let divider = base.separator.with(stroke: 1.5pt + rgb("707070"))
#let ink = rgb("#262626")
#let link-color = rgb(0, 103, 197)

#let nav-document(title: "", body) = {
  show: base.document-layout.with(
    title: title,
    text-size: 13.5pt,
    text-fill: ink,
    // Source CSS uses a 21pt baseline pitch at 13.5pt body size.
    // Source Sans' cap-height-to-baseline box is approximately 9pt.
    leading: 12pt,
    paragraph-spacing: 13.5pt,
    margin: 42pt,
  )
  set list(indent: 24pt, body-indent: 5pt, spacing: 12pt)
  show heading: set text(weight: "semibold")
  body
}

#let nav-heading(body, level: 2, size: auto, above: 0pt, below: 0pt) = {
  let size = if size != auto { size } else if level == 1 { 24pt } else if level == 2 { 15pt } else { 13.5pt }
  block(
    above: above, below: below, sticky: true,
    inset: (y: if size == 24pt { 7pt } else if size == 15pt { 3pt } else { 6pt }),
    base.styled-heading(level, size, "semibold", body),
  )
}

#let nav-link(dest, body) = text(fill: link-color, underline(link(dest, body)))

// Styled text is deliberately not a link when the source has no href.
#let underlined-label(body) = text(fill: rgb("0000cd"), underline(body))

#let alert-box(body, variant: "info", icon: false, decorative-icon: false, inset: 12pt, stroke: none, fill: auto, radius: 3pt, above: 0pt, below: 0pt) = {
  assert(variant in ("info", "success"), message: "Unknown alert variant")
  block(
    width: 100%, fill: if fill != auto { fill } else if variant == "success" { rgb(204, 241, 214) } else { rgb(216, 249, 255) },
    radius: radius, inset: inset, stroke: stroke, above: above, below: below,
  )[
    #if icon {
      grid(columns: (18pt, 1fr), gutter: 6pt,
        if decorative-icon {
          base.decorative-image("/resources/info-icon.svg", height: 18pt)
        } else {
          image("/resources/info-icon.svg", height: 18pt, alt: "Informasjon")
        },
        body,
      )
    } else { body }
  ]
}

#let button-label(body, above: 0pt, below: 0pt) = block(above: above, below: below)[
  #box(fill: link-color, stroke: 2.25pt + link-color, radius: 3pt, inset: (x: 6pt, y: 9pt), text(fill: white, body))
]

// Keep an 18pt-wide icon column and a 9pt cap-height-to-baseline box.
// Centre the source radio circles on the first line, even for wrapped labels.
// Selection is conveyed by image alt, never solely by colour or layout.
#let selection-icon(path, selected, size: 18pt) = box(
  width: 18pt,
  inset: (y: (9pt - size) / 2),
  align(center, image(path, height: size, alt: if selected { "Valgt" } else { "Ikke valgt" })),
)

#let radio-option(label, selected: false, help: none, above: 0pt, below: 0pt) = block(
  above: above, below: below, inset: (y: 6pt), breakable: false,
  grid(columns: (18pt, 1fr), column-gutter: 3pt,
    selection-icon(
      if selected { "/resources/radio-button-checked.svg" } else { "/resources/radio-button.svg" },
      selected, size: if selected { 18pt } else { 13pt },
    ),
    [#label#if selected and help != none { [ #text(fill: rgb("00459c"), help)] }],
  ),
)

#let checkbox(label, selected: false, above: 0pt, below: 0pt) = block(
  above: above, below: below, inset: (y: 6pt), breakable: false,
  grid(columns: (18pt, 1fr), column-gutter: 3pt,
    selection-icon(
      if selected { "/resources/checkbox.svg" } else { "/resources/checkbox-unchecked.svg" },
      selected,
    ),
    [#if not selected { [Ikke valgt: ] }#label],
  ),
)

#let expanded-heading(body, level: 2, size: auto, above: 0pt, below: 0pt) = nav-heading(
  [#base.decorative-image("/resources/chevron-up.svg", height: 7.5pt) #body],
  level: level, size: size, above: above, below: below,
)

#let expansion-card(title, body, description: none, level: 3, title-size: auto, gap: 18pt, above: 0pt, below: 0pt) = block(
  width: 100%, stroke: 1.5pt + ink, radius: 3pt,
  inset: (x: 12pt, top: 15pt, bottom: 18pt), above: above, below: below,
)[
  #nav-heading(
    grid(columns: (1fr, 18pt), column-gutter: 6pt,
      text(weight: "bold", title),
      base.decorative-image("/resources/chevron-up.svg", height: 7.5pt),
    ),
    level: level, size: title-size, below: gap,
  )
  #if description != none { paragraph(description, below: gap) }
  #divider(below: gap)
  #body
]

#let bullet-links(items, above: 0pt, below: 0pt) = block(
  above: above, below: below,
  list(..items.map(item => nav-link(item.at(0), item.at(1)))),
)

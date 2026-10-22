// Shared kartlegging content and the exact source skjemavariant dispatch.
#import "/lib/common/components.typ": *

#let p = paragraph.with(above: 13.5pt, below: 13.5pt)
#let h2 = nav-heading.with(above: 18pt, below: 15pt)
#let option = radio-option.with(below: 6pt)
#let rule = divider.with(above: 12pt, below: 12pt, stroke: 0.75pt + rgb("d2d2d2"))

#let introduction(letter) = {
  p(letter.at("createdAt", default: ""))
  nav-heading(level: 1, above: 18pt, below: 18pt)[Kartlegging av din situasjon]
}

// HTML collapses whitespace in ordinary interpolations (no breaklines helper).
#let html-text(value) = if value == none { "" } else {
  str(value).replace(regex("[ \\n]+"), " ")
}

#let snapshots(fields) = {
  for (index, field) in fields.enumerate() {
    keep-together(above: auto, below: 15pt, block(inset: (left: 15pt))[
      #paragraph(below: 15pt, text(weight: "semibold", html-text(field.at("label", default: ""))))
      #if field.at("fieldType", default: none) == "RADIO_GROUP" {
        for item in field.at("options", default: ()) {
          // The source eq helper compares nullable toString(), not strict types:
          // boolean true and string "true" both match checkedIfValueEquals="true".
          let selected = item.at("wasSelected", default: none) in (true, "true")
          option(
            html-text(item.at("optionLabel", default: "")),
            selected: selected, help: [(du valgte dette alternativet)],
          )
        }
      } else if field.at("fieldType", default: none) == "TEXT" {
        p(html-text(field.at("value", default: "")))
      }
    ])
    if index < fields.len() - 1 { rule() }
  }
}

#let questions = (
  tilbakeTilJobbenHvorSannsynligFlervalg: (
    label: "Hvor sannsynlig er det at du kommer tilbake i jobben du ble sykmeldt fra?",
    options: (
      "Jeg tror det er veldig sannsynlig",
      "Jeg tror det er lite sannsynlig",
      "Jeg er usikker",
    ),
  ),
  mulighetForTilbakeTilJobbenFlervalg: (
    label: "Hvordan ser du for deg muligheten for å komme tilbake til din nåværende jobb og stilling?",
    description: "Tenk over om du tror du kan komme helt eller delvis tilbake til din nåværende jobb og stilling, eller om du ser det som utfordrende.",
    options: (
      "Jeg har tro på at jeg kommer tilbake til samme jobb og stilling",
      "Jeg ser på det som utfordrende å komme tilbake til samme jobb og stilling",
    ),
  ),
  arbeidsgiverHvordanErSamarbeidFlervalg: (
    label: "Hvordan vil du beskrive samarbeidet og relasjonen mellom deg og arbeidsgiveren din?",
    options: (
      "Jeg opplever samarbeidet og relasjonen som god",
      "Jeg opplever samarbeidet og relasjonen som dårlig",
    ),
  ),
  arbeidsgiverFaarDuOppfolgingFlervalg: (
    label: "Får du oppfølging av arbeidsgiveren din nå når du er sykmeldt?",
    description: "Arbeidsgiveren din har hovedansvaret for å gjøre tilpasninger og følge deg opp på arbeidsplassen. Arbeidsgiver har for eksempel plikt til å lage en oppfølgingsplan med deg innen du har vært sykmeldt i fire uker. Derfor er det viktig at dere har tett kontakt når du er sykmeldt.",
    options: (
      "Ja, jeg får oppfølging, og har snakket med arbeidsgiver om dette.",
      "Nei, jeg opplever manglende oppfølging og at tilpasninger er vanskelig.",
    ),
  ),
  naarTilbakeTilJobbenFlervalg: (
    label: "Hvor lenge tror du at du kommer til å være sykmeldt?",
    description: "Vi vil vite hva du selv tror. Du kjenner din egen situasjon best.",
    options: ("Mindre enn seks måneder", "Mer enn seks måneder"),
  ),
)

#let form(variant) = {
  let order = if variant in (none, "FLERVALG_V2", "FLERVALG_V3", "FLERVALG_FRITEKST_V3", "FLERVALG_FRITEKST_V4") {
    ("mulighetForTilbakeTilJobbenFlervalg", "arbeidsgiverFaarDuOppfolgingFlervalg", "naarTilbakeTilJobbenFlervalg")
  } else if variant in ("FLERVALG_V1", "FLERVALG_FRITEKST_V1") {
    ("tilbakeTilJobbenHvorSannsynligFlervalg", "arbeidsgiverHvordanErSamarbeidFlervalg", "naarTilbakeTilJobbenFlervalg")
  } else if variant == "FLERVALG_FRITEKST_V2" {
    ("tilbakeTilJobbenHvorSannsynligFlervalg", "arbeidsgiverFaarDuOppfolgingFlervalg", "naarTilbakeTilJobbenFlervalg")
  } else { () }
  // Unknown variants deliberately render no form, matching Handlebars.
  if order.len() > 0 {
    block(inset: (x: 12pt, y: 3pt))[
      #for (index, key) in order.enumerate() {
        let question = questions.at(key)
        keep-together(above: auto, below: 6pt, {
          // These are labels, not headings, in the source.
          paragraph(below: 6pt, text(weight: "semibold", question.label))
          if "description" in question {
            paragraph(below: 6pt, text(fill: rgb("808080"), question.description))
          }
          for label in question.options { option(label) }
        })
        if index < order.len() - 1 { rule() }
      }
    ]
  }
}

#let receipt(letter) = {
  introduction(letter)
  alert-box(variant: "success", stroke: 1.5pt + ink)[
    #text(weight: "semibold")[Takk, svarene dine er sendt til Nav.] \
    Sendt: #letter.at("createdAt", default: "")
  ]
  p[Svarene dine gir Nav innsikt i hvordan vi skal følge deg opp fremover. Om vi ser behovet for tettere oppfølging enn det arbeidsgiveren din skal gi deg, vil du bli kontaktet av en Nav-veileder.]
  h2[Dette svarte du]
  // The source intentionally ignores snapshot descriptions and unknown types.
  snapshots(letter.at("fieldSnapshots", default: ()))
  h2[Informasjon fra Nav som kan være nyttig for deg]
  bullet-links((
    ("https://www.nav.no/sykmeldt#sykmeldiditt-ansvar-nar-du-er-sykmeldtngen", [Ditt ansvar når du er sykmeldt]),
    ("https://www.nav.no/sykepenger#oppfolging", [Arbeidsgiver sitt oppfølgingsansvar]),
  ))
  h2[Har du andre spørsmål?]
  p[Du kan ta kontakt med oss på telefon 55 55 33 33 eller #nav-link("https://www.nav.no/kontaktoss#skriv-til-oss")[skriv til oss her på nav.no] hvis det skulle være noe du lurer på.]
}

#let utsending(letter) = {
  introduction(letter)
  p[Siden du har vært sykmeldt en stund, ønsker vi å få bedre kjennskap til din situasjon ved at du svarer på disse tre spørsmålene. Dette gir Nav en bedre forståelse av om vi skal gi deg oppfølging i tillegg til den du skal få fra arbeidsgiveren din.]
  // Equivalent information is in the adjacent text; avoid announcing "info icon".
  alert-box(
    icon: true, decorative-icon: true, fill: rgb("e3eff7"),
    stroke: 0.75pt + rgb("457c9d"), radius: 9pt,
    inset: (x: 9pt, y: 9pt), above: 13.5pt, below: 13.5pt,
  )[Svarene blir kun synlige for Nav, og deles ikke med din arbeidsgiver.]
  form(letter.at("skjemavariant", default: none))
}

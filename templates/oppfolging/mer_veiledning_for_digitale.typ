#import "/lib/oppfolgingsplan/layout.typ": decorative-image, is-truthy
#import "/lib/oppfolging/mer-veiledning.typ": framed, letter-color, letter-layout, paragraph, section-title, sent-date, separator, title

#let data = json("/data/oppfolging/mer_veiledning_for_digitale.json")
#let letter = data.at("brevdata", default: (:))
#let get(key) = letter.at(key, default: none)

#let indented(body) = block(inset: (left: 22.5pt), above: 25.5pt, below: 25.5pt, body)
#let chevron-title(body) = section-title[#decorative-image("/resources/ChevronUp.png", height: 18pt) #body]
#let choice(body) = box(stroke: 2.25pt + letter-color, inset: (x: 9pt, y: 4pt), outset: (y: 6pt), body)

#show: letter-layout.with(title: "Snart slutt på sykepenger")

#if is-truthy(get("sendtdato")) {
  sent-date(get("sendtdato"))
}

#title[Snart slutt på sykepenger]

#if is-truthy(get("maxdato")) and is-truthy(get("utbetaltTom")) {
  paragraph[Per #get("utbetaltTom") er din siste dag med sykepenger beregnet til å være #strong(get("maxdato")).]
} else {
  framed(inset: (left: 12pt, top: 21.5pt, bottom: 19pt), above: 22.5pt, below: 25.5pt)[
    #section-title[Beklager, teknisk feil]
    #paragraph[
      På grunn av feil i systemene våre får vi ikke vist deg beregnet siste dag med sykepenger. \
      Vennligst prøv igjen litt senere.
    ]
    #paragraph[Kontakt teknisk brukerstøtte dersom problemene vedvarer.]
  ]
}

#section-title[Er du fortsatt syk?]
#paragraph[
  Hvis du ikke er frisk nok til å gå tilbake til jobb, kan du søke om arbeidsavklaringspenger (AAP) eller annen økonomisk støtte. \
  Du må selv søke om dette i god tid før sykepengene tar slutt. \
  Du kan også ha rettigheter hos forsikringsselskapet eller pensjonskassen din.
]

#separator()

#chevron-title[Kan du gå tilbake til jobben din?]
#indented[
  #paragraph[Arbeidsgiveren din skal, så langt det er mulig, tilpasse arbeidsplassen og oppgavene dine slik at du kan jobbe.]
  - Snakk med lederen din.
  - Det er arbeidsgiverens ansvar å legge til rette for at du kan jobbe.
  - Det er ditt ansvar å være med å finne løsninger slik at du kan komme tilbake til jobb.
]

#separator()

#chevron-title[Bør du bytte jobb?]
#indented[
  #paragraph[Av og til er det mulig å fungere bedre i en annen jobb enn den man ble sykmeldt fra.]
  - Er det vanskelig for deg å utføre oppgavene du hadde før du ble syk?
  - Er det andre forhold hos arbeidsgiveren din som gjør det vanskelig for deg å fungere i jobben?
  - Snakk gjerne med en av våre veiledere om en ny jobb kan være bedre for deg.
  - Du kan finne alle utlyste stillinger i landet på arbeidsplassen.no
]

#separator()

#framed(radius: 6pt, inset: (x: 18pt, top: 21.5pt, bottom: 27pt), above: 19pt)[
  #section-title[Trenger du oppfølging fra oss?]
  #paragraph[Vi kan gi informasjon og veiledning om du har rett til andre økonomiske støtteordninger etter at sykepengene tar slutt]
  #paragraph[#choice[Ja, jeg trenger oppfølging] #h(12pt) #choice[Nei, jeg trenger ikke oppfølging]]
]

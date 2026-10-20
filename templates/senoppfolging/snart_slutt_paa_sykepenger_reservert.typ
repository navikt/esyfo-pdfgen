#import "/lib/common/sanitize.typ": sanitize
#import "/lib/oppfolgingsplan/layout.typ": is-truthy
#import "/lib/senoppfolging/common.typ": framed, letter-layout, paragraph, section-title, sent-date, title

#let data = sanitize(json("/data/senoppfolging/snart_slutt_paa_sykepenger_reservert.json"))
#let letter = data.at("brevdata", default: (:))
#let get(key) = letter.at(key, default: none)

#let section-title = section-title.with(above: 39pt, below: 39pt)

#show: letter-layout.with(title: "Snart slutt på sykepenger")

#if is-truthy(get("sendtdato")) {
  sent-date(get("sendtdato"))
}

#paragraph(below: 39pt)[Hei!]

#if is-truthy(get("maxdato")) {
  if is-truthy(get("utbetaltTom")) {
    paragraph[
      Per #strong(get("utbetaltTom")) er det beregnet at din siste dag med sykepenger er #strong[#get("maxdato").]
      Datoen gjelder hvis du er sykmeldt uten opphold. Den vil flytte seg hvis du for eksempel jobber noen perioder,
      eller hvis du tar ferie. Du kan få sykepenger i maksimalt 52 uker, og for deg vil det si at denne datoen nå
      nærmer seg.
    ]
  } else {
    paragraph[
      Etter #strong(get("maxdato")) får du ikke lenger sykepenger. Du kan få sykepenger i maksimalt 52 uker, og for
      deg vil det si at denne datoen nå nærmer seg. Datoen kan forskyves, for eksempel hvis du tar ferie mens du er
      sykmeldt.
    ]
  }
} else {
  framed(inset: (left: 12pt, top: 20pt, bottom: 19pt), above: 33pt, below: 20pt)[
    #set list(indent: 0pt)
    #show list: set block(above: 12pt, below: 0pt)
    #paragraph(strong[Obs!])
    #paragraph[På grunn av feil i systemene våre får vi ikke sendt deg datoen for siste dag med sykepenger.]
    #paragraph(below: 0pt)[Ta Kontakt med oss for mer informasjon.]
    - Ring oss på 55 55 33 33. Åpningstiden på telefon er hverdager fra klokken 09.00–15.00.
    - Du kan besøke oss på nav.no/still-sporsmal for å ta kontakt på andre måter.
  ]
}

#paragraph[
  Hvis du er usikker på om du er tilbake i arbeid innen sykepengene tar slutt, er det viktig at du planlegger
  framover slik at du ikke risikerer å stå uten inntekt.
]

#title[Hva kan du gjøre?]

#paragraph[Hvis du blir frisk og er tilbake i arbeid før sykepengene tar slutt, kan du se bort fra denne informasjonen.]

#section-title[Kan du gå tilbake til jobben din?]
#paragraph[Arbeidsgiveren din skal, så langt det er mulig, tilpasse arbeidsplassen og oppgavene dine slik at du kan jobbe.]
- Snakk med lederen din.
- Det er arbeidsgiverens ansvar å legge til rette for at du kan jobbe.
- Det er ditt ansvar å være med å finne løsninger slik at du kan komme tilbake til jobb.

#section-title[Bør du bytte jobb?]
#paragraph[Av og til er det mulig å fungere bedre i en annen jobb enn den man ble sykmeldt fra.]
- Er det vanskelig for deg å utføre oppgavene du hadde før du ble syk?
- Er det andre forhold hos arbeidsgiveren din som gjør det vanskelig for deg å fungere i jobben?
- Snakk gjerne med en av våre veiledere om en ny jobb kan være bedre for deg.
- Du kan finne alle utlyste stillinger i landet på arbeidsplassen.no

#section-title[Er du fortsatt syk?]
#paragraph[
  Hvis du ikke er frisk nok til å gå tilbake til jobb slik som før, kan det være riktig å søke om
  arbeidsavklaringspenger (AAP), eller en annen økonomisk støtte. Du må være forberedt på å gå ned i inntekt når
  sykepengene tar slutt, fordi andre støtter fra NAV gir mindre enn sykepenger.
]
- Husk at du selv må søke om AAP eller annen økonomisk støtte. Dette skjer ikke automatisk.
- Husk å søke støtte i god tid før sykepengene tar slutt, behandlingstiden kan være lang.
- Husk at du også kan ha rettigheter hos forsikringsselskapet eller pensjonskassen din.
- Ikke alle har rett til AAP. Les mer om AAP og om hvordan du kan søke på nav.no/aap
- Snakk gjerne med en av våre veiledere om hva du kan gjøre hvis du fortsatt er syk.

#title[Ta gjerne kontakt med NAV]

#paragraph[Snakk med en veileder om mulighetene dine videre, eller om du har krav på økonomisk støtte.]
- Ring oss på 55 55 33 33. \
  Åpningstiden på telefon er hverdager fra klokken 09.00–15.00.
- Du kan besøke oss på #underline(link("https://www.nav.no/still-sporsmal")[nav.no/still-sporsmal]) for å ta kontakt på andre måter.

#paragraph(above: 36pt, below: 30pt)[Vennlig hilsen \ NAV]
#paragraph[Du får denne informasjonen i et brev fordi du har reservert deg mot digital kommunikasjon fra NAV.]

// Shared content for the six original situation-specific receipts.
#import "/lib/common/components.typ": *

#let p = paragraph.with(above: 13.5pt, below: 13.5pt)
#let h2 = nav-heading.with(above: 18pt, below: 15pt)
#let expanded = expanded-heading.with(above: 18pt, below: 15pt)
#let rule = divider.with(above: 12pt, below: 12pt, stroke: 0.75pt + rgb("a9a9a9"))
#let label = underlined-label

#let introduction(letter) = {
  alert-box(variant: "success", stroke: 1.5pt + ink, inset: (x: 18pt, y: 15pt))[Takk, svarene dine er sendt til Nav.]
  if is-truthy(letter.at("behovForOppfolging", default: none)) {
    nav-heading(level: 1, above: 18pt, below: 18pt)[Vi tar kontakt med deg]
    p[En veileder vil ta kontakt med deg på nav.no eller telefon.]
  } else {
    nav-heading(level: 1, above: 18pt, below: 18pt)[Det kan hende du hører fra oss]
    p[Veilederen din vil vurdere om det kan være lurt at dere snakker sammen likevel. I så fall blir du kontaktet på nav.no eller telefon.]
  }
}

#let tilrettelegging() = [
  #p[Arbeidsgiveren din skal, så langt det er mulig, tilpasse arbeidsplassen og oppgavene dine slik at du kan jobbe.]
  #p[Det er ditt ansvar å bidra til å finne løsninger slik at du kan jobbe.]
  #p[*Snakk med lederen din om hvilke muligheter som finnes.*]
]

#let redusert() = [
  #p[Hvis du skal jobbe redusert fordi du har en sykdom eller skade, kan det hende at du har rett på #label[arbeidsavklaringspenger (AAP)], eller en annen økonomisk støtte.]
  #p[Les mer om #label[aktuelle pengestøtter].]
  #p[Du kan også ta kontakt med Nav på telefon 55 55 33 33 for å få informasjon om hvilken økonomisk støtte som kan være aktuell for deg hvis du får et inntektstap.]
]

#let syk() = [
  #p[Hvis du ikke er frisk nok til å gå tilbake til jobb slik som før, kan det være riktig å søke om #label[arbeidsavklaringspenger (AAP)], eller en annen økonomisk støtte. Merk at det er egne vilkår for å motta AAP, som du bør sette deg inn i før du søker.]
  #p[*Du må selv søke om AAP eller annen økonomisk støtte.* Dette skjer ikke automatisk.]
  #p[Du må være forberedt på å gå ned i inntekt når sykepengene tar slutt. Dette er fordi våre andre støtteordninger ikke gir like mye utbetalt som sykepenger. Husk at du også kan ha rettigheter hos forsikringsselskapet eller pensjonskassen din.]
  #p[Veileder kan hjelpe deg med å finne ut hvilken økonomisk støtte som kan være aktuelt for deg, og med søkeprosessen.]
  #alert-box(stroke: 1.5pt + ink, inset: (x: 18pt, y: 15pt), below: 18pt)[
    *Saksbehandlingstiden for AAP-søknader er omtrent 15 uker.*
    #p[Hvis du bor eller oppholder deg i et annet EØS-land og får oppfølging av Nav utland så er saksbehandlingstiden for AAP-søknader betydelig lenger.]
    #p[Husk å søke tidlig nok.]
  ]
  #button-label[Gå til søknaden om AAP]
]

#let jobbytte(letter, use-maxdato: false) = {
  let get(key) = letter.at(key, default: none)
  p[Av og til fungerer man bedre i en annen jobb enn den man er sykmeldt fra.]
  list(
    [Er det vanskelig for deg å utføre oppgavene du hadde før du ble syk?],
    [Er det andre forhold hos arbeidsgiveren din som gjør det vanskelig for deg å fungere i jobben?],
  )
  p[
    #if use-maxdato {
      if is-truthy(get("maxdato")) {
        [Siste dag du kan motta sykepenger er beregnet til å være #get("maxdato").]
      } else {
        [Det nærmer seg siste dag du kan motta sykepenger.]
      }
    } else {
      if is-truthy(get("daysUntilMaxDate")) {
        [Per #get("sentDate") har du #get("daysUntilMaxDate") dager med sykepenger igjen.]
      } else {
        [Det nærmer seg slutten på sykepengene dine.]
      }
    }
    *Det er derfor lurt å tenke på jobbytte allerede nå.* Veilederen kan hjelpe deg med dette.
  ]
  p[Du kan finne alle utlyste stillinger i landet på #label[arbeidsplassen.nav.no].]
}

#let ending(letter) = {
  rule()
  if not is-truthy(letter.at("behovForOppfolging", default: none)) {
    h2[Hvis situasjonen din endrer seg]
    p[Du kan når som helst ta kontakt med oss på tlf. 55 55 33 33 eller #nav-link("https://www.nav.no/still-sporsmal")[skriv til oss her på nav.no] (åpner i en ny fane). Har du en aktivitetsplan bruker du «dialog med veileder» der for å snakke med veilederen din.]
  }
  h2[Nyttige lenker]
  for item in (
    [Har vært syk eller skadet lenge],
    [Arbeidsavklaringspenger (AAP)],
    [Kompetansetiltak for sykmeldte],
    [Friskmelding til arbeidsformidling],
  ) { p(label(item)) }
}

#let situation-receipt(letter, variant) = {
  introduction(letter)
  let use-maxdato = variant in ("bytte_jobb", "tilbake_hos_arbeidsgiver")
  let order = if variant == "bytte_jobb" {
    ("jobbytte", "tilrettelegging", "redusert", "syk")
  } else if variant in ("fortsatt_syk", "usikker") {
    ("syk", "tilrettelegging", "redusert", "jobbytte")
  } else if variant == "tilbake_gradert" {
    ("redusert", "tilrettelegging", "jobbytte", "syk")
  } else { ("tilrettelegging", "redusert", "jobbytte", "syk") }
  let primary = (
    bytte_jobb: "Når du skal bytte jobb",
    fortsatt_syk: "Når du er for syk til å jobbe",
    usikker: "Hvis du fortsatt er for syk til å jobbe",
    tilbake_gradert: "Når du skal jobbe i redusert stillingsprosent",
    tilbake_med_tilpasninger: "Når du trenger tilrettelegging på arbeidsplassen",
  )
  let titles = (
    tilrettelegging: "Hvis du trenger tilrettelegging for å stå i jobben du har",
    redusert: "Hvis du skal jobbe redusert",
    jobbytte: "Hvis du skal bytte jobb",
    syk: "Hvis du fortsatt er for syk til å jobbe",
  )
  for (index, section) in order.enumerate() {
    if index == 0 and variant != "tilbake_hos_arbeidsgiver" {
      h2(primary.at(variant))
    } else {
      rule()
      expanded(titles.at(section))
    }
    if section == "tilrettelegging" { tilrettelegging() }
    else if section == "redusert" { redusert() }
    else if section == "syk" { syk() }
    else { jobbytte(letter, use-maxdato: use-maxdato) }
  }
  ending(letter)
}

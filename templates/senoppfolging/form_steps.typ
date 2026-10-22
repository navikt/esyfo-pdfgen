#import "/lib/common/sanitize.typ": sanitize
#import "/lib/common/components.typ": *
#import "/lib/senoppfolging/cards.typ": already-applied

#let data = sanitize(json("/data/senoppfolging/form_steps.json"))
#let letter = data.at("brevdata", default: (:))
#let get(key) = letter.at(key, default: none)
#let p = paragraph.with(above: 13.5pt, below: 13.5pt)
// The source starts at h2: promote the hierarchy for PDF/UA, preserving size.
#let h2 = nav-heading.with(level: 1, size: 15pt, above: 18pt, below: 15pt)
#let h3 = nav-heading.with(level: 2, size: 13.5pt, above: 15pt, below: 13.5pt)
#let option = radio-option.with(help: [(du valgte dette alternativet)], below: 9pt)
#let step-heading(number, body) = h2(
  grid(columns: (1fr, auto), column-gutter: 9pt,
    body,
    text(size: 12pt, weight: "regular")[Steg #number av 3],
  ),
)

#show: nav-document.with(title: "Spørreskjema ved snart slutt på sykepenger – Din utfylling av skjema")

#step-heading(1)[Din forventning til fremtidig situasjon]
#keep-together(above: 15pt, below: 9pt, {
  h3[Hvilken situasjon tror du at du er i når sykepengene har tatt slutt?]
  for (value, label) in (
    ("TILBAKE_HOS_ARBEIDSGIVER", [Jeg er frisk og tilbake hos arbeidsgiver]),
    ("TILBAKE_GRADERT", [Jeg er fortsatt syk, men jobber redusert]),
    ("FORTSATT_SYK", [Jeg er for syk til å jobbe]),
    ("BYTTE_JOBB", [Jeg skal bytte jobb]),
    ("USIKKER", [Ingen av alternativene passer]),
  ) {
    option(label, selected: get("fremtidigSituasjonAnswer") == value)
  }
})
#divider(above: 15pt, below: 15pt)

#if get("fremtidigSituasjonAnswer") == "TILBAKE_HOS_ARBEIDSGIVER" {
  step-heading(2)[Informasjon – Når du skal tilbake til arbeidsgiver]
  p[Hvis situasjonen din skulle endre seg og du får behov for tilrettelegging på arbeidsplassen, så skal arbeidsgiveren din, så langt det er mulig, tilpasse arbeidsplassen og oppgavene dine slik at du kan jobbe.]
  p[Husk at du alltid kan kontakte Nav dersom du trenger hjelp med noe eller hvis situasjonen din endrer seg.]
  p[#nav-link("https://www.nav.no/tilrettelegging-jobb")[Les mer om tilrettelegging på jobb, og hva Nav kan bistå med].]
}
#if get("fremtidigSituasjonAnswer") == "TILBAKE_GRADERT" {
  step-heading(2)[Informasjon – Når du fortsatt er syk, men skal jobbe redusert]
  p[Hvis du skal jobbe redusert fordi du har en sykdom eller skade, kan det hende at du har rett på #nav-link("https://www.nav.no/aap")[arbeidsavklaringspenger (AAP)], eller en annen økonomisk støtte.]
  already-applied(above: 12pt, below: 12pt)
}
#if get("fremtidigSituasjonAnswer") == "FORTSATT_SYK" {
  step-heading(2)[Informasjon – Når du er for syk til å jobbe]
  p[Hvis du ikke er frisk nok til å gå tilbake til jobb slik som før, kan det være riktig å søke om #nav-link("https://www.nav.no/aap")[arbeidsavklaringspenger], eller en annen økonomisk støtte.]
  p[*Du må selv søke om AAP eller annen økonomisk støtte.* Dette skjer ikke automatisk.]
  block(width: 100%, stroke: 2.25pt + ink, inset: 12pt, radius: 3pt, below: 12pt)[
    *Husk å søke tidlig nok!*
    #p[Her kan du se #nav-link("https://www.nav.no/saksbehandlingstider#arbeidsavklaringspenger-aap")[forventet saksbehandlingstid for AAP-søknader]. Du kan se saksbehandlingstider for andre pengestøtter på samme side.]
  ]
  already-applied(above: 12pt, below: 12pt)
}
#if get("fremtidigSituasjonAnswer") == "BYTTE_JOBB" {
  step-heading(2)[Informasjon – Når du skal bytte jobb]
  list(
    [Er det vanskelig for deg å utføre oppgavene du hadde før du ble syk?],
    [Er det andre forhold hos arbeidsgiveren din som gjør det vanskelig for deg å fungere i jobben?],
  )
  p[Av og til fungerer man bedre i en annen jobb enn den man er sykmeldt fra. Det nærmer seg slutten på sykepengene dine, og derfor kan det være lurt å tenke på å bytte jobb allerede nå.]
  p[Hvis du blir arbeidsledig eller permittert kan du ha rett på #nav-link("https://www.nav.no/dagpenger")[dagpenger].]
}
#if get("fremtidigSituasjonAnswer") == "USIKKER" {
  step-heading(2)[Informasjon – Kan dette hjelpe?]
  p[Her har vi samlet litt informasjon som kan være relevant for deg.]
  h3[Jeg har allerede søkt om AAP eller en annen pengestøtte]
  p[Dette skjemaet har ikke informasjon om du har søkt på andre pengestøtter.]
  p[Hvis du har søkt om en pengestøtte vil ikke svarene dine her ha noen innvirkning på behandlingen av søknaden din.]
  h3[Jeg planlegger å ta ut pensjon]
  p[Mange kan ta ut pensjon fra de er 62 år. Tidlig uttak betyr at du fordeler pensjonen din over flere år, og dermed får mindre utbetalt hvert år. Pensjonen blir høyere hvis du fortsetter å jobbe samtidig som du tar ut pensjon. Du kan jobbe så mye du vil samtidig som du tar ut alderspensjon fra folketrygden.]
  p[#nav-link("https://www.nav.no/planlegger-pensjon")[På denne siden] kan du få oversikt over hvordan pensjonen din er bygget opp og sjekke pensjonskalkulatoren.]
  h3[Jeg skal i permisjon]
  p[Skal du ta ut lovfestet permisjon i forbindelse med svangerskap, fødsel, omsorg eller foreldrepermisjon, er det viktig at dette avklares med arbeidsgiveren din.]
  p[En permisjon er midlertidig. Dette betyr at du fremdeles er ansatt og har rett og plikt til å komme tilbake til stillingen din når permisjonen er ferdig.]
  h3[Jeg venter på behandling og er usikker på min fremtidige situasjon]
  p[Det kan være lange ventetider for å få nødvendig behandling fra helsevesenet. Hvis du ikke er ferdig med behandlingen din når sykepengerettighetene dine tar slutt, kan det hende du bør søke pengestøtte hos Nav. Dette kan for eksempel være arbeidsavklaringspenger (AAP).]
  p[#nav-link("https://www.nav.no/aap")[Les mer her om hvem som har rett på AAP].]
  h3[Jeg har andre spørsmål]
  p[Dersom du trenger hjelp til å finne ut av hvilke muligheter du har fremover, og hva Nav kan tilby av pengestøtter eller annen hjelp, kan du be om oppfølging på neste side. En sykefraværsveileder vil da motta henvendelsen din.]
  p[Dersom du lurer på noe annet, som f.eks. utbetaling av sykepenger eller generelle spørsmål, kan du når som helst ta kontakt med oss på tlf. 55 55 33 33 eller på #nav-link("https://www.nav.no/still-sporsmal")[skriv til oss her på nav.no].]
}
#if not is-truthy(get("fremtidigSituasjonAnswer")) {
  align(right, text(size: 12pt)[Steg 2 av 3])
  p[Beklager - Kan ikke hente ditt svar på spørsmål om fremtidig situasjon]
} else if get("fremtidigSituasjonAnswer") not in (
  "TILBAKE_HOS_ARBEIDSGIVER", "TILBAKE_GRADERT", "FORTSATT_SYK", "BYTTE_JOBB", "USIKKER",
) {
  align(right, text(size: 12pt)[Steg 2 av 3])
}

#divider(above: 15pt, below: 15pt)
#block(width: 100%, sticky: true)[
  #step-heading(3)[Oppfølging fra Nav]
]
#keep-together(above: 15pt, below: 9pt, {
  h3[Ønsker du å be om oppfølging?]
  p[En veileder kan hjelpe deg med å kartlegge mulighetene dine, og vurdere hvilken hjelp og støtte du kan få fra Nav. Er du allerede i kontakt med en veileder og får den oppfølgingen du trenger, kan du bare svare nei. Du mister ikke kontakten du allerede har med veileder.]
  option([Ja, jeg ønsker å be om oppfølging], selected: get("behovForOppfolgingAnswer") == "JA")
  option([Nei, jeg trenger ikke oppfølging nå], selected: get("behovForOppfolgingAnswer") == "NEI")
})

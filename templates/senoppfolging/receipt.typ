#import "/lib/common/sanitize.typ": sanitize
#import "/lib/common/components.typ": *
#import "/lib/common/date.typ": iso-to-long-date
#import "/lib/senoppfolging/cards.typ": maxdato-card

#let data = sanitize(json("/data/senoppfolging/receipt.json"))
#let letter = data.at("brevdata", default: (:))
#let get(key) = letter.at(key, default: none)
#let p = paragraph.with(above: 13.5pt, below: 13.5pt)
// The source starts at h2: promote the hierarchy for PDF/UA, preserving size.
#let h2 = nav-heading.with(level: 1, size: 15pt, above: 20pt, below: 15pt)

#show: nav-document.with(title: "Spørreskjema ved snart slutt på sykepenger – Kvittering på ditt svar")

#alert-box(variant: "success", stroke: 1.5pt + ink, inset: (x: 12pt, y: 25.5pt))[
  *Takk, svarene dine er sendt til Nav.* \
  Sendt: #if is-truthy(get("submissionDateFormatted")) { get("submissionDateFormatted") } else { iso-to-long-date(get("submissionDateISO")) }
]
#h2[Oppsummering av dine svar]
#alert-box(inset: (x: 12pt, y: 21pt))[
  #keep-together(below: 13.5pt, p[*#get("questionTextFremtidigSituasjon")* \ #get("answerTextFremtidigSituasjon")])
  #keep-together(p[*#get("questionTextBehovForOppfolging")* \ #get("answerTextBehovForOppfolging")])
]
#h2[Hva skjer videre?]
#if is-truthy(get("behovForOppfolging")) {
  p[Svarene dine deles med veilederen din som jobber med sykefraværsoppfølging. Svarene brukes til å vurdere behovet du har for oppfølging fra Nav. Du får beskjed når veilederen din har vurdert behovet ditt.]
} else {
  p[Du har svart at du ikke trenger oppfølging nå. Hvis du allerede har kontakt med en veileder, så vil du ikke miste den kontakten. Dersom du senere ønsker råd og veiledning kan du når som helst ta kontakt med oss på telefon 55 55 33 33 eller #nav-link("https://www.nav.no/still-sporsmal")[skrive til oss her på nav.no].]
}
#maxdato-card(letter, above: 15pt, below: 15pt)
#h2[Informasjon fra Nav som være nyttig for deg]
#bullet-links((
  ("https://www.nav.no/syk-lenge", [Når du har vært syk eller skadet lenge]),
  ("https://www.nav.no/aap", [Arbeidsavklaringspenger (AAP)]),
  ("https://www.nav.no/friskmelding-arbeidsformidling", [Friskmelding til arbeidsformidling]),
  ("https://www.nav.no/varig-sykdom-skade#pengestotte", [Aktuelle pengestøtter når du ikke kan jobbe]),
))
#h2[Har du andre spørsmål?]
#p[Du kan når som helst ta kontakt med oss på telefon 55 55 33 33 eller ved å #nav-link("https://www.nav.no/still-sporsmal")[skrive til oss].]

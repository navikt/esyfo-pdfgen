#import "/lib/common/sanitize.typ": sanitize
#import "/lib/oppfolgingsplan/layout.typ": answer, document-layout, is-truthy, keep-together, question, section-title, separator, text-line, title

#let data = sanitize(json("/data/oppfolging/oppfolgingsplanlps.json"))
#let plan = data.at("lpsPlanData", default: (:))
#let get(key) = plan.at(key, default: none)

#let title = title.with(below: 12pt)
#let text-line = text-line.with(above: 4pt, below: 4pt)
#let section-title = section-title.with(below: 12pt)
#let question = question.with(weight: "medium", above: 14pt)
#let answer = answer.with(size: 9pt, above: 14pt)
#let separator = separator.with(above: 10.5pt)
#let section(body, content) = keep-together(above: 37.5pt)[
  #section-title(body)
  #content
]
#let question-answer(body, value) = {
  question(body)
  answer(value)
  separator()
}

#let optional-question-answer(title, key) = if is-truthy(get(key)) {
  question-answer(title, get(key))
}

#show: document-layout.with(
  title: "Oppfølgingsplan",
  margin: 40pt,
  paragraph-spacing: 0pt,
)

#title[Oppfølgingsplan for #if is-truthy(get("employeeName")) { get("employeeName") } else { get("employeeFnr") }]

#for key in ("employeeAddress", "employeeEmail", "employeePhoneNumber") {
  if is-truthy(get(key)) {
    text-line(get(key))
  }
}

#section("Arbeidsoppgaver")[
  #question-answer("Hvordan ser en vanlig arbeidshverdag ut?", get("typicalWorkday"))
  #question-answer("Hvilke ordinære arbeidsoppgaver kan fortsatt utføres?", get("tasksThatCanStillBeDone"))
  #question-answer("Hvilke ordinære arbeidsoppgaver kan ikke utføres?", get("tasksThatCanNotBeDone"))
]

#section("Tilrettelegging for å være i arbeid")[
  #question-answer("Tilrettelegging tidligere i sykefraværet", get("previousFacilitation"))
  #question-answer("Hvordan skal dere tilrettelegge arbeidshverdagen fremover?", get("plannedFacilitation"))
  #optional-question-answer("Har dere andre muligheter for tilrettelegging som ikke prøves ut nå?", "otherFacilitationOptions")
]

#section("Oppfølging")[
  #question-answer("Når skal dere evaluere denne oppfølgingsplanen?", get("evaluationDate"))
  #question-answer("Hvordan skal dere følge opp avtalt tilrettelegging?", get("followUp"))
]

#section("Informasjon til NAV og fastlege")[
  #question-answer("Hvem vil dere sende planen til?", get("sendPlanToString"))
  #if is-truthy(get("needsHelpFromNav")) {
    question-answer("Trenger dere hjelp fra NAV?", "Ja")
    question("Hva trenger dere hjelp fra NAV med?")
    if is-truthy(get("needsHelpFromNavDescription")) {
      answer(get("needsHelpFromNavDescription"))
    }
    separator()
  } else {
    question-answer("Trenger dere hjelp fra NAV?", "Nei")
  }
  #optional-question-answer("Beskjed til fastlegen", "messageToGeneralPractitioner")
  #question-answer("Har arbeidstakeren vært med å lage planen?", get("employeeHasContributedToPlan"))
  #optional-question-answer("Beskriv hvorfor arbeidstakeren ikke har vært med å lage planen", "employeeHasNotContributedToPlanDescription")
]

#section("Kontaktperson")[
  #question-answer("Navn til kontaktperson", get("employerContactPersonFullName"))
  #question-answer("Telefonnummer til kontaktperson", get("employerContactPersonPhoneNumber"))
  #question-answer("Epost til kontaktperson", get("employerContactPersonEmail"))
  #optional-question-answer("Eventuelle tilleggsopplysninger", "additionalInformation")
]

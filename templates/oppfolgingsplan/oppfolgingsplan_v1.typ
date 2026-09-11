#import "/lib/oppfolgingsplan/layout.typ": answer-field, detail-row, document-layout, is-present, section-header, title-banner

#let data = json("/data/oppfolgingsplan/oppfolgingsplan_v1.json")
#let plan = data.at("oppfolgingsplan", default: (:))

#let employee-name = plan.at("sykmeldtName", default: "")
#let organization-name = plan.at("organisasjonsnavn", default: "")
#let document-title = "Oppfølgingsplan for " + employee-name + " og " + organization-name

#show: document-layout.with(
  title: "Oppfølgingsplan",
  footer-title: document-title,
)

#title-banner[#document-title]

#detail-row("Opprettet", plan.at("createdDate", default: ""))
#detail-row("Dato for evaluering", plan.at("evaluationDate", default: ""))
#detail-row("Arbeidstakers navn", employee-name)
#detail-row("Arbeidstakers fødselsnummer", plan.at("sykmeldtFnr", default: ""))

#let position-title = plan.at("stillingstittel", default: none)
#let position-percentage = plan.at("stillingsprosent", default: none)
#if is-present(position-title) {
  let position = if is-present(position-percentage) {
    position-title + " i " + position-percentage + "% stilling"
  } else {
    position-title
  }
  detail-row("Stilling", position)
}

#detail-row("Bedriftens navn", organization-name)
#detail-row("Organisasjonsnummer", plan.at("organisasjonsnummer", default: ""))
#detail-row("Nærmeste leder", plan.at("narmesteLederName", default: ""))

#for section in plan.at("sections", default: ()) {
  section-header(
    section.at("title", default: ""),
    description: section.at("description", default: none),
  )

  for field in section.at("inputFields", default: ()) {
    let value = field.at("value", default: none)
    if is-present(value) {
      answer-field(
        field.at("title", default: ""),
        description: field.at("description", default: none),
        value,
      )
    }
  }
}
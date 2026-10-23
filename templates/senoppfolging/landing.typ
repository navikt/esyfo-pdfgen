#import "/lib/common/sanitize.typ": sanitize
#import "/lib/common/components.typ": *
#import "/lib/senoppfolging/cards.typ": maxdato-card

#let data = sanitize(json("/data/senoppfolging/landing.json"))
#let letter = data.at("brevdata", default: (:))

#show: nav-document.with(title: "Snart slutt på sykepenger – Informasjon om maksdato og spørreskjema")
#let p = paragraph.with(above: 13.5pt, below: 13.5pt)

#nav-heading(level: 1, above: 16pt, below: 20pt)[Sykepengene dine tar snart slutt]
#if is-truthy(letter.at("maxdato", default: none)) {
  maxdato-card(letter, landing: true)
} else {
  block(width: 100%, stroke: 1pt + ink, inset: 12pt)[
    #nav-heading[Beklager, teknisk feil]
    #p[På grunn av feil i systemene våre får vi ikke vist deg beregnet siste dag med sykepenger. \
    Vennligst prøv igjen litt senere.]
    #p[Kontakt teknisk brukerstøtte dersom problemene vedvarer.]
  ]
}
#p[Det er viktig at du tar stilling til din økonomiske situasjon i god tid før sykepengene tar slutt.]
#p[Vi ber deg svare på to spørsmål, slik at vi best mulig kan gi deg informasjon som er relevant for deg. Du får også muligheten til å be om oppfølging fra en veileder.]
#button-label[Gå videre]

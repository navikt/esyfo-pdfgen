#import "/lib/common/components.typ": *
#import "/lib/common/date.typ": iso-to-long-date

#let maxdato-content(updated) = [
  Du kan maksimalt få sykepenger fra Nav i 52 uker. Grensen er den samme enten du er helt eller delvis sykmeldt.
  Den siste datoen du kan få sykepenger kalles maksdato. Din maksdato ble sist oppdatert #updated.
  Maksdatoen gjelder fortsatt hvis du har vært sammenhengende sykmeldt og mottatt sykepenger siden da.
  Den vil forskyve seg til en senere dato hvis du har perioder etter #updated der du ikke mottar sykepenger.
  Det kan skje hvis du er frisk i perioder eller hvis du tar ferie.
]

#let maxdato-card(letter, landing: false, above: 0pt, below: 0pt) = {
  let get(key) = letter.at(key, default: none)
  let date = if landing { get("maxdato") } else if is-truthy(get("maxdatoFormatted")) {
    get("maxdatoFormatted")
  } else { iso-to-long-date(get("maxdatoISO")) }
  let updated = if landing { get("utbetaltTom") } else if is-truthy(get("utbetaltTomFormatted")) {
    get("utbetaltTomFormatted")
  } else { iso-to-long-date(get("utbetaltTomISO")) }
  expansion-card(
    [Beregnet slutt på sykepenger],
    maxdato-content(updated),
    description: [Din maksdato er beregnet til å være #date. Åpne kortet for å lese mer.],
    level: 2, title-size: if landing { 15pt } else { 13.5pt }, above: above, below: below,
  )
}

#let already-applied(above: 0pt, below: 0pt) = expansion-card(
  [Har du allerede søkt om AAP eller en annen pengestøtte?],
  [
    Dette skjemaet har ikke informasjon om du har søkt på andre pengestøtter.

    Hvis du har søkt om en pengestøtte vil ikke svarene dine her ha noen innvirkning på behandlingen av søknaden din.
  ], level: 2, title-size: 13.5pt, above: above, below: below,
)

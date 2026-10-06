# esyfo-pdfgen

[![Build Status](https://github.com/navikt/esyfo-pdfgen/actions/workflows/build-and-deploy.yml/badge.svg)](https://github.com/navikt/esyfo-pdfgen/actions/workflows/build-and-deploy.yml)

## Environments

[🛠️ Development](https://esyfo-pdfgen.intern.dev.nav.no)

[🔎 Demo](https://esyfo-pdfgen-demo.ekstern.dev.nav.no)

PDF-tjeneste for eSyfo, bygget på
[`pdfgenrs`](https://github.com/navikt/pdfgenrs) og Typst.

## Lokal utvikling

Du trenger Docker og [mise](https://mise.jdx.dev/).

Start API og demoside lokalt:

```bash
mise run dev
```

| Tjeneste | Adresse |
| --- | --- |
| Demoside | http://localhost:9090/ |
| API | http://localhost:9091/api/v1/genpdf/example/test |

`mise run dev` kjører `docker compose up --build --watch` i forgrunnen.
`pdfgenrs` laster maler og eksempeldata ved oppstart, så Compose Watch bygger
og starter tjenestene på nytt ved endringer i `templates/`, `lib/`, `data/` og
`demo/`. Nye filer i `data/` dukker da også opp i listen på demosiden. Avslutt
med Ctrl+C, eller `mise run stop` fra en annen terminal.

`mise run build` bygger de lokale imagene uten å starte dem.

`mise run test` kompilerer alle eksempeldata mot malene, på samme måte som CI.
Testen bruker port 8080; sett `PORT` hvis den er opptatt.

## Struktur

| Katalog | Innhold |
| --- | --- |
| `templates/` | Typst-maler organisert som `<område>/<dokument>.typ` |
| `lib/` | Gjenbrukbare Typst-komponenter for layout |
| `data/` | Syntetiske eller anonymiserte eksempeldata for lokal utvikling |
| `demo/` | Demoside, generering av eksempelvalg og nginx-konfigurasjon |

Produksjonsimaget inneholder ikke `data/`. Docker Compose bygger development-
targetet, som inkluderer eksempeldata og aktiverer `DEV_MODE`.

CI kompilerer hver `data/<område>/<dokument>.json` mot
`templates/<område>/<dokument>.typ` og stopper deploy hvis en mal ikke gir en
gyldig PDF. Testen sjekker bare at malen kompilerer. Innhold og layout må
godkjennes manuelt.

## Driftsgrenser

Tjenesten bruker standardverdiene fra den versjonspinnede `pdfgenrs`-releasen.
De overstyres ikke i dette repositoryet:

| Innstilling | Standard |
| --- | --- |
| `MAX_CONCURRENT_COMPILATIONS` | 4 |
| `SEMAPHORE_ACQUIRE_TIMEOUT_SECONDS` | 10 sekunder |
| `COMPILE_TIMEOUT_SECONDS` | 30 sekunder |
| `REQUEST_BODY_LIMIT_BYTES` | 2097152 byte (2 MiB) |

Request-grensen må verifiseres mot forventet maksimal størrelse for hver
dokumentflyt før flyten migreres til produksjon.

## API

Produksjonskall bruker JSON:

```bash
curl --fail \
  --request POST \
  --header 'Content-Type: application/json' \
  --data '{"message":"Hei fra POST"}' \
  --output example.pdf \
  http://localhost:9091/api/v1/genpdf/example/test
```

GET-forhåndsvisning med data fra `data/` er bare tilgjengelig i `DEV_MODE`.

## Demo

Forsiden for demo er tilgjengelig for Entra-innloggede Nav-ansatte, også uten
naisdevice:

```text
https://esyfo-pdfgen-demo.ekstern.dev.nav.no/
```

API-URL-er på demoverten, for eksempel
`https://esyfo-pdfgen-demo.ekstern.dev.nav.no/api/v1/genpdf/example/test`,
går via proxyen og krever samme innlogging. `pdfgenrs`-demoen kjører med versjonerte
eksempeldata, men har ikke lenger egen ingress og aksepterer bare trafikk fra
`esyfo-pdfgen-demo-web`. Forsiden finnes kun i demo og lokalt, ikke i dev
eller prod.
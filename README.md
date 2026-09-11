# esyfo-pdfgen


[![Build Status](https://github.com/navikt/esyfo-pdfgen/actions/workflows/build-and-deploy.yml/badge.svg)](https://github.com/navikt/esyfo-pdfgen/actions/workflows/build-and-deploy.yml)

## Environments

[🛠️ Development](https://esyfo-pdfgen.intern.dev.nav.no)

[🔎 Demo](https://esyfo-pdfgen-demo.intern.dev.nav.no)

PDF-tjeneste for eSyfo, bygget på
[`pdfgenrs`](https://github.com/navikt/pdfgenrs) og Typst.

## Lokal utvikling

Du trenger Docker og [mise](https://mise.jdx.dev/).

Start tjenesten og åpne eksempel-PDF-en:

```bash
mise run open-example
```

Eksempelet er da tilgjengelig på:

```text
http://localhost:9091/api/v1/genpdf/example/test
```

`pdfgenrs` laster maler og eksempeldata ved oppstart. Bruk
`mise run restart` etter endringer, eller `mise run watch` dersom `fswatch` er
installert. Stopp tjenesten med `mise run stop`.

## Struktur

| Katalog | Innhold |
| --- | --- |
| `templates/` | Typst-maler organisert som `<område>/<dokument>.typ` |
| `lib/` | Gjenbrukbare Typst-komponenter for layout |
| `data/` | Syntetiske eller anonymiserte eksempeldata for lokal utvikling |

Produksjonsimaget inneholder ikke `data/`. Docker Compose bygger development-
targetet, som inkluderer eksempeldata og aktiverer `DEV_MODE`.

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

Demo-appen kjører development-imaget med versjonerte eksempeldata og er
tilgjengelig for Entra-innloggede Nav-ansatte:

```text
https://esyfo-pdfgen-demo.intern.dev.nav.no/api/v1/genpdf/example/test
```
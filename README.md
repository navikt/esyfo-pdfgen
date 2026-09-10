# esyfo-pdfgen

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
| `data/` | Syntetiske eller anonymiserte eksempeldata for lokal utvikling |

Produksjonsimaget inneholder ikke `data/`. Docker Compose bygger development-
targetet, som inkluderer eksempeldata og aktiverer `DEV_MODE`.

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
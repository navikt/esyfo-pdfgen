# Migrer dokumentflyter gradvis til esyfo-pdfgen

`pdfgen` er deprecated til fordel for `pdfgenrs` og skal etter planen arkiveres 31. desember 2026. Vi oppretter derfor `esyfo-pdfgen` som et eget repository og en permanent NAIS-app basert på `pdfgenrs`, i stedet for å erstatte rendereren direkte i `syfooppdfgen`.

Dokumentflytene migreres enkeltvis, og hver konsument velger gammel eller ny PDF-tjeneste per dokumentflyt gjennom konfigurasjon. Dette begrenser regresjonsomfanget og gir eksplisitt rollback, mot kostnaden ved å drifte to PDF-tjenester i migreringsperioden.

Datagrunnlagets semantikk beholdes under migreringen, mens nye API-stier kan bruke stabile, domeneorienterte dokumentidentifikatorer. Når dokumentflyteierne har godkjent og stabilisert alle aktive flyter, avvikles `syfooppdfgen`. `esyfo-pdfgen` beholder sin identitet som eSyfos PDF-tjeneste.

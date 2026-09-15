FROM ghcr.io/navikt/pdfgenrs:1.0.35@sha256:94df394cf565a276a42b6566d44c483bf86bbab647d93f5917cbc661425a7545 AS production

COPY templates /app/templates
COPY lib /app/lib

FROM production AS development

COPY data /app/data
ENV DEV_MODE=true

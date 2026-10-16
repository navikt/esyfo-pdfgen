FROM ghcr.io/navikt/pdfgenrs:1.0.45@sha256:7117ace0c0037e3b3c0f819eb7f99ae26b060c82bbcf438b95ace6ebe407fc60 AS production

COPY templates /app/templates
COPY lib /app/lib

FROM production AS development

COPY data /app/data
ENV DEV_MODE=true

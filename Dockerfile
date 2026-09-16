FROM ghcr.io/navikt/pdfgenrs:1.0.37@sha256:dc91bae33723702df7880a635c5216133c86ecb51104268c43a8aad2d139aaa4 AS production

COPY templates /app/templates
COPY lib /app/lib

FROM production AS development

COPY data /app/data
ENV DEV_MODE=true

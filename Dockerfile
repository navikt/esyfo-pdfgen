FROM ghcr.io/navikt/pdfgenrs:1.0.43@sha256:61b7bdcfe8f2b94bde98ca239ad0a80a57d7050a459751a5c938d8c0c74ba644 AS production

COPY templates /app/templates
COPY lib /app/lib

FROM production AS development

COPY data /app/data
ENV DEV_MODE=true

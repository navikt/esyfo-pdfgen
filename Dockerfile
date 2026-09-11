FROM ghcr.io/navikt/pdfgenrs:1.0.34@sha256:0d2c822f0d5c6f9ab4f7228eccc1c254a9ce2dde75589b8227b9739d2a23a145 AS production

COPY templates /app/templates
COPY lib /app/lib

FROM production AS development

COPY data /app/data
ENV DEV_MODE=true

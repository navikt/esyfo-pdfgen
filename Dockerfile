FROM ghcr.io/navikt/pdfgenrs:1.0.46@sha256:6fea30433b727d927dd2618d382399582e9d99d0b593eca02a0a0592f9ebb5a4 AS production

COPY templates /app/templates
COPY lib /app/lib

FROM production AS development

COPY data /app/data
ENV DEV_MODE=true

FROM ghcr.io/navikt/pdfgenrs:1.0.50@sha256:ec0e94a203aaa5c4176b1ecb643f0415b2e3b3fdcd3d4bb6111ba400692c2c89 AS production

COPY templates /app/templates
COPY lib /app/lib
COPY resources /app/resources

FROM production AS development

COPY data /app/data
ENV DEV_MODE=true

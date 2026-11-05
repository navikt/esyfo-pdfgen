FROM ghcr.io/navikt/pdfgenrs:1.0.51@sha256:0ac12896cc0d9cf7e63e0350270f713aa9c0da268a89d407560deb3838fe92d4 AS production

COPY templates /app/templates
COPY lib /app/lib
COPY resources /app/resources

FROM production AS development

COPY data /app/data
ENV DEV_MODE=true

FROM ghcr.io/navikt/pdfgenrs:1.0.57@sha256:39b5d38c7625d2886e0c98148103aa771ace8f49f9757233e8a4539ad0ca050c AS production

COPY templates /app/templates
COPY lib /app/lib
COPY resources /app/resources

FROM production AS development

COPY data /app/data
ENV DEV_MODE=true

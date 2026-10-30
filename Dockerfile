FROM ghcr.io/navikt/pdfgenrs:1.0.48@sha256:8e8a28d532fd6350d99263b099b9afc04cafb534b281634b6dd8b3652f8e2bad AS production

COPY templates /app/templates
COPY lib /app/lib
COPY resources /app/resources

FROM production AS development

COPY data /app/data
ENV DEV_MODE=true

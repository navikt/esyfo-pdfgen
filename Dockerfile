FROM ghcr.io/navikt/pdfgenrs:1.0.59@sha256:0f6c0df82dbc2b44a52a8e7e7d92891a93e9122e86fa94d422b5f969a82fa892 AS production

COPY templates /app/templates
COPY lib /app/lib
COPY resources /app/resources

FROM production AS development

COPY data /app/data
ENV DEV_MODE=true

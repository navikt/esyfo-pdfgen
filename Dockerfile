FROM ghcr.io/navikt/pdfgenrs:1.0.58@sha256:c585e761b4620a97e402a5fa23b87442db2ff9ad31ee1b3bb97df2c09a1abbec AS production

COPY templates /app/templates
COPY lib /app/lib
COPY resources /app/resources

FROM production AS development

COPY data /app/data
ENV DEV_MODE=true

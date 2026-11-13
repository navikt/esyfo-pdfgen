FROM ghcr.io/navikt/pdfgenrs:1.0.56@sha256:ec2adba5e6fb2c1eeb95f2251866ac249705be43a05ca29ba7219ba73cbc6a25 AS production

COPY templates /app/templates
COPY lib /app/lib
COPY resources /app/resources

FROM production AS development

COPY data /app/data
ENV DEV_MODE=true

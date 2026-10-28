FROM ghcr.io/navikt/pdfgenrs:1.0.47@sha256:40f859a620cfd1a839bdb96a865e840f34f06446ed0dc39dc4befc212f687fa1 AS production

COPY templates /app/templates
COPY lib /app/lib
COPY resources /app/resources

FROM production AS development

COPY data /app/data
ENV DEV_MODE=true

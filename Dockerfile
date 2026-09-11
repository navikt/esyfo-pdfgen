FROM ghcr.io/navikt/pdfgenrs:1.0.33@sha256:65159d61f50bfb09fc4208253f87f2fbd6d6f1e6b0e1d68b9463f51d9f370fae AS production

COPY templates /app/templates
COPY lib /app/lib

FROM production AS development

COPY data /app/data
ENV DEV_MODE=true

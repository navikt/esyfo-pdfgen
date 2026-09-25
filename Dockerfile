FROM ghcr.io/navikt/pdfgenrs:1.0.41@sha256:7471df39f7f40a17ca2cacae3deebc1740c788fcc2edba19a8dddd06025a7bae AS production

COPY templates /app/templates
COPY lib /app/lib

FROM production AS development

COPY data /app/data
ENV DEV_MODE=true

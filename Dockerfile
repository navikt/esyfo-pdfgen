FROM ghcr.io/navikt/pdfgenrs:1.0.42@sha256:f973f30b4beac8d1e9f541335f061ee2c96ece6101b2915372a71db9ea2ac351 AS production

COPY templates /app/templates
COPY lib /app/lib

FROM production AS development

COPY data /app/data
ENV DEV_MODE=true

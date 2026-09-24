FROM ghcr.io/navikt/pdfgenrs:1.0.40@sha256:65f22bbe6e771d95f74c3fe8d7584538f5df4bc2412f22034d2506ce94cc49b4 AS production

COPY templates /app/templates
COPY lib /app/lib

FROM production AS development

COPY data /app/data
ENV DEV_MODE=true

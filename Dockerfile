FROM ghcr.io/navikt/pdfgenrs:1.0.60@sha256:5df8e23091fc8c90ea102f10c54865067498d4da4309c9ec2cb4e761fbb62b05 AS production

COPY templates /app/templates
COPY lib /app/lib
COPY resources /app/resources

FROM production AS development

COPY data /app/data
ENV DEV_MODE=true

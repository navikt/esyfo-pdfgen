FROM nginxinc/nginx-unprivileged:1.31.7-alpine-slim@sha256:a8cb0f33d51fa107c96fd2bd3a71aaf564ec131e9d2bdf8700944f0ed8b170d7 AS builder
USER root
WORKDIR /work
COPY data/ data/
COPY demo/ demo/
RUN sh demo/generate-index.sh data /work/index.html

FROM nginxinc/nginx-unprivileged:1.31.7-alpine-slim@sha256:a8cb0f33d51fa107c96fd2bd3a71aaf564ec131e9d2bdf8700944f0ed8b170d7
# CVE-2026-4738: the base image ships zlib 1.3.2-r0; remove once the base includes 1.4-r0.
USER root
RUN apk upgrade --no-cache zlib
USER 101
COPY --from=builder /work/index.html /usr/share/nginx/html/index.html
COPY demo/app.js demo/style.css /usr/share/nginx/html/
COPY demo/default.conf /etc/nginx/conf.d/default.conf
COPY demo/upstream.conf /etc/nginx/pdfgen-upstream.conf
ENTRYPOINT ["nginx", "-g", "daemon off;"]

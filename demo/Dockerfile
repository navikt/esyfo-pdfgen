FROM nginxinc/nginx-unprivileged:1.31.6-alpine-slim@sha256:c81a27f28bc2d9c2da8998444e653c7b85b9bbbaa92e44ef18d8920784e06507 AS builder
USER root
WORKDIR /work
COPY data/ data/
COPY demo/ demo/
RUN sh demo/generate-index.sh data /work/index.html

FROM nginxinc/nginx-unprivileged:1.31.6-alpine-slim@sha256:c81a27f28bc2d9c2da8998444e653c7b85b9bbbaa92e44ef18d8920784e06507
COPY --from=builder /work/index.html /usr/share/nginx/html/index.html
COPY demo/app.js demo/style.css /usr/share/nginx/html/
COPY demo/default.conf /etc/nginx/conf.d/default.conf
COPY demo/upstream.conf /etc/nginx/pdfgen-upstream.conf
ENTRYPOINT ["nginx", "-g", "daemon off;"]

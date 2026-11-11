FROM cgr.dev/chainguard/busybox:latest AS builder
WORKDIR /tmp
COPY data/ data/
COPY demo/ demo/
RUN sh demo/generate-index.sh data /tmp/index.html

FROM cgr.dev/chainguard/nginx:latest
COPY --from=builder /tmp/index.html /usr/share/nginx/html/index.html
COPY demo/app.js demo/style.css /usr/share/nginx/html/
COPY demo/default.conf /etc/nginx/conf.d/nginx.default.conf
COPY demo/upstream.conf /etc/nginx/pdfgen-upstream.conf

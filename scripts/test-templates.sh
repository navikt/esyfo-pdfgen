#!/usr/bin/env bash
# Compile-only test: every data/<group>/<name>.json must produce a PDF from
# templates/<group>/<name>.typ via pdfgenrs.
set -euo pipefail

cd "$(dirname "$0")/.."

IMAGE="esyfo-pdfgen-test"
CONTAINER="esyfo-pdfgen-test"
PORT="${PORT:-8080}"
BASE_URL="http://localhost:$PORT"
RESPONSE="$(mktemp)"

cleanup() {
  rm -f "$RESPONSE"
  docker rm -f "$CONTAINER" >/dev/null 2>&1 || true
}
trap cleanup EXIT

docker build --target development --tag "$IMAGE" .
docker rm -f "$CONTAINER" >/dev/null 2>&1 || true
docker run --name "$CONTAINER" --publish "$PORT:8080" --detach "$IMAGE" >/dev/null

ready=false
for i in $(seq 1 30); do
  if curl -sf -o /dev/null "$BASE_URL/internal/is_ready"; then
    ready=true
    break
  fi
  echo "Waiting for pdfgenrs... ($i/30)"
  sleep 2
done
if [ "$ready" != true ]; then
  echo "::error::pdfgenrs did not become ready in time"
  docker logs "$CONTAINER"
  exit 1
fi

failed=0
total=0
while IFS= read -r data_file; do
  relative="${data_file#data/}"
  group="$(dirname "$relative")"
  name="$(basename "$relative" .json)"
  total=$((total + 1))

  http_status=$(curl -s -w "%{http_code}" \
    -X POST \
    -H "Content-Type: application/json" \
    --data-binary @"$data_file" \
    -o "$RESPONSE" \
    "$BASE_URL/api/v1/genpdf/$group/$name")
  file_type=$(file --mime-type -b "$RESPONSE")

  if [ "$http_status" = "200" ] && [ "$file_type" = "application/pdf" ]; then
    echo "OK: $group/$name"
  else
    echo "::error title=PDF compile failed::$group/$name: HTTP $http_status, $file_type"
    head -c 2000 "$RESPONSE"
    echo ""
    failed=$((failed + 1))
  fi
done < <(find data -name '*.json' -type f | sort)

echo "=== Results: $((total - failed))/$total templates compiled ==="
if [ "$total" -eq 0 ]; then
  echo "::error::No data files found"
  exit 1
fi
if [ "$failed" -ne 0 ]; then
  echo "--- pdfgenrs logs ---"
  docker logs "$CONTAINER" 2>&1
  exit 1
fi

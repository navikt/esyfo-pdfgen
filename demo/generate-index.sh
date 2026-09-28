#!/bin/sh
set -eu

if [ "$#" -ne 2 ]; then
    echo "Usage: sh demo/generate-index.sh <data directory> <output file>" >&2
    exit 1
fi

data_dir=$1
output=$2
options=$(mktemp "${output}.options.XXXXXX")
result=$(mktemp "${output}.result.XXXXXX")
trap 'rm -f "$options" "$result"' 0
trap 'exit 1' 1 2 3 15

for file in "$data_dir"/*/*.json; do
    [ -f "$file" ] || continue
    app=${file%/*}
    app=${app##*/}
    template=${file##*/}
    template=${template%.json}
    case "$app" in
        ''|*[!a-z0-9_-]*)
            echo "Invalid app name in data path" >&2
            exit 1
            ;;
    esac
    case "$template" in
        ''|*[!a-z0-9_-]*)
            echo "Invalid template name in data path" >&2
            exit 1
            ;;
    esac
    printf '<option value="/api/v1/genpdf/%s/%s">%s/%s</option>\n' \
        "$app" "$template" "$app" "$template" >> "$options"
done

if [ ! -s "$options" ]; then
    echo "No example data files found" >&2
    exit 1
fi

LC_ALL=C sort -o "$options" "$options"
first=$(sed -n '1s/.*value="\([^"]*\)".*/\1/p' "$options")
awk -v options="$options" -v first="$first" '
    /<!-- OPTIONS -->/ {
        while ((getline option < options) > 0) print option
        close(options)
        next
    }
    {
        gsub(/__FIRST_URL__/, first)
        print
    }
' demo/index.html.template > "$result"
chmod 644 "$result"
mv "$result" "$output"

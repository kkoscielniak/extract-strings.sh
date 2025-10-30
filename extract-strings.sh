#!/usr/bin/env bash
set -euo pipefail

usage() {
    echo "Usage: $0 <base_directory> [-o output_dir_name]"
    exit 1
}

# --- Parse arguments ---
if [[ $# -lt 1 ]]; then
    usage
fi

BASE_DIR=""
OUT_NAME=""

while [[ $# -gt 0 ]]; do
    case "$1" in
        -o)
            shift
            [[ $# -gt 0 ]] || usage
            OUT_NAME="$1"
            ;;
        -*)
            echo "Unknown option: $1"
            usage
            ;;
        *)
            if [[ -z "$BASE_DIR" ]]; then
                BASE_DIR="$1"
            else
                echo "Error: Multiple base directories provided."
                usage
            fi
            ;;
    esac
    shift
done

# --- Validate base directory ---
if [[ -z "$BASE_DIR" || ! -d "$BASE_DIR" ]]; then
    echo "Error: '$BASE_DIR' is not a valid directory."
    exit 1
fi

# --- Determine output directory ---
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BASE_NAME="$(basename "$BASE_DIR")"

if [[ -z "$OUT_NAME" ]]; then
    OUT_NAME="${BASE_NAME}_extracted_strings"
fi

OUT_DIR="$SCRIPT_DIR/$OUT_NAME"
mkdir -p "$OUT_DIR"

echo "Base directory: $BASE_DIR"
echo "Output directory: $OUT_DIR"
echo

# --- Main processing loop ---
find "$BASE_DIR" -type f | while read -r file; do
    rel_path="${file#$BASE_DIR/}"
    out_file="$OUT_DIR/${rel_path}.strings.txt"

    mkdir -p "$(dirname "$out_file")"

    strings "$file" > "$out_file" 2>/dev/null || true
    echo "Processed: $file -> $out_file"
done

echo
echo "✅ Extraction complete."
echo "Results saved to: $OUT_DIR"


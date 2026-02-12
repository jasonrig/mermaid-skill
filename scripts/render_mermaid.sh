#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage:
  render_mermaid.sh <input.mmd|input.md|-> <output.svg|png|pdf|md> [mmdc options]

Examples:
  render_mermaid.sh diagram.mmd diagram.svg --theme neutral --width 1400
  render_mermaid.sh architecture.md architecture.pdf --pdfFit
  cat diagram.mmd | render_mermaid.sh - out.png --outputFormat png

Notes:
  - Uses: npx -y -p @mermaid-js/mermaid-cli mmdc
  - Sets npm cache via MERMAID_NPM_CACHE (default: /tmp/mermaid-npm-cache)
USAGE
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  usage
  exit 0
fi

if [[ $# -lt 2 ]]; then
  usage
  exit 1
fi

if ! command -v npx >/dev/null 2>&1; then
  echo "Error: npx not found. Install Node.js/npm first." >&2
  exit 1
fi

input_path="$1"
output_path="$2"
shift 2

if [[ "$input_path" != "-" && ! -f "$input_path" ]]; then
  echo "Error: input file not found: $input_path" >&2
  exit 1
fi

cache_dir="${MERMAID_NPM_CACHE:-/tmp/mermaid-npm-cache}"
mkdir -p "$cache_dir"

default_theme="${MERMAID_THEME:-neutral}"

cmd=(
  npx
  -y
  -p
  @mermaid-js/mermaid-cli
  mmdc
  -i
  "$input_path"
  -o
  "$output_path"
  -t
  "$default_theme"
)

npm_config_cache="$cache_dir" "${cmd[@]}" "$@"

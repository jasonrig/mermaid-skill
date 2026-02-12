#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<'USAGE'
Usage:
  dry_run_mermaid.sh <input.mmd|input.md|-> [mmdc options]

Examples:
  dry_run_mermaid.sh diagram.mmd
  dry_run_mermaid.sh architecture.md --pdfFit
  cat diagram.mmd | dry_run_mermaid.sh - --outputFormat png

Notes:
  - Renders to a temporary file and deletes it automatically.
  - Prints Mermaid CLI parser/layout errors directly.
USAGE
}

if [[ "${1:-}" == "-h" || "${1:-}" == "--help" ]]; then
  usage
  exit 0
fi

if [[ $# -lt 1 ]]; then
  usage
  exit 1
fi

input_path="$1"
shift

if [[ "$input_path" != "-" && ! -f "$input_path" ]]; then
  echo "Error: input file not found: $input_path" >&2
  exit 1
fi

format="svg"
args=("$@")
for ((i = 0; i < ${#args[@]}; i++)); do
  arg="${args[$i]}"
  case "$arg" in
    -e|--outputFormat)
      if ((i + 1 < ${#args[@]})); then
        format="${args[$((i + 1))]}"
        i=$((i + 1))
      fi
      ;;
    --outputFormat=*)
      format="${arg#*=}"
      ;;
  esac
done

format="$(printf '%s' "$format" | tr '[:upper:]' '[:lower:]')"
case "$format" in
  svg|png|pdf)
    ;;
  *)
    format="svg"
    ;;
esac

tmp_seed="$(mktemp)"
tmp_output="${tmp_seed}.${format}"
mv "$tmp_seed" "$tmp_output"
cleanup() {
  rm -f "$tmp_output"
}
trap cleanup EXIT

script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
render_script="$script_dir/render_mermaid.sh"

if [[ ! -f "$render_script" ]]; then
  echo "Error: render helper not found: $render_script" >&2
  exit 1
fi

if bash "$render_script" "$input_path" "$tmp_output" "$@"; then
  echo "Dry-run succeeded. Temporary output was removed: $tmp_output"
  exit 0
else
  render_status=$?
  echo "Dry-run failed with exit code $render_status. Mermaid CLI errors are shown above." >&2
  exit "$render_status"
fi

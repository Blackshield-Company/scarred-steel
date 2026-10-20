#!/usr/bin/env bash
# Load every plugin of the series together (Modkit.Compat) and write a report.
#
#   tools/modkit/compat-series.sh                          # download every release listed in series.txt
#   tools/modkit/compat-series.sh --local dist/X-0.1.0.zip # use a local build instead of the release of the same name
#   tools/modkit/compat-series.sh --report tools/modkit/compat-report.md
#
# Checks (see Modkit.Compat): simulated ESL runtime FormID collisions, EditorID collisions,
# overrides of vanilla or each other's records, duplicate Papyrus script names, global
# name clashes, installed-file path collisions, and that cross-plugin links resolve.
# Release archives are cached in ${COMPAT_CACHE:-$HOME/.cache/modkit-compat}.
set -euo pipefail
KIT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CACHE="${COMPAT_CACHE:-$HOME/.cache/modkit-compat}"
REPORT=""
declare -A LOCAL=()
while [[ $# -gt 0 ]]; do
  case "$1" in
    --local) LOCAL["$(basename "$2")"]="$(realpath "$2")"; shift 2 ;;
    --report) REPORT="$2"; shift 2 ;;
    *) echo "unknown argument: $1" >&2; exit 2 ;;
  esac
done
mkdir -p "$CACHE"
ZIPS=()
while read -r repo tag zip; do
  [[ -z "${repo:-}" || "$repo" == \#* ]] && continue
  if [[ -n "${LOCAL[$zip]:-}" ]]; then
    ZIPS+=("${LOCAL[$zip]}")
    continue
  fi
  dest="$CACHE/$zip"
  if [[ ! -s "$dest" ]]; then
    echo "[compat] downloading $repo $tag $zip"
    curl -fsSL -o "$dest.part" "https://github.com/synthalorian/$repo/releases/download/$tag/$zip"
    mv "$dest.part" "$dest"
  fi
  ZIPS+=("$dest")
done < "$KIT/series.txt"

echo "[compat] building Modkit.Compat"
dotnet build "$KIT/Modkit.Compat" -c Release -v q -nologo >/dev/null
ARGS=()
[[ -n "$REPORT" ]] && ARGS+=(--report "$REPORT")
dotnet "$KIT/Modkit.Compat/bin/Release/net9.0/Modkit.Compat.dll" "${ARGS[@]}" "${ZIPS[@]}"
echo "[compat] archives:"
for z in "${ZIPS[@]}"; do (cd "$(dirname "$z")" && sha256sum "$(basename "$z")"); done

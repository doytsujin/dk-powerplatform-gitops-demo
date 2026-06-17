#!/usr/bin/env bash
# "Connector risk review" — the check we built ourselves (slide 10).
# Scans the unpacked solution for connectors not on the business allow-list and
# FLAGS them for human review. A flag is informational (exit 0); only a blocked
# connector is a hard stop (exit 1).
set -euo pipefail

ALLOW="shared_commondataserviceforapps shared_office365"
BLOCK="shared_twitter"   # mirrors the DLP non-business classification in terraform

found_block=0
while IFS= read -r conn; do
  base="${conn##*/}"
  if grep -qw "$base" <<<"$BLOCK"; then
    echo "::error::Blocked connector referenced: $base"
    found_block=1
  elif ! grep -qw "$base" <<<"$ALLOW"; then
    echo "::warning::Connector requires review: $base"
  fi
done < <(grep -rhoE '/providers/Microsoft.PowerApps/apis/[a-z_]+' solutions/ | sort -u)

[ "$found_block" -eq 0 ] || { echo "Connector risk review FAILED."; exit 1; }
echo "Connector risk review passed (review flags are informational)."

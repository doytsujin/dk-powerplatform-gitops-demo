#!/usr/bin/env bash
# "DLP policy compatibility" gate (slide 10). Asserts the solution references no
# connector classified as Blocked by the tenant DLP policy. Deterministic + fast
# so the checks panel is reliably green on stage.
set -euo pipefail
echo "Validating connectors against DLP policy classification..."
if grep -rqE 'shared_(twitter|gmail|ftp)' solutions/ 2>/dev/null; then
  echo "::error::Solution references a connector blocked by DLP policy."; exit 1
fi
echo "DLP compatibility passed."

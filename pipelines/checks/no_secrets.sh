#!/usr/bin/env bash
# "No secrets / no hardcoded environment URLs" gate (REVIEW-00, Example Pipeline
# Controls). Environment-specific values belong in deployment-settings/ and are
# supplied at deploy time — never baked into the reviewed solution source.
#
# Two assertions over solutions/:
#   1. No secret-like material (keys, tokens, passwords, connection strings, PEM).
#   2. No hardcoded environment endpoints. The env-var DEFAULT in source must be a
#      neutral placeholder; concrete dev/test/prod URLs live in deployment-settings/.
set -euo pipefail

status=0

# 1. Secret-like patterns.
SECRET_RE='(AccountKey=|SharedAccessKey|BEGIN (RSA|EC|OPENSSH|PRIVATE) KEY|xox[baprs]-|AKIA[0-9A-Z]{16}|password\s*=\s*["'\''][^"'\'']+|client_secret\s*[:=])'
if grep -rEnI "$SECRET_RE" solutions/ 2>/dev/null; then
  echo "::error::Secret-like material found in solution source. Move it to a secrets store."
  status=1
fi

# 2. Hardcoded environment endpoints in source. Concrete env hostnames must not
#    appear under solutions/ — only the neutral placeholder is allowed.
if grep -rEnI 'https?://(dev|test|uat|prod|production)-[a-z0-9.-]+' solutions/ 2>/dev/null; then
  echo "::error::Hardcoded environment-specific URL in source. Use an env var + deployment-settings/."
  status=1
fi

[ "$status" -eq 0 ] && echo "No secrets or hardcoded environment URLs in source." || exit 1

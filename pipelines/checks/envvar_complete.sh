#!/usr/bin/env bash
# "Environment-variable completeness" gate (slide 10). Every env var declared in
# the solution must have a value in EACH deployment-settings file, or the deploy
# would fail late. Catch it at PR time instead.
set -euo pipefail

# schemanames are mixed-case (e.g. onb_IntakeEndpoint); match A-Z/0-9 too, and
# don't let an empty grep trip `set -o pipefail`.
vars=$(grep -rohE 'schemaname="[A-Za-z0-9_]+"' solutions/ | sed -E 's/schemaname="([A-Za-z0-9_]+)"/\1/' | sort -u || true)
status=0
for f in deployment-settings/dev.json deployment-settings/test.json deployment-settings/prod.json; do
  for v in $vars; do
    if ! grep -q "\"$v\"" "$f"; then
      echo "::error::$f is missing a value for env var: $v"; status=1
    fi
  done
done
[ "$status" -eq 0 ] && echo "Env-var completeness passed." || exit 1

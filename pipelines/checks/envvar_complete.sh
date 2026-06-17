#!/usr/bin/env bash
# "Environment-variable completeness" gate (slide 10). Every env var declared in
# the solution must have a value in EACH deployment-settings file, or the deploy
# would fail late. Catch it at PR time instead.
set -euo pipefail

vars=$(grep -rohE 'schemaname="[a-z_]+"' solutions/ | sed -E 's/schemaname="([a-z_]+)"/\1/' | sort -u)
status=0
for f in deployment-settings/dev.json deployment-settings/test.json deployment-settings/prod.json; do
  for v in $vars; do
    if ! grep -q "\"$v\"" "$f"; then
      echo "::error::$f is missing a value for env var: $v"; status=1
    fi
  done
done
[ "$status" -eq 0 ] && echo "Env-var completeness passed." || exit 1

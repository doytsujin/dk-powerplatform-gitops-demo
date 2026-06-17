# On-Stage RUNBOOK — one screen

The click sequence for the live demo. Full talking points + recovery plans:
`dk-dynamicscon2026-slides/DEMO.md`. Budget: **~7 min**. Default rule: **never make
the audience wait for a spinner** — every result below is pre-warmed/cached.

## Pre-flight (before you walk on)
- Terminal `cd` into a clone of this repo, `pac` + `gh` on PATH.
- Two browser tabs: **(1)** this repo on `main`, root tree · **(2)** the **Actions** tab.
- PR `change/onboarding-env-update` already open and sitting at **2 of 3** approvals.
- Cursor highlighter on · Slack/mail/calendar muted.

## The five segments

| # | ~time | Where | Do this | Say (one line) |
|---|---|---|---|---|
| **1** | 1:15 | repo tab | Open `solutions/`, `deployment-settings/`, `pipelines/`, `docs/`. Don't open files. | "Four concerns, four folders. No `prod/` — production is a *target*, not a place." |
| **2** | 1:30 | terminal | `git status` → `git diff` the one env-var line → `git push`. Switch to the open PR. | "The maker didn't touch production. The **PR is now the unit of change.**" |
| **3** | 2:00 | PR checks | Walk the **5 green gates**; click into solution-checker + connector-risk; point at 2/3 reviewers. | "Gates don't block bad ideas — they block **unreviewable** ones. The SP ran these, not me." |
| **4** | 1:30 | Actions | Open the `deploy` run: test is green; **approve** production; show `pac solution import`. | "Test was automatic. Production **paused for a human.** Same artifact, same SHA-256." |
| **5** | 1:15 | Releases | Show the auto-cut release: version + SHA-256 + `release-manifest.json`. | "Nobody wrote a release note. **The deployment record is part of the product.**" |

**If anything is red →** Recovery Plan A: go slides-only and narrate from the screenshot
fallback PDF. The audience never knows. (DEMO.md → Recovery Plans.)

## The immutability beat (Segment 4–5)
The artifact built in `build-artifact` is the *same* zip imported into test **and** prod —
only `deployment-settings/{test,prod}.json` differ. Point at the matching SHA-256 in the
deploy log and the release manifest. That's the "build once, promote the same artifact" story.

---

## ⚠️ Before the REAL talk (not needed for rehearsal)
1. **Provision the backing** — from the factory: `cd dk-dynamicscon2026-slides/demo && make demo-up`
   then `bash scripts/bootstrap.sh`. Wires `PP_*` secrets + branch protection + the production
   approval gate into this repo. (Dataverse is slow — do it the night before.)
2. **Swap the stub solution** under `solutions/customer-onboarding/` for a **real exported**
   solution, or `solution-checker` won't be meaningfully green.
3. **Stage + pre-warm** — `make demo-seed`, then cast 2 of 3 approvals.
4. **Morning-of smoke** — `make demo-verify`. Green = go.

## Rehearse now (no tenant)
`cd dk-dynamicscon2026-slides/demo && make demo-rehearse` — opens a PR and runs the gates with
no backing, so you can practise Segments 1–3 + the merge click today. `make demo-rehearse-clean`
when done. (`solution-checker` may be amber until step 2 above; the other four go green.)

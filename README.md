# power-platform GitOps demo

The demonstrable repository for the talk **"From ClickOps to GitOps: Governing
Power Platform in Enterprise Azure Environments"** (DynamicsCon Regional:
Toronto 2026).

This repo is the *source of truth* for a governed Power Platform solution. It is
what the audience sees on screen: a maker's change becomes a pull request, the
PR runs governance gates, a human approves, and the pipeline deploys to
production — producing an audit trail as a side effect.

## Layout

| Folder | What it is |
|---|---|
| `solutions/` | Unpacked Power Platform solutions (`customer-onboarding` is the one we change live) |
| `deployment-settings/` | Per-environment values (`dev` / `test` / `prod`) — env vars + connection references |
| `pipelines/checks/` | The custom PR gates we built ourselves (connector risk, DLP compat, env-var completeness) |
| `.github/workflows/` | `validate.yml` (PR gates) and `deploy.yml` (auto-test → approval-gated prod → evidence) |
| `docs/` | Environment strategy, governance model, release process |
| `CODEOWNERS` | Makes the platform-owner review a real, enforced gate |

## How a change flows

```
maker edits solution in dev  ->  pac solution export + unpack  ->  commit
  ->  pull request  ->  gates (solution checker · DLP · connector risk · env-var)
  ->  human review (maker peer · security · platform owner)
  ->  merge  ->  deploy to test (auto)  ->  approval gate  ->  deploy to prod
  ->  release auto-cut as the deployment record
```

## Provisioning

The Azure + Power Platform backing (service principal, Dataverse environments,
DLP policy) and this repo's governance settings are provisioned by the **factory**
that lives in the talk's slides repo (`dk-dynamicscon2026-slides/demo/`). This
repo holds only the workflow content; the factory wires the secrets and gates.

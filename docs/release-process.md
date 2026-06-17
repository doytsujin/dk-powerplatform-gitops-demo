# Release process

Changes flow: **dev → Git → PR → gates → review → test → approval → prod**.

- No direct pushes to `main`; every change is a pull request.
- Production deploys are gated on manual approval (GitHub `production` environment).
- Each production deploy auto-cuts a GitHub release as the deployment record.

See `environment-strategy.md` and `governance-model.md`.

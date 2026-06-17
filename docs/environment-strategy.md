# Environment strategy

| Stage | Type | Unmanaged edits? | Owner |
|---|---|---|---|
| dev  | Sandbox    | yes | makers |
| test | Sandbox    | no (managed only) | deployers |
| prod | Production | no (managed only) | platform owner |

Production is not a place in the repo — it is a *target* the pipeline deploys into.

# Governance model

- **Identity:** the pipeline runs as a controlled service principal, never a personal account.
- **Gates:** solution checker, DLP compatibility, connector risk, env-var completeness, + human review.
- **Evidence:** PR timeline, pipeline logs, and an auto-cut release per production deploy.

Roles: maker · deployer · approver · platform owner (see Entra groups provisioned by Terraform).

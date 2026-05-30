# Branch Naming

Branch format is in `project.yaml` -> `git.branch_format`.

When creating a branch for a ticket/issue, apply the format template:
- `{username}` -> derive from `git config user.name` (lowercase, no spaces, short form)
- `{ticket}` -> lowercase ticket identifier (e.g., "cin-123", "saas-456")
- `{slug}` -> kebab-case from ticket title, max 40 chars, no trailing dash, only [a-z0-9-]

Example with format `"{username}/{ticket}-{slug}"`:
`vincentdchn/cin-123-implement-circuit-breaker`

Constraints:
- Total branch name under 80 chars
- Never create a branch if uncommitted changes exist (warn first)

If no project.yaml exists, infer branch convention from existing branches in the repo.

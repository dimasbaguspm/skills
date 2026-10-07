---
name: mr
description: Open a pull or merge request with the project's title and body conventions. Use when the user asks to create an MR, PR, or push a branch for review.
disable-model-invocation: true
---

# MR

Open a reviewable request. Create it with the `gh` CLI or the GitHub MCP server, whichever the harness exposes.

## Title

```
[ai:<y|n>][<TICKET>] <type>: <concise subject>
```

- `ai:y` when an AI or agent wrote or co-wrote the change, `ai:n` when fully human.
- `<TICKET>` is the GitHub issue number (`#123`). Use `[no-ticket]` when there is none.
- `<type>` is the Conventional Commits type: `feat`, `fix`, `refactor`, and so on.
- Subject: imperative, lowercase, no trailing period, 72 chars max.

Example: `[ai:y][#142] feat: add refresh-token rotation`

## Body

```markdown
## What problem that I am facing?

## How I implement it?

## Why should I?

## Risks

Closes #<n>
```

- **What problem that I am facing?** The problem, from the user's point of view. Not the solution.
- **How I implement it?** The approach and the parts touched. A tree or diff sketch beats prose when structure moved.
- **Why should I?** Why this is worth merging. Link the issue.
- **Risks.** Blast radius and reversibility: a one-way door (hard to undo) or a two-way door (cheap to roll back). Say plainly when there is none.
- **Closes.** Add a closing keyword (`Closes #<n>`) as the last line, so the merge closes the issue. Omit for `[no-ticket]`.

Keep each section to a few lines. Do not restate the diff.

## Process

1. Confirm the branch is pushed and up to date with the base branch.
2. Confirm it works: run the tests or verify the behavior by hand.
3. Resolve the originating GitHub issue for `<TICKET>`: `gh issue view <n>` or the MCP `get_issue` tool. Confirm it is open and matches the change. Use its number in the title and `Closes #<n>` in the body.
4. Write the title and body, then create the request:
   - CLI: `gh pr create --title "<title>" --body-file <file>`
   - MCP: the GitHub `create_pull_request` tool with the same title, body, base, and head.
5. Report the URL and confirm the issue link resolved (no "Closes" error). Do not merge unless asked.

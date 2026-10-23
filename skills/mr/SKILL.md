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
## What problem does this solve?

## What is the user facing?

## How did I solve it?

## Risks

## Notes

Closes #<n>
```

- **What problem does this solve?** The problem from the user's point of view, not the solution.
- **What is the user facing?** The observable behavior this changes: which surfaces move and what the user sees.
- **How did I solve it?** The approach and the parts touched. A file tree, diff sketch or sequence diagram beats prose when structure or flow moved.
- **Risks.** Blast radius and reversibility: a one-way door (hard to undo) or a two-way door (cheap to roll back). Say plainly when there is none.
- **Notes.** Links, decisions and follow-ups a reviewer needs. Omit when empty.
- **Closes.** The closing keyword (`Closes #<n>`) is the last line, so the merge closes the issue. Omit for `[no-ticket]`.

## Formatting

- **One line per paragraph.** Never hard-wrap at a column. Leave one blank line between blocks. GitHub reflows the paragraph anyway; hard wraps only make the raw body noisy.
- Keep each section to a few lines. Do not restate the diff.
- When the repo documents its own MR template, that wins over this one.

## Process

1. Confirm the branch is pushed and up to date with the base branch.
2. Confirm it works: run the tests or verify the behavior by hand.
3. Resolve the originating GitHub issue for `<TICKET>`: `gh issue view <n>` or the MCP `get_issue` tool. Confirm it is open and matches the change. Use its number in the title and `Closes #<n>` in the body.
4. Write the title and body, then create the request:
   - CLI: `gh pr create --title "<title>" --body-file <file>`
   - MCP: the GitHub `create_pull_request` tool with the same title, body, base, and head.
5. Report the URL and confirm the issue link resolved (no "Closes" error). Do not merge unless asked.

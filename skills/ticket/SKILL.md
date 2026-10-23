---
name: ticket
description: Break a plan, spec, or conversation into GitHub issues with the project's title and body conventions. Use when the user asks to create tickets or break work into issues.
disable-model-invocation: true
---

# Ticket

Turn agreed work into GitHub issues. One ticket is one verifiable slice.

## Title

```
[Service Name]: <concise subject title>
```

- `Service Name` is the owning service, module, or area.
- Subject: imperative, specific, no trailing period.

Example: `[auth]: rotate refresh tokens on reuse`

## Body

```markdown
## What problem does this solve?

## What is the user facing?

## How will I solve it?

## Done when

## Risks & notes
```

- **What problem does this solve?** The problem from the user's point of view, not the solution.
- **What is the user facing?** The observable behavior: which surfaces change and what the user sees.
- **How will I solve it?** The approach and the parts touched. A sketch, file tree or sequence diagram beats prose when structure or flow moves.
- **Done when** is a short checklist a reviewer verifies without reading the code.
- **Risks & notes** for blast radius, reversibility, links and decisions. Omit when empty.

## Formatting

- **One line per paragraph.** Never hard-wrap at a column. Leave one blank line between blocks. GitHub reflows the paragraph anyway; hard wraps only make the raw body noisy.
- Keep each section to a few lines. The diff carries the detail.
- When the repo documents its own ticket template, that wins over this one.

## Rules

- **Vertical slice:** cuts through every layer and is demoable on its own. Never a horizontal slice of one layer.
- **Sized to finish in one session.** Split anything bigger.
- **Dependencies explicit:** list the issues that block it. No blockers means it can start now.
- **No file paths or code snippets.** They go stale. Exception: a snippet that encodes a decision (schema, state machine) more precisely than prose.

## Process

1. Gather context from the conversation, or fetch the referenced plan, spec, or issue.
2. Draft tickets: title, blocked by, definition of done.
3. Show the list to the user. Iterate until approved.
4. Create in dependency order, so blockers get numbers first. Capture each number from the printed URL:

   ```bash
   gh issue create --title "<title>" --body-file <file>
   ```

   Add `--label <label>` when the repo uses them (`gh label list`).
5. Link blockers in each ticket once the numbers exist. Reference them as `Blocked by #<n>` in the body, or add the relationship in the issue's Relationships panel.
6. Hand off to implementation: the created issue number is the `<TICKET>` the mr skill wants. Start a branch linked to the issue, then open the MR against it:

   ```bash
   gh issue develop <n> --checkout
   ```

   Open the MR with `[#<n>]` in the title and `Closes #<n>` in the body. GitHub links issue, branch, and PR, then closes the issue on merge.

Do not close or modify the parent issue.

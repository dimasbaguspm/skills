---
name: ticket
description: Break a plan, spec, or conversation into GitHub issues with acceptance criteria and dependencies. Use when the user asks to create tickets or break work into issues.
disable-model-invocation: true
---

# Ticket

Turn agreed work into GitHub issues. One ticket is one verifiable slice.

## Rules

- **Vertical slice:** cuts through every layer and is demoable on its own. Never a horizontal slice of one layer.
- **Sized to finish in one session.** Split anything bigger.
- **Dependencies explicit:** list the issues that block it. No blockers means it can start now.
- **Acceptance criteria** are checkboxes a reviewer can verify without reading the code.
- **No file paths or code snippets.** They go stale. Exception: a snippet that encodes a decision (schema, state machine) more precisely than prose.

## Process

1. Gather context from the conversation, or fetch the referenced plan, spec, or issue.
2. Draft tickets: title, blocked by, acceptance criteria.
3. Show the list to the user. Iterate until approved.
4. Create in dependency order, so blockers get numbers first:

   ```bash
   gh issue create --title "<title>" --body-file <file>
   ```

## Template

```markdown
## What to build

The end-to-end behaviour this ticket makes work, from the user's perspective.

## Acceptance criteria

- [ ] <criterion>
- [ ] <criterion>

## Blocked by

- #<issue>  (or "None, can start immediately")
```

Do not close or modify the parent issue.

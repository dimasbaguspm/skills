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
## What's problem?

## What's affected and how?

## Definition of Done

## Additional Notes
```

- **What's problem?** The problem, from the user's point of view. Not the solution.
- **What's affected and how?** The surfaces this touches and the behavior that changes.
- **Definition of Done** is a checklist a reviewer can verify without reading the code.
- **Additional Notes** for links, decisions, and follow-ups. Omit the section if empty.

## Rules

- **Vertical slice:** cuts through every layer and is demoable on its own. Never a horizontal slice of one layer.
- **Sized to finish in one session.** Split anything bigger.
- **Dependencies explicit:** list the issues that block it. No blockers means it can start now.
- **No file paths or code snippets.** They go stale. Exception: a snippet that encodes a decision (schema, state machine) more precisely than prose.

## Process

1. Gather context from the conversation, or fetch the referenced plan, spec, or issue.
2. Draft tickets: title, blocked by, definition of done.
3. Show the list to the user. Iterate until approved.
4. Create in dependency order, so blockers get numbers first:

   ```bash
   gh issue create --title "<title>" --body-file <file>
   ```

5. Link blockers in each ticket once the numbers exist.

Do not close or modify the parent issue.

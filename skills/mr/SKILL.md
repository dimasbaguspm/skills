---
name: mr
description: Open a pull or merge request with a reviewable body. Use when the user asks to create an MR, PR, or push a branch for review.
disable-model-invocation: true
---

# MR

Open a reviewable request with `gh pr create`. The body answers four questions: what changed, why, how you verified it, and how risky the merge is.

## Process

1. Confirm the branch is pushed and up to date with the base branch.
2. Confirm the change works. Run the tests, or reproduce the behaviour by hand.
3. Find the originating issue and link it. If there is none, state the reason.
4. Write the body to a file, then open the request:

   ```bash
   gh pr create --title "<conventional title>" --body-file <file>
   ```

5. Report the URL. Do not merge unless asked.

## Body template

```markdown
## Summary

What changed in 1-3 sentences. If structure moved, add a small tree or diff sketch instead of prose.

## Why

Link the issue, or state the reason.

## Evidence

How you verified. Test output, a before/after, or a screenshot. "Tests pass" is not evidence; the command and result is.

## Risk

Blast radius and reversibility: a one-way door (hard to undo) or a two-way door (cheap to roll back).
```

Keep prose brief. Skip sections that would only restate the diff.

---
name: review-mr
description: Review a pull or merge request for correctness, tests, and risk, and report findings by severity. Use when the user asks to review a PR, MR, or branch.
---

# Review MR

Review for real defects, not style nits. Read the diff, the linked issue, and the tests before commenting.

## Process

1. Get the change: `gh pr view <n>` and `gh pr diff <n>`.
2. Read the linked issue or spec. Does the code do what was asked?
3. Check, in this order:
   - **Correctness** and edge cases: empty, null, concurrent, error paths.
   - **Tests:** would they fail if the logic broke? Do they test behaviour, not internals?
   - **Security and data loss** at trust boundaries. Never simplify these away.
   - **Regressions** for existing callers. Grep every caller of a changed function; a guard in one caller when the bug is in the shared function is not a fix.
4. Report findings, most severe first. Each one: `file:line`, what breaks, how to fix.
5. If nothing is wrong, say so plainly. Never invent findings to look thorough.

## Output

Group as **Blocking**, **Should fix**, **Nit**. End with a one-line verdict: approve, approve with comments, or request changes.

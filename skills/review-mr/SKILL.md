---
name: review-mr
description: Review a pull or merge request for security, correctness, and risk, reading the description and the diff against the target upstream. Use when the user asks to review a PR, MR, or branch.
---

# Review MR

Review for real defects, not style nits. Read the description and the diff before judging anything.

## Process

1. **Read the description first.** `gh pr view <n> --json title,body,baseRefName,headRefName`. Understand the problem and intent before looking at code.
2. **Get the diff against the target upstream**, not just the local branch:

   ```bash
   gh pr diff <n>
   # or: git fetch origin <base> && git diff origin/<base>...HEAD
   ```

   Three-dot, so it compares against the merge-base.
3. **Check OWASP Top 10 first.** This is the top priority. For each relevant item, look for it in the diff:

   | # | Risk |
   |---|---|
   | A01 | Broken access control |
   | A02 | Cryptographic failures |
   | A03 | Injection (SQL, command, XSS) |
   | A04 | Insecure design |
   | A05 | Security misconfiguration |
   | A06 | Vulnerable and outdated components |
   | A07 | Identification and authentication failures |
   | A08 | Software and data integrity failures |
   | A09 | Security logging and monitoring failures |
   | A10 | Server-side request forgery |

4. **Then correctness and tests.** Would the tests fail if the logic broke? Grep every caller of a changed function; a guard in one caller when the bug is in the shared function is not a fix.
5. **Be concise.** Most severe first. No essays, no restating the diff.

## Comment convention

Prefix every comment with a label:

- `blocking:` must fix before merge (security, correctness, data loss)
- `security:` an OWASP concern
- `suggestion:` an improvement, non-blocking
- `question:` needs an answer
- `nitpick:` style or minor

Each comment gives `file:line` and the fix, not just the complaint.

## Output

A one-line verdict (approve, approve with comments, or request changes), then the comments grouped by label. If nothing is wrong, say so plainly. Never invent findings to look thorough.

---
name: review-mr
description: Review a pull or merge request for security, correctness, and risk, reading the description and the diff against the target upstream. Use when the user asks to review a PR, MR, or branch.
---

# Review MR

Review for real defects, not style nits. Read the description and the diff before judging anything.

## How it will be reviewed

Every MR goes through the same 5 gates, in order. Stop at the first gate that fails:

1. **Size gate.** Patch chars / 4 = est. tokens. If >250k, reply `skip: diff ~Xk tokens over 250k budget` and stop. Never review blind.
2. **Intent.** `gh pr view <n> --json title,body,baseRefName,headRefName`. What problem, what intent, what risk. No intent = ask one question, stop.
3. **Security (OWASP Top 10).** Top priority. Check each relevant item against the diff (table below).
4. **Correctness.** Would tests fail if logic broke? Grep every caller of each changed function. Root-cause fix in the shared function beats a guard in one caller.
5. **Verdict.** `blocking` or `security` finding = `REQUEST_CHANGES`. Else `COMMENT`. `APPROVE` only when zero findings. Never invent findings to look thorough.

## Process

1. **Read the description first.** `gh pr view <n> --json title,body,baseRefName,headRefName`. Understand the problem and intent before looking at code.
2. **Get the diff against the target upstream**, not just the local branch:

   ```bash
   gh pr diff <n>
   # or: git fetch origin <base> && git diff origin/<base>...HEAD
   ```

   Three-dot, so it compares against the merge-base. For file list with hunks: `gh pr diff <n> --name-only` then full diff.
3. **Token guard (mandatory).** `wc -c` on the patch / 4. If >250k tokens, reply skip + size, stop.
4. **Check OWASP Top 10 first.** This is the top priority. For each relevant item, look for it in the diff:

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

5. **Then correctness and tests.** Would the tests fail if the logic broke? Grep every caller of a changed function; a guard in one caller when the bug is in the shared function is not a fix.
6. **Be concise.** Most severe first. No essays, no restating the diff.
7. **Submit the review** so it lands on the MR, not just in chat:

   ```bash
   gh api repos/{owner}/{repo}/pulls/{n}/reviews \
     -f event=REQUEST_CHANGES \
     -f body="verdict + summary" \
     -f 'comments[][path]=pkg/foo.go' -F 'comments[][line]=42' \
     -f 'comments[][side]=RIGHT' -f 'comments[][body]=blocking: ...'
   ```

   Use `COMMENT` instead of `REQUEST_CHANGES` when zero blockers. Confirm with the returned review URL.

## Pointing at file lines

Every finding must be clickable, not just `file:line` prose:

- **Chat output:** `path/to/file.go:42` plus one-line fix. Grouped by label, most severe first.
- **GitHub inline comment:** `path` = repo-relative path, `line` = RIGHT-side (new) line number, `side=RIGHT` for added lines, `LEFT` for removed-only context. Diff hunk required: the line must be inside the PR diff, else the API rejects it.
- **Permalink after submit:** GitHub returns `https://github.com/{owner}/{repo}/pull/{n}/changes#r<comment-id>` per inline comment. Paste that link back to the user as proof it landed.
- **Line number source:** never guess. Get it from `gh pr diff <n>` hunk headers (`@@ -a,b +c,d @@`), the `+c` side is RIGHT. Or `gh api repos/{o}/{r}/pulls/{n}/files --paginate -q '.[].filename'` then match hunks.
- **Rejected line?** Fall back to top-level review body with `file:line` refs, and say which lines were outside the diff.

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

---
name: git-commit
description: Use when creating a commit, writing a commit message, or staging files in a git repository. Enforces Conventional Commits with a concise, one-line subject and minimal detail. Do not use for git operations other than committing.
---

# Git Commit

Follow Conventional Commits: short subject, no fluff, no long descriptions.

## Rules

1. **Format:** `type(scope): subject` — scope optional, only when it adds signal.
2. **Subject:** imperative mood, lowercase after the colon, no trailing period, ~50 chars max, never over 72.
3. **Concise:** one line. No body unless a fact must be said that the subject cannot carry (e.g. breaking change). If a body is unavoidable, keep it to 1-3 terse lines.
4. **No detail dump:** do not list every file changed or rephrase the diff. The diff already says what changed — the subject says why it matters.
5. **One logical change per commit.** Split unrelated changes.

## Types

| Type     | Use when                                             |
|----------|------------------------------------------------------|
| feat     | new feature or behavior                              |
| fix      | bug fix                                              |
| refactor | code change, neither fix nor feature                 |
| perf     | performance improvement                              |
| docs     | documentation only                                   |
| test     | tests only                                           |
| build    | build system or dependencies                         |
| ci       | CI config or scripts                                 |
| style    | formatting, whitespace, lint — no code behavior      |
| chore    | maintenance, no code change                          |

Breaking change: add `!` after type/scope — `feat!:` — plus a `BREAKING CHANGE:` footer only if the reason is not obvious.

## Workflow

1. Run `git status` and `git diff` to see what changed.
2. Pick the type that best matches the change.
3. Write the subject: `<verb> <what>`, imperative, exact (`feat: add user login` not `feat: user login was added`).
4. Stage only intended files: `git add <paths>`.
5. Commit: `git commit -m "<message>"`.

## Examples

```
feat: add user login
fix: handle empty cart checkout
refactor: extract validation into helper
feat(auth): add refresh token rotation
perf: cache api responses
docs: update readme install steps
```

Bad — too long, too detailed:
```
fix: fix the bug where the checkout page was throwing an error because the cart was empty which caused the api to return 500 and the user couldn't complete their order which was really annoying
```

Good:
```
fix: handle empty cart checkout
```

## Common Mistakes

- **Past tense:** `feat: added user login` → write imperative `feat: add user login`.
- **Sentences in subject:** no periods, no connecting words (`and`, `then`, `because`).
- **Over-scoping:** `fix(user-service-impl): ...` → `fix(user): ...`.
- **Repeating the diff:** a body listing changed files adds nothing. Cut it.
- **`feat` for everything:** docs/test/style changes are not features.

Never commit unless the user asked. Confirm the message looks like the examples before running `git commit`.

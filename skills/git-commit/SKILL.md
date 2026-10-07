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

## Scope

Scope names the **area of the system**, not the file and not the type. It answers "which part does this touch?" so history can be filtered by component.

- **One scope per commit.** If a change needs two, it is two commits. Split it.
- **Lowest meaningful level.** `auth`, not `src` or `app`. Choose the module or package that owns the change.
- **Reuse existing scopes.** Run `git log --oneline -50` and match the vocabulary already in use. Inventing a new scope per commit destroys the ability to filter.
- **Omit when it adds nothing.** Repo-wide work (`ci`, `build`, `deps`), docs, and releases rarely need one. `fix: handle empty cart` beats `fix(checkout): handle empty cart` when checkout is the only thing you work on.
- **Rename follows the new name.** When a module is renamed, use the new scope.
- **Never a file path, a version, or a ticket number.** Tickets belong in the commit body or the MR, not the scope.

| Scope | Covers |
|---|---|
| `auth` | authentication and authorization |
| `checkout` | the checkout flow |
| `api-client` | the API client package |
| `db` | schema and migrations |
| `deps`, `ci`, `build` | tooling; often better left unscoped |

| Bad scope | Why |
|---|---|
| `src/auth/login.ts` | a file, not an area |
| `app` | too broad to filter by |
| `utils` | meaningless, touched by everything |
| `feat` | the type is not a scope |
| `PROJ-123` | a ticket, not an area |

## Workflow

1. Run `git status` and `git diff` to see what changed.
2. Pick the type that best matches the change.
3. Choose a scope that matches existing history, or omit it.
4. Write the subject: `<verb> <what>`, imperative, exact (`feat: add user login` not `feat: user login was added`).
5. Stage only intended files: `git add <paths>`.
6. Commit: `git commit -m "<message>"`.

## Examples

```
feat: add user login
fix: handle empty cart checkout
refactor: extract validation into helper
feat(auth): add refresh token rotation
perf(api-client): cache responses
docs: update readme install steps
ci: cache node_modules
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
- **File-path scope:** `fix(src/components/Button.tsx): ...` → omit the scope or name the area.
- **Type as scope:** `fix(fix): ...` is not a scope.
- **Repeating the diff:** a body listing changed files adds nothing. Cut it.
- **`feat` for everything:** docs/test/style changes are not features.

Never commit unless the user asked. Confirm the message looks like the examples before running `git commit`.

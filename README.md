# skills

General engineering workflow skills: ticket, MR, review, commit. Portable across agent tools (Pi, OpenCode, Claude Code, Hermes, Codex).

One source of truth. `git pull` updates every tool on every device.

## Install

One line, no clone needed:

```bash
curl -fsSL https://raw.githubusercontent.com/dimasbaguspm/skills/main/install.sh | sh
```

Clones to `~/.local/share/skills` (override with `SKILLS_DIR=...`), then symlinks every skill into each tool's global skills directory. Safe to re-run.

Or from a checkout:

```bash
git clone https://github.com/dimasbaguspm/skills.git ~/developments/skills
cd ~/developments/skills && ./install.sh
```

Re-run `install.sh` after adding or renaming a skill. Editing an existing skill needs no re-run.

## Update

```bash
curl -fsSL https://raw.githubusercontent.com/dimasbaguspm/skills/main/install.sh | sh
```

This pulls the existing clone and re-links. From a checkout instead: `git -C ~/developments/skills pull`.

Symlinks mean every tool sees the change immediately. No re-install.

## Layout

```
skills/
  ticket/SKILL.md
  mr/SKILL.md
  review-mr/SKILL.md
  git-commit/SKILL.md
```

Each skill is a directory with `SKILL.md`. The directory name must match the `name` in the frontmatter.

## Load it per tool

`install.sh` covers all of these. To skip symlinks and point a tool at the clone directly instead:

| Tool | Where |
|---|---|
| Pi | `~/.pi/agent/settings.json`: `"skills": ["~/.local/share/skills/skills"]` |
| OpenCode | `~/.config/opencode/opencode.jsonc`: `"skills": { "paths": ["~/.local/share/skills/skills"] }` |
| Hermes | `~/.hermes/config.yaml`: `skills.external_dirs: ["~/.local/share/skills/skills"]` |
| Claude Code | `~/.claude/skills/` (symlink only; no path setting) |
| cross-tool | `~/.agents/skills/` (read by Pi, OpenCode, Hermes, Codex) |

Pi can also install the repo as a git package: `pi install git:github.com/dimasbaguspm/skills`.

## Add a skill

1. `mkdir skills/<name>` and write `SKILL.md`.
2. Frontmatter: `name` (must match the directory), `description` (state what it does **and** when to use it).
3. Add `disable-model-invocation: true` for skills only the human should trigger.
4. Commit and push. On other devices: `git pull`.

## Conventions

- Load only when relevant. Frontmatter `description` is the routing signal, so make it specific.
- Skills are model-facing instructions. Be direct, concrete, and short.
- Do not put caveman / i-have-adhd here. Those live in their own repo.

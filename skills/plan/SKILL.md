---
name: plan
description: Turn a request into a short, actionable implementation plan before writing code. Use when the user asks for a plan, describes a multi-step change, or the work spans several files.
---

# Plan

Produce a plan the user can approve before any code is written. Do not edit files while planning.

## Process

1. **Understand the ask.** Read the request, then explore only the code it touches. Never plan against imagined code.
2. **State the goal** in one sentence, from the user's perspective.
3. **List the steps** as ordered, concrete actions. Each step names the file or module it changes and what "done" means for it. Prefer vertical slices: each step should be verifiable on its own.
4. **Name the seam** you will test at. Prefer an existing seam. One seam is ideal.
5. **List risks and unknowns**, plus how you would check each.
6. **Stop and ask.** Present the plan, then wait for approval. Implement only after the user says go.

## Output

```markdown
**Goal:** <one sentence>

**Steps**
1. <action> — <file/module>, done when <check>
2. ...

**Test seam:** <where and why>

**Risks**
- <risk> — check: <how>
```

Keep it short. A plan longer than the change it describes is a smell. If the request is genuinely one step, say so instead of padding.

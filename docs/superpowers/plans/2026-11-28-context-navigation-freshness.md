# Context, Navigation and Freshness — Implementation Plan v0.5.0

> **For the maintainer:** this plan implements the brief «контекст, навигация,
> свежесть» for the scrum-crew skill canon. It is a documentation change; no
> runtime code, CLI, dependencies or generators are added.

**Goal:** Add a context/navigation/freshness layer to scrum-crew without
changing roles, the sprint cycle, gates, OpenSpec philosophy or the merge
train.

**Architecture:** A three-level entry (`AGENTS.md` → `.scrum/README.md` →
task `brief.md`), durable task workspaces under
`.scrum/sprints/NN/tasks/<id>/`, output-to-files for subagents, a status
header on artifacts, and trace/audit hooks. Facts live in one host file;
the entry map and sprint trace are link-only views.

**Spec:** the maintainer brief for v0.5.0 (this session).

## Global Constraints

- Do not change roles, cycle, gates, merge train or OpenSpec philosophy.
- No runtime code, CLI, dependencies or generators.
- Do not include product-specific details.
- One fact — one file; everything else links.
- No shared `notes.md`; no README warehouse.
- Russian documentation; identifiers and commit messages in English.

## File Structure

```
.opencode/skills/scrum-crew/
  SKILL.md
  VERSION
  references/
    context.md              NEW: entry map, progressive disclosure, brief
    orchestrator.md         durable workspace, dispatch, trace, WIP
    roles.md                role write boundaries, brief/report/handoff
    openspec.md             change status, trace, drift check
    audit.md                discovery/activation/success/efficiency metrics
    failure-modes.md        new failure modes + mitigation
    cycle.md                sprint/task paths
    communication.md        handoff/status protocols
    git-quality.md          PR/doc/drift checks
    init.md                 .scrum/README.md at Init
    upgrade.md              v0.5.0 migration
  assets/
    context.md              NEW: .scrum/README.md template
    brief.md                RENAMED from task.md: context package
    task.md                 compatibility stub
    report.md               NEW: worker report
    handoff.md              header + durable path + read-back
    sprint.md               trace table + task links
    review.md               task id/PR + drift check
    pr.md                   doc change + drift check
    audit.md                context/navigation metrics
template/
  AGENTS.md                 entry levels, durable workspace, freshness
  .scrum/README.md          NEW: INIT entry map
  docs/**                   context headers, sprint links
.scrum/                     dry-run example (not installed)
  README.md
  state.json
  board.json
  events.jsonl
  sprints/99/
    README.md
    sprint.md
    tasks/99.1/{brief,report,handoff}.md
    tasks/99.1/evidence/verify.txt
  reviews/99-99.1.md
README.md                   v0.5.0, structure, context layer
CHANGELOG.md                v0.5.0 + migration notes
docs/DECISIONS.md           D18: entry map / durable workspace / freshness
```

## Tasks

### Task 1: Entry map and context reference

**Files:**
- Create: `.opencode/skills/scrum-crew/references/context.md`
- Create: `.opencode/skills/scrum-crew/assets/context.md`
- Modify: `SKILL.md` (sections 0, 1, 11, 12, 13)

- [x] Write the map principle, three entry levels, 5–6 start links,
      question→file table, "what not to read", progressive disclosure,
      context package fields, 3-link example, status header and drift rules.
- [x] Update `SKILL.md` so the first read is `AGENTS.md` → `.scrum/README.md`,
      not the whole repository.
- [x] Add the map freshness check to gates/checklist.

### Task 2: Durable workspace and dispatch

**Files:**
- Modify: `references/orchestrator.md`
- Modify: `references/roles.md`
- Modify: `references/cycle.md`
- Modify: `references/communication.md`
- Modify: `references/git-quality.md`
- Modify: `.opencode/agents/scrum-orchestrator.md`
- Modify: `.opencode/agents/scrum-worker.md`
- Modify: `.opencode/agents/scrum-reviewer.md`

- [x] Define `.scrum/sprints/NN/tasks/<id>/` as the durable workspace.
- [x] Define brief issuance, read-back, report/handoff/evidence to files.
- [x] Define coordinator summary + link; reviewer reads artifacts, not logs.
- [x] Add trace table and event fields (task/pr/commit/artifact).
- [x] Add conflict-aware WIP (1–2; 6 ceiling; shared files serialize).

### Task 3: Asset templates

**Files:**
- Rename: `assets/task.md` → `assets/brief.md`
- Create: `assets/report.md`
- Create: `assets/task.md` (deprecated stub)
- Modify: `assets/handoff.md`, `assets/sprint.md`, `assets/review.md`,
  `assets/pr.md`, `assets/audit.md`

- [x] Brief: context header + objective/AC/Tier/change/owns/contracts/
      non-goals/output format/tools/evidence/stop conditions/read-back.
- [x] Report: coordinator summary, AC evidence, TDD/ATDD, checks,
      doc change/drift, handoff.
- [x] Handoff: header, durable path, checks, read-back.
- [x] Sprint: trace table with task links.
- [x] Review/PR: task id, PR, drift check, `No doc change`.

### Task 4: Freshness and OpenSpec

**Files:**
- Modify: `references/openspec.md`
- Modify: `references/failure-modes.md`
- Modify: `references/audit.md`

- [x] Define `plan|active|done|superseded`, `updated`, `owner`, `sprint`,
      `task`, `change`, `links`.
- [x] Map change ↔ task ↔ review ↔ archive; status is derived/one host.
- [x] Add drift check: old names, future as current, test promise without
      test link, code vs clean doc, generated data copies.
- [x] Add failure modes: ephemeral brief, lost session, stale doc,
      one-file notes, comments claiming coverage, reviewer reconstructing
      from logs, over-parallelization; mitigation for each.
- [x] Add audit metrics and thresholds: discovery, activation, task success,
      efficiency, errors/recovery, durable %, trace %, drift, rework,
      stale claims, map freshness.

### Task 5: Project scaffold

**Files:**
- Modify: `template/AGENTS.md`
- Create: `template/.scrum/README.md`
- Modify: `template/docs/tasks/INDEX.md`
- Modify: `template/docs/concept/product.md`
- Modify: `template/docs/quality/dod.md`
- Modify: `template/docs/tasks/backlog.md`
- Modify: `template/docs/tasks/milestones.md`
- Modify: `template/docs/quality/audits/README.md`

- [x] Add entry levels, durable workspace, freshness and WIP rules.
- [x] Point `INDEX.md` and `AGENTS.md` at `.scrum/README.md` and
      `.scrum/sprints/NN/sprint.md`.
- [x] Add context headers to project docs.

### Task 6: Dry-run example

**Files:**
- Create: `.scrum/README.md`
- Create: `.scrum/state.json`
- Create: `.scrum/board.json`
- Create: `.scrum/events.jsonl`
- Create: `.scrum/sprints/99/README.md`
- Create: `.scrum/sprints/99/sprint.md`
- Create: `.scrum/sprints/99/tasks/99.1/brief.md`
- Create: `.scrum/sprints/99/tasks/99.1/report.md`
- Create: `.scrum/sprints/99/tasks/99.1/handoff.md`
- Create: `.scrum/sprints/99/tasks/99.1/evidence/verify.txt`
- Create: `.scrum/reviews/99-99.1.md`

- [x] Make the example self-contained and clearly marked "dry-run".
- [x] Show a new agent answering where/phase/task/evidence/change in ≤ 3 links.
- [x] Keep it out of installers and out of the project template.

### Task 7: Release and migration

**Files:**
- Modify: `VERSION`
- Modify: `CHANGELOG.md`
- Modify: `README.md`
- Modify: `docs/DECISIONS.md`
- Modify: `references/upgrade.md`

- [x] Bump to `0.5.0`.
- [x] Add v0.5.0 changelog and migration notes.
- [x] Document the new structure and entry map.
- [x] Add D18 to the decision log.
- [x] Add upgrade checks/migration for `.scrum/README.md`, `brief.md`,
      `report.md`, task workspace.

### Task 8: Verification

- [x] `git diff --check` is clean.
- [x] Every relative markdown link resolves.
- [x] No internal reference to removed `assets/task.md` semantics or
      `report.json`; the stub is the only compatibility mention.
- [x] No `docs/tasks/NN-*.md` as the canonical sprint file; legacy mention
      only in migration.
- [x] `SKILL.md`, references and assets agree on paths and statuses.
- [x] Dry-run 3-link check: map → brief → change/No spec change; evidence
      path from brief/report.
- [x] No secrets/absolute paths added.

## Self-Review

- Spec coverage: entry map, two/three-level entry, durable workspace,
  brief package, output-to-files, freshness, conflict-aware WIP, trace,
  metrics, assets, dry-run, version/migration — each has a task.
- No new runtime code.
- One fact per file; templates are the only duplicated shape (by design).
- Review focus: stale phase, broken link, brief in `/tmp`, reviewer reading
  logs, doc describing future as current, test claim without test, six
  parallel tasks on shared files.

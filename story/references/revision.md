> **本文件是技能 `story` 的参考资料 · 修订与连续性审校（Revision & Continuity）。** 按需读取；文中相对路径（`references/...`、`scripts/...`）都相对于技能根目录 `~/.agents/skills/story/`。正文为上游英文原文，保留以免失真——frontmatter 字段名、目录名、命令名以正文为准，不要改写。

## Overview

Revise existing Story Skills projects without losing continuity. Use this skill for targeted chapter edits, continuity audits, developmental revision, line edits, and pre-flight checks before drafting the next chapter.

## Revision Workflow

1. Clarify the pass type unless the user already specified it:
   - **Continuity audit** - find contradictions, stale references, timeline problems, missing backlinks, or word-count drift
   - **Developmental revision** - improve structure, scene purpose, character motivation, pacing, stakes, and arc progression
   - **Line edit** - improve clarity, voice, rhythm, dialogue, and sensory specificity without changing plot facts
   - **Proof/polish** - fix small wording, grammar, repetition, and formatting issues
2. Read the relevant context:
   - `story.md`
   - `chapters/_index.md`
   - The target chapter(s)
   - Previous and next chapters when present
   - Relevant character, location, system, and arc files referenced by the chapter frontmatter
   - Matching scene files in `scenes/`
   - `continuity/state.md`, open questions, and promises/payoffs
   - `plot/timeline.md` and active arc files for continuity-sensitive edits
3. Create a concise revision plan:
   - What will change
   - What must stay fixed for continuity
   - Which files may need updates beyond the chapter
4. Make targeted edits directly in markdown files. Do not create project-local scripts to rewrite prose.
5. Update dependent metadata:
   - Chapter frontmatter `status` (`draft` -> `revised`, `revised` -> `final` only when appropriate)
   - Chapter `word-count` via CLI when available
   - `plot/timeline.md` if events changed
   - `scenes/` records if POV, location, participants, or state changes moved
   - `continuity/state.md`, `continuity/questions/`, or `continuity/promises/` when knowledge, object ownership, mystery state, or payoffs changed
   - Arc plot points or foreshadowing status if the revision changes setup/payoff
   - Character or location files when state, relationship, or location references changed
6. Run maintenance:

```shell
story wordcount . --write
story reindex .
story links .
story validate .
story continuity .
story doctor .
```

`story continuity` deterministically checks death ordering (`died-in` vs later appearances), promise/question chapter ordering, unfired setups, POV/cast consistency, and `continuity/state.md` references. For intentional flashbacks, memories, or recordings of dead characters, list them under chapter or scene `mentions` instead of `characters`.

If `story` is not installed, use `bun run story --` from this repository or the bundled `scripts/story.js` fallback in this skill when available.

## Continuity Audit Checklist

Run `story continuity .` first to collect the deterministic findings, then check for what the CLI cannot judge:

- Character knowledge: no one acts on information they have not learned
- Character state: injuries, emotions, alliances, location, and status carry forward
- Timeline: time of day, travel time, sequence, and cause/effect stay coherent
- Plot arcs: each changed scene still advances or intentionally pauses an arc
- Foreshadowing: planted and paid-off items match arc files
- Promises/questions: durable continuity records match what the chapter now reveals or withholds
- Scene state: every chapter scene has machine-readable POV, location, participants, arcs, and state-change notes
- World rules: magic, technology, politics, and geography stay consistent with worldbuilding files
- References: chapter frontmatter lists every major character, location, and arc advanced in the prose
- Registries: indexes, word counts, and links are current after edits

## Reporting

When the user asks for an audit rather than direct edits, return findings ordered by severity with file references and concrete fixes. When the user asks for revision, summarize the edited files, changed continuity facts, and maintenance results.

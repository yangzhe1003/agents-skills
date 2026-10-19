> **本文件是技能 `story` 的参考资料 · 章节与场景写作（Chapter Writing）。** 按需读取；文中相对路径（`references/...`、`scripts/...`）都相对于技能根目录 `~/.agents/skills/story/`。正文为上游英文原文，保留以免失真——frontmatter 字段名、目录名、命令名以正文为准，不要改写。

## Overview

Write story chapters using an outline-first workflow. Gathers context from all other story elements (characters, world, plot) to maintain consistency, builds a beat-by-beat outline for approval, then writes full prose. After writing, updates all cross-references (chapter index, timeline, foreshadowing).

## Recommended Companion Skill

Before drafting or revising chapter prose, check whether the `better-writing` skill is available in the active agent environment.

- If `better-writing` is available, use it for prose quality, voice calibration, anti-generic writing checks, and the final pre-flight pass before saving the chapter.
- If `better-writing` is not available, recommend installing [forjd/better-writing](https://github.com/forjd/better-writing) with `npx skills add forjd/better-writing` or `bunx skills add forjd/better-writing`, then continue with this skill's built-in writing guidelines if the user does not install it.

## Outline-First Workflow

### 1. Gather Context

Read these files to understand the current story state:

- `story.md` - genre, themes, POV, tense
- `chapters/_index.md` - what's been written, current word count
- `plot/_index.md` - arc status, what needs to happen next
- `plot/timeline.md` - chronological position
- `scenes/_index.md` - scene state already recorded
- `continuity/state.md` - character, object, and knowledge state
- `continuity/questions/_index.md` and `continuity/promises/_index.md` - unresolved mysteries and setup/payoff commitments

If this isn't the first chapter, also read:
- The previous chapter file - for continuity (ending state, cliffhangers, emotional tone)
- Active arc files in `plot/arcs/` - for upcoming plot beats

### 2. Determine Chapter Scope

Ask the user:
- What should this chapter cover? (or suggest based on plot arcs)
- Whose POV?
- Which location(s)?

If plot arcs exist, suggest the next logical beats to advance.

### 3. Build the Outline

Create a beat-by-beat outline listing:
- Each scene/beat and what it accomplishes
- POV character and location for each beat
- Which arc plot points are advanced
- Any foreshadowing to plant or pay off
- Any machine-readable state changes the scene should record

Load the POV character's file for voice reference. Load relevant location files for setting details.

Present the outline to the user for approval. Revise until approved.

### 4. Write the Chapter

With the approved outline, write the full prose:

- Follow the POV and tense from `story.md`
- Use the POV character's voice and speech patterns from their profile
- Ground scenes in location details from worldbuilding files
- Consult `references/writing-guidelines.md` for prose craft guidance
- When available, apply the `better-writing` skill before finalizing prose
- Use the chapter template from `references/chapter-template.md`
- Include the approved outline in the file above the prose (for reference)

Save to `chapters/chapter-{NN}.md` with appropriate frontmatter.

Create or update a matching scene file in `scenes/chapter-{NN}-scene-{NN}.md` for each scene. Scene frontmatter should include `chapter`, `scene`, `pov`, `location`, `characters`, `arcs-advanced`, `status`, and `state-changes` so continuity survives beyond prose.

Write chapter prose directly into the chapter markdown file. Do not stage prose in project-local build scripts, generator scripts, or bulk writer scripts (for example `build-*.js`) to emit chapters. If a temporary helper is truly unavoidable for mechanical file operations, keep it outside the story project and remove it before finishing.

### 5. Post-Write Updates

After the chapter is written:

1. **Update `chapters/_index.md`** - add chapter to registry, update total word count
2. **Update `plot/timeline.md`** - add events from this chapter in chronological order
3. **Update arc files** - mark advanced plot points with chapter reference
4. **Update scene records** - make sure every scene has a corresponding `scenes/` file
5. **Update continuity** - carry forward character state, object ownership, knowledge, open questions, and promises/payoffs
6. **Update foreshadowing** - mark any items as `planted` or `paid-off` with chapter reference
7. **Note character changes** - if a character's status changed (injury, revelation, relationship shift), flag for the user to update the character file
8. **Run CLI maintenance when available:**

```shell
story wordcount . --write
story reindex .
story links .
story validate .
story next .
```

Present a summary of all updates made.

## Scene Breaks

Within a chapter, separate scenes with `---`. Each scene should have a clear POV character (even if the same as the previous scene) and location.

## Revision Handoff

When asked to revise, line edit, polish, or continuity-check an existing chapter, use `references/revision.md`. This skill owns new drafting and chapter creation; `references/revision.md` owns targeted edits, continuity audits, and post-draft cleanup.

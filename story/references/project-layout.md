> **本文件是技能 `story` 的参考资料 · 新建小说项目与目录结构（Project Layout）。** 按需读取；文中相对路径都相对于技能根目录 `~/.agents/skills/story/`。这是新建项目时唯一需要照做的骨架文档——目录名、`_index.md` 注册表、`story.md` frontmatter 都以此为准，不要另造结构。跨领域硬约定见 `SKILL.md` 第 3 节。

## Overview

Initialize a new story project with a structured markdown folder layout. Creates the story bible, registries, scene tracking, continuity state, glossary, worldbuilding folders, plot structure, and chapter tracker - all as cross-referenced markdown files with YAML frontmatter.

## Workflow

1. Ask for basic story information:
   - Title
   - Genre and sub-genre
   - Brief synopsis (2-3 sentences)
   - Setting era/time period
   - Key themes (2-4)
   - POV style (first-person, third-person-limited, third-person-omniscient)
   - Tense (past, present)

If the Story CLI is available, prefer using it to create the starter project, then inspect and refine the generated files as needed:

```shell
story init "{Title}" --genre "{genre}" --sub-genre "{sub-genre}" --setting-era "{era}" --pov "{pov-style}" --tense "{tense}" --synopsis "{synopsis}" --theme "{theme-1}" --theme "{theme-2}"
```

If `story` is not installed, use the bundled CLI that ships with this skill (`scripts/story.js`, invoked with `node`):

```shell
node ~/.agents/skills/story/scripts/story.js init "{Title}"
```

If neither command is available, create the files manually using the steps below.

2. Create the folder structure at the current working directory:

```
{story-title-kebab}/
├── story.md
├── characters/
│   └── _index.md
├── worldbuilding/
│   ├── _index.md
│   ├── locations/
│   ├── systems/
│   ├── factions/
│   └── artifacts/
├── plot/
│   ├── _index.md
│   ├── arcs/
│   └── timeline.md
├── scenes/
│   └── _index.md
├── continuity/
│   ├── state.md
│   ├── questions/
│   │   └── _index.md
│   └── promises/
│       └── _index.md
├── glossary/
│   ├── _index.md
│   └── terms/
└── chapters/
    └── _index.md
```

3. Populate `story.md` with the story bible:

```yaml
---
title: "{Title}"
schema-version: 2
genre: {genre}
sub-genre: {sub-genre}
setting-era: {era}
status: planning
themes:
  - {theme-1}
  - {theme-2}
pov: {pov-style}
tense: {tense}
---
```

Below the frontmatter, include sections:
- **Synopsis** - the 2-3 sentence synopsis provided
- **Tone & Style** - brief notes on the story's voice (derive from genre/themes)
- **Notes** - empty section for the user to fill in

4. Populate each `_index.md` with an empty registry:

**`characters/_index.md`:**
```markdown
---
type: character-registry
story: {story-title-kebab}
---

# Characters

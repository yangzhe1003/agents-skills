> **本文件是技能 `story` 的参考资料 · 世界观构建（Worldbuilding）。** 按需读取；文中相对路径（`references/...`、`scripts/...`）都相对于技能根目录 `~/.agents/skills/story/`。正文为上游英文原文，保留以免失真——frontmatter 字段名、目录名、命令名以正文为准，不要改写。

## Overview

Create and manage world elements for a story project. Locations, systems (magic, politics, technology, etc.), factions, and artifacts are stored as markdown files in the `worldbuilding/` directory with YAML frontmatter. All elements cross-reference characters and other story elements.

## Creating a Location

1. Read `story.md` for genre, era, and tone context
2. Read `worldbuilding/_index.md` for existing locations and systems
3. Ask for the location's name and type (city, fortress, wilderness, etc.)
4. Build the location through conversation, covering:
   - Physical description and atmosphere
   - History relevant to the story
   - Culture and customs of inhabitants
   - Notable features characters will interact with
   - Current state at story's timeline
5. Write the file using `references/location-template.md`
6. Save to `worldbuilding/locations/{name-kebab}.md`
7. Update `worldbuilding/_index.md` locations table
8. If notable characters are listed, verify those character files exist and add this location's kebab-case identifier to each character file's `locations` frontmatter list
9. When CLI access is available, run `story reindex .`, `story links .`, and `story validate .`

## Creating a System

1. Read `story.md` for genre and themes context
2. Read `worldbuilding/_index.md` for existing systems
3. Identify the system type and consult `references/world-element-types.md` for the relevant prompts
4. Build the system through conversation, addressing the key questions for that type
5. Write the file using `references/system-template.md`
6. Save to `worldbuilding/systems/{name-kebab}.md`
7. Update `worldbuilding/_index.md` systems table
8. Cross-reference with characters who interact with the system (e.g., magic-users for a magic system)
9. When CLI access is available, run `story reindex .`, `story links .`, and `story validate .`

## Creating A Faction

Use `story add faction "{Faction Name}" --type "{family|guild|government|military|religion|company|community|criminal|other}"` when the CLI is available. Otherwise create `worldbuilding/factions/{name-kebab}.md` with frontmatter fields `name`, `type`, `status`, `members`, `locations`, and `tags`.

Cover:
- Purpose and ideology
- Power base, resources, and territory
- Important members
- Conflicts and pressure points

## Creating An Artifact

Use `story add artifact "{Artifact Name}" --type "{object|weapon|document|technology|relic|symbol|resource|other}"` when the CLI is available. Otherwise create `worldbuilding/artifacts/{name-kebab}.md` with frontmatter fields `name`, `type`, `status`, `owner`, `location`, and `tags`.

Cover:
- Description and recognition details
- Function, constraints, and costs
- History and prior owners
- Current owner/location state

## Updating World Elements

1. Read the existing file
2. Make the requested changes
3. If cross-references changed, update the linked files
4. Update `worldbuilding/_index.md` if name, type, or status changed
5. When CLI access is available, run `story reindex .`, `story links .`, and `story validate .`

## Cross-Referencing

- Locations reference characters via `notable-characters` in frontmatter
- Characters reference locations via `locations` in frontmatter
- Factions reference character members and locations
- Artifacts reference an owner character or faction and a current location
- Systems reference practitioners via character tags
- When a location is used in a chapter, the chapter's frontmatter `locations` field links back
- Keep the `worldbuilding/_index.md` world overview section current as elements are added

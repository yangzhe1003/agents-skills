> **本文件是技能 `story` 的参考资料 · 人物档案与关系管理（Character Management）。** 按需读取；文中相对路径（`references/...`、`scripts/...`）都相对于技能根目录 `~/.agents/skills/story/`。正文为上游英文原文，保留以免失真——frontmatter 字段名、目录名、命令名以正文为准，不要改写。

## Overview

Create and manage rich character profiles for a story project. Each character is a markdown file with YAML frontmatter in the `characters/` directory. Characters are cross-referenced with other story elements through kebab-case identifiers.

## Creating a Character

1. Read `story.md` for genre, themes, and tone context
2. Read `characters/_index.md` for existing characters
3. Ask for the character's name and role (protagonist, antagonist, supporting, minor)
4. Build the profile through conversation, exploring:
   - Appearance and distinguishing features
   - Personality, traits, and quirks
   - Backstory and formative events
   - Motivations (external wants vs internal needs)
   - Voice and speech patterns (ask for example dialogue)
   - Character arc (starting state, turning points, ending state)
   - Key life events for the timeline
5. Write the character file using the template in `references/character-template.md`
6. Save to `characters/{name-kebab}.md`, or use `story add character "{Name}" --role "{role}"` when the CLI is available
7. Update `characters/_index.md` registry table
8. If relationships reference existing characters, update those character files too
9. When CLI access is available, run the maintenance pass in the story root:

```shell
story reindex .
story links .
story validate .
```

## Updating a Character

1. Read the existing character file
2. Read `characters/_index.md` for context on other characters
3. Make the requested changes
4. If relationships changed, update the other character's file (bidirectional)
5. Update `characters/_index.md` if role or status changed
6. When CLI access is available, run `story reindex .`, `story links .`, and `story validate .`

## Managing Relationships

Reference `references/relationship-types.md` for the full list of relationship types and inverse pairs.

When adding a relationship:
- Add the relationship entry to the character's frontmatter
- Add the inverse relationship to the other character's frontmatter
- Update the Relationship Map section in `characters/_index.md`

## Family Trees

### {Family Name}
- **{Character Name}** ({status}) - [{name-kebab}.md]
  - **{Child Name}** - [{name-kebab}.md]
  - **{Child Name}** - [{name-kebab}.md]
```

Indent children under parents. Note marriages/partnerships inline.

## Cross-Referencing

- When a character is referenced in worldbuilding (e.g., a location's `notable-characters`), ensure the link exists both ways
- Character-location backlinks live in the character file's `locations` frontmatter list
- Faction memberships live in `worldbuilding/factions/{faction-kebab}.md` under `members`
- Artifact ownership can reference a character id in `worldbuilding/artifacts/{artifact-kebab}.md`
- When a character appears in a plot arc, ensure they're listed in the arc's `characters` frontmatter
- Character tags should be consistent across the project (e.g., if `magic-user` is used, always use that exact tag)

> **本文件是技能 `story` 的参考资料 · 势力档案模板（Faction Template）。** 按需读取；文中相对路径都相对于技能根目录 `~/.agents/skills/story/`。正文为上游英文原文，保留以免失真——frontmatter 字段名、目录名以此为准。

# Faction Template

Use this template when creating a faction file at `worldbuilding/factions/{faction-name-kebab}.md`.

```yaml
---
name: "{Faction Name}"
type: {family|guild|government|military|religion|company|community|criminal|other}
status: {active|hidden|declining|defeated|disbanded|unknown}
members:
  - {character-kebab}
locations:
  - {location-kebab}
tags:
  - {tag-1}
---
```

## Purpose

What this faction wants and why it exists.

## Power Base

Resources, influence, territory, legitimacy, secrets, rituals, or leverage.

## Members

Important members and their roles.

## Conflicts

Internal divisions and external opposition.

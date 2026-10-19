> **本文件是技能 `story` 的参考资料 · 地点档案模板（Location Template）。** 按需读取；文中相对路径都相对于技能根目录 `~/.agents/skills/story/`。正文为上游英文原文，保留以免失真——frontmatter 字段名、目录名以此为准。

# Location Template

Use this template when creating a new location file at `worldbuilding/locations/{location-name-kebab}.md`.

```yaml
---
name: "{Location Name}"
type: {city|town|village|fortress|ruins|wilderness|landmark|region|continent|building|other}
region: "{Parent Region}"
population: {number or estimate}
controlled-by: {character-kebab or faction}
notable-characters:
  - {character-kebab}
tags:
  - {tag-1}
  - {tag-2}
status: {thriving|declining|abandoned|contested|hidden}
---
```

## Description

What the location looks, sounds, smells, and feels like. First impressions for someone arriving. Key sensory details that make it distinct.

## History

How the location came to be and key events that happened here. Only include history relevant to the story.

## Culture & Customs

The people who live here, their way of life, traditions, social norms. What makes this place culturally distinct.

## Notable Features

Specific landmarks, buildings, natural features, or points of interest within the location. Things characters would interact with.

## Current State

What the location is like at the time of the story. Political situation, recent events, tensions, opportunities.

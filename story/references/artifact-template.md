> **本文件是技能 `story` 的参考资料 · 器物档案模板（Artifact Template）。** 按需读取；文中相对路径都相对于技能根目录 `~/.agents/skills/story/`。正文为上游英文原文，保留以免失真——frontmatter 字段名、目录名以此为准。

# Artifact Template

Use this template when creating an artifact file at `worldbuilding/artifacts/{artifact-name-kebab}.md`.

```yaml
---
name: "{Artifact Name}"
type: {object|weapon|document|technology|relic|symbol|resource|other}
status: {active|lost|destroyed|hidden|transferred|unknown}
owner: {character-or-faction-kebab}
location: {location-kebab}
tags:
  - {tag-1}
---
```

## Description

What the artifact looks like and how readers recognize it.

## Function

What it can do, what it cannot do, and what it costs.

## History

Origin, prior owners, and story-relevant events.

## Current State

Current owner, location, condition, and unresolved risks.

> **本文件是技能 `story` 的参考资料 · 章节文件模板（Chapter Template）。** 按需读取；文中相对路径都相对于技能根目录 `~/.agents/skills/story/`。正文为上游英文原文，保留以免失真——frontmatter 字段名、目录名以此为准。

# Chapter Template

Use this template when creating a new chapter file at `chapters/chapter-{NN}.md`.

```yaml
---
title: "{Chapter Title}"
number: {N}
pov: {character-kebab}
locations:
  - {location-kebab}
characters:
  - {character-kebab}
mentions:
  - {referenced-character-kebab}
arcs-advanced:
  - {arc-kebab}
status: {outline|draft|revised|final}
word-count: {N}
---
```

`characters` lists characters present in the chapter's scenes. `mentions` is optional and lists characters who are only referenced, remembered, recorded, or seen in flashback - including deceased characters, so `story continuity` does not flag them as posthumous appearances.

## Outline

*Beat-by-beat outline approved before writing:*

1. {Beat 1 - what happens, what it accomplishes}
2. {Beat 2}
3. {Beat 3}
...

**Arc beats advanced:** {Which plot points this chapter hits}
**Foreshadowing planted:** {Any setups placed}
**Foreshadowing paid off:** {Any earlier setups resolved}

---

## Chapter Text

{Full prose goes here}

> **本文件是技能 `obsidian` 的参考资料 · 网页正文提取（Defuddle CLI）。** 按需读取；文中相对路径（`assets/...`、`references/...`）都相对于技能根目录 `~/.agents/skills/obsidian/`。 本文件结构：Usage 与输出格式；缺失时的安装确认门见同目录 `setup.md`。

# Defuddle

Use Defuddle CLI to extract clean readable content from web pages. Prefer over WebFetch for standard web pages — it removes navigation, ads, and clutter, reducing token usage.

If not installed: ask first (Ask User, or in the conversation) and wait for
explicit approval before running `npm install -g defuddle`; the user may
install it manually or skip. A missing tool is not install consent — apply
the gate in `setup.md`（同目录）。

## Usage

Always use `--md` for markdown output:

```bash
defuddle parse <url> --md
```

Save to file:

```bash
defuddle parse <url> --md -o content.md
```

Extract specific metadata:

```bash
defuddle parse <url> -p title
defuddle parse <url> -p description
defuddle parse <url> -p domain
```

## Output formats

| Flag | Format |
|------|--------|
| `--md` | Markdown (default choice) |
| `--json` | JSON with both HTML and markdown |
| (none) | HTML |
| `-p <name>` | Specific metadata property |

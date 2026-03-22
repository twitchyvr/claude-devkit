# claude-status

Starship prompt module that shows Claude Code session info.

## What It Shows

When you're inside a Claude Code session:
```
~/GitRepos/myproject on  main ◆ 6mcp ❯
```

When you're not in a Claude Code session:
```
~/GitRepos/myproject on  main ❯
```

The `◆ 6mcp` indicates:
- `◆` — you're in an active Claude Code session
- `6mcp` — 6 MCP servers are configured

## Starship Configuration

Add to `~/.config/starship.toml`:

```toml
# Add ${custom.claude} to your format string
format = """
$directory\
$git_branch\
$git_status\
${custom.claude}\
$line_break\
$character"""

[custom.claude]
command = "claude-status"
when = '[ -n "$CLAUDE_CODE_SESSION_ID" ] || [ -n "$CLAUDE_SESSION_ID" ]'
format = "[$output]($style) "
style = "bold #cc785c"
shell = ["zsh", "-c"]
description = "Claude Code session indicator"
```

## Performance

The script runs in <100ms — it makes no API calls. It only:
1. Checks if `CLAUDE_CODE_SESSION_ID` or `CLAUDE_SESSION_ID` environment variables are set
2. If yes, reads `~/.claude.json` to count MCP servers
3. Outputs a short string

This is well within Starship's default `command_timeout` of 500ms.

## Customization

Change the style in `starship.toml`:

```toml
# Anthropic orange (default)
style = "bold #cc785c"

# Bright green
style = "bold green"

# Dimmed
style = "dimmed white"
```

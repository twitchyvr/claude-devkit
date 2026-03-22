# claude-devkit

> AI-powered developer tools built on [Claude Code](https://claude.ai/claude-code) CLI.

Four terminal tools that bring AI into your daily git workflow — code reviews, project analysis, commit journaling, and prompt integration. No API keys to manage, no servers to run. Just Claude Code + your terminal.

## Tools

### `ai-review` — Instant AI Code Review

Pipes your git diff to Claude for a structured code review with severity levels and a verdict.

```bash
ai-review              # review staged changes
ai-review HEAD~1       # review last commit
ai-review main         # review entire branch vs main
ai-review --full       # all uncommitted changes
```

**Example output:**

```
── AI Code Review ──────────────────────────
265 lines of diff · model: sonnet

## Summary
Wires v0.7.0 routes into the running Express server.

## Issues
- 🟡 Warning: GET /api/tags/filter is registered after GET /api/tags/:id —
  Express will never reach /filter because :id matches "filter" first.
- 🟢 Suggestion: GET /api/tags is unauthenticated while POST /api/tags is —
  worth a comment since it breaks the pattern.

## Verdict
⚠️ Needs minor fixes

── Review complete ─────────────────────────
```

### `project-brief` — AI Project Overview

Point it at any repo and get a structured overview: what it does, tech stack, how to run it, key files, and current status.

```bash
project-brief                        # current directory
project-brief ~/code/myapp           # any project
project-brief --save                 # also saves to .project-brief.md
```

Great for onboarding onto unfamiliar codebases or quickly recalling what a side project does.

### `devlog-hook` — AI Development Journal

Automatically appends a one-line AI summary to `DEVLOG.md` after every git commit. Runs in the background so commits stay instant.

```bash
devlog-hook --install          # install in current repo
devlog-hook --install-global   # install for ALL repos
```

**DEVLOG.md output:**

```markdown
# Development Log

- `2026-03-13 08:11` [`174b01f`] Enabled v0.7.0 features by integrating routes and middleware
- `2026-03-12 22:45` [`a3f8c21`] Fixed auth token refresh to prevent socket disconnects
- `2026-03-12 19:30` [`e8b2d4f`] Added rate limiting to public API endpoints
```

### `claude-status` — Starship Prompt Module

Shows a `◆ 6mcp` indicator in your [Starship](https://starship.rs) prompt when you're inside a Claude Code session, with the count of active MCP servers. Invisible when Claude isn't running.

## Install

**One-liner:**

```bash
curl -fsSL https://raw.githubusercontent.com/twitchyvr/claude-devkit/main/bin/install.sh | bash
```

**Manual:**

```bash
git clone https://github.com/twitchyvr/claude-devkit.git ~/.claude-devkit
cd ~/.claude-devkit && chmod +x bin/*
```

Then add to your `~/.zshrc` (or `~/.bashrc`):

```bash
export PATH="$HOME/.claude-devkit/bin:$PATH"
```

### Starship Integration

Add to `~/.config/starship.toml`:

```toml
[custom.claude]
command = "claude-status"
when = '[ -n "$CLAUDE_CODE_SESSION_ID" ] || [ -n "$CLAUDE_SESSION_ID" ]'
format = "[$output]($style) "
style = "bold #cc785c"
shell = ["zsh", "-c"]
```

## Prerequisites

- [Claude Code CLI](https://claude.ai/claude-code) installed and authenticated
- `git` (any recent version)
- `zsh` or `bash`

**Optional** (enhance `project-brief` output):
- [`eza`](https://github.com/eza-community/eza) — better directory trees
- [`tokei`](https://github.com/XAManifest/tokei) — code statistics

## Configuration

Set environment variables to customize behavior:

| Variable | Default | Description |
|----------|---------|-------------|
| `CLAUDE_DEVKIT_MODEL` | `haiku` | Model for `devlog-hook` (fast, cheap) |
| `CLAUDE_DEVKIT_REVIEW_MODEL` | `sonnet` | Model for `ai-review` and `project-brief` (smarter) |

Example:

```bash
# Use opus for reviews (more thorough, slower)
CLAUDE_DEVKIT_REVIEW_MODEL=opus ai-review main
```

## How It Works

All tools use `claude -p` (print mode) to run Claude Code non-interactively. No API keys are needed — they use your existing Claude Code authentication.

- **`devlog-hook`** runs as a git `post-commit` hook with `&` (background) so your commit returns instantly. The AI summary appears in DEVLOG.md a few seconds later.
- **`ai-review`** sends the raw git diff as context and gets a structured review back. Uses Sonnet by default for stronger reasoning about code.
- **`project-brief`** gathers context from package files, README, git history, directory structure, and code statistics, then asks Claude to synthesize it into a structured brief.
- **`claude-status`** runs in <100ms — no API calls. It checks environment variables set by Claude Code and reads the local MCP config file.

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md).

## License

[MIT](LICENSE) — Matt Rogers ([@twitchyvr](https://github.com/twitchyvr))

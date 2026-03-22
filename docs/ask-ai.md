# ask-ai (`??`)

AI-powered command lookup — ask a question in plain English, get the exact terminal command.

## Usage

```bash
?? how do I find files larger than 100MB
?? convert this mp4 to gif at 10fps
?? what's using port 3000
?? compress this directory into a tar.gz
?? show git commits from last week
?? -r list all docker containers     # run immediately
```

## How It Works

1. Detects your current project context (Node, Python, Rust, Docker, git branch, etc.)
2. Sends your question + context to Claude via `claude -p`
3. Returns the exact command — no explanation, no markdown, just the command
4. Copies it to your clipboard automatically

## Flags

| Flag | Description |
|------|-------------|
| `-r` | Run the command immediately instead of copying to clipboard |

## Context Detection

`??` automatically reads your current directory and detects:

- **Node.js** — `package.json` present
- **Python** — `pyproject.toml`, `requirements.txt`, or `.venv` active
- **Rust** — `Cargo.toml` present
- **Go** — `go.mod` present
- **Docker** — `Dockerfile` or `docker-compose.yml` present
- **Git** — repo detected, current branch name included
- **OS** — macOS architecture (arm64/x86_64)

This means `?? run tests` gives you `npm test` in a Node project, `python -m pytest` in a Python project, and `cargo test` in a Rust project — without you specifying the stack.

## Configuration

| Variable | Default | Description |
|----------|---------|-------------|
| `CLAUDE_DEVKIT_MODEL` | `haiku` | Claude model (haiku is fast + cheap) |

## Aliases

The tool is installed as `ask-ai`. For convenience, add to your `.zshrc`:

```bash
alias '??'='ask-ai'
alias '?'='ask-ai'
```

## Tips

- Use `-r` when you're confident: `?? -r show disk usage by folder`
- Without `-r`, the command is copied to clipboard — just Cmd+V to paste and review before running
- Prefers modern tools if available (fd over find, rg over grep, eza over ls)
- Works for any CLI question — git, docker, ffmpeg, networking, file manipulation, etc.

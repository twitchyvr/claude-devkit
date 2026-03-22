# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.2.0] - 2026-03-22

### Added
- `ask-ai` (`??`) — AI-powered command lookup: ask in plain English, get the exact terminal command
  - Context-aware: detects Node, Python, Rust, Go, Docker, git
  - Auto-copies command to clipboard
  - `-r` flag to run immediately
  - Prefers modern CLI tools (fd, rg, eza) when available

## [0.1.0] - 2026-03-22

### Added
- `ai-review` — AI-powered code review from git diff
- `project-brief` — AI-generated project overview
- `devlog-hook` — Auto-summarize commits to DEVLOG.md
- `claude-status` — Starship prompt module for Claude Code sessions
- One-line install script
- Configurable model selection via environment variables
- Starship integration example

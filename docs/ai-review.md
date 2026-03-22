# ai-review

AI-powered code review from the terminal.

## Usage

```bash
ai-review              # review staged changes (or unstaged if nothing staged)
ai-review HEAD~1       # review the last commit
ai-review HEAD~3       # review the last 3 commits
ai-review main         # review all changes on current branch vs main
ai-review develop      # review all changes vs develop
ai-review --full       # review all uncommitted changes (staged + unstaged)
```

## How It Works

1. Determines what to diff based on the argument
2. Sends the raw diff to Claude via `claude -p` (print mode)
3. Claude returns a structured review with severity levels
4. Output is formatted and displayed in the terminal

## Output Format

```
── AI Code Review ──────────────────────────
265 lines of diff · model: sonnet

## Summary
One sentence on what the change does.

## Issues
- 🔴 Critical: bugs, security issues, data loss risks
- 🟡 Warning: edge cases, performance, maintainability
- 🟢 Suggestion: style, naming, minor improvements

## Verdict
✅ LGTM | ⚠️ Needs minor fixes | 🚫 Needs rework

── Review complete ─────────────────────────
```

## Configuration

| Variable | Default | Description |
|----------|---------|-------------|
| `CLAUDE_DEVKIT_REVIEW_MODEL` | `sonnet` | Claude model to use |

```bash
# Use opus for a more thorough review
CLAUDE_DEVKIT_REVIEW_MODEL=opus ai-review main

# Use haiku for a quick check
CLAUDE_DEVKIT_REVIEW_MODEL=haiku ai-review
```

## Tips

- Run `ai-review` before creating a PR to catch issues early
- Pipe to a file for documentation: `ai-review main > review.md`
- Large diffs (1000+ lines) may be truncated — split into smaller reviews
- The review references file names and line numbers from the diff, so it's actionable

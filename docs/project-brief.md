# project-brief

AI-generated project overview for any codebase.

## Usage

```bash
project-brief                        # analyze current directory
project-brief ~/code/myapp           # analyze a specific project
project-brief --save                 # also save to .project-brief.md
project-brief ~/code/myapp --save    # analyze + save
```

## What It Gathers

Before calling Claude, `project-brief` automatically collects:

- **Package files**: `package.json`, `pyproject.toml`, `Cargo.toml`, `go.mod`, `*.csproj`, `*.sln`, `CMakeLists.txt`, `Makefile`, `build.gradle`, `pom.xml`
- **Documentation**: `README.md`, `CLAUDE.md`
- **Docker config**: `Dockerfile`, `docker-compose.yml`, `.devcontainer/devcontainer.json`
- **Directory structure**: 2-level tree (via `eza`, `tree`, or `find`)
- **Git info**: current branch, remote URL, last 5 commits
- **Code statistics**: lines of code by language (via `tokei` or `cloc`)

## Output Format

```markdown
## ProjectName

**What it does:** One clear sentence.

**Tech stack:**
- Frontend: React 18, TypeScript, Vite
- Backend: Node.js, Express, TypeScript
- Database: SQLite via better-sqlite3
- Infrastructure: Docker, Dev Containers

**Quick start:**
  npm install && npm run dev

**Key files:**
| File | Purpose |
|------|---------|
| src/server.ts | Express entry point |
| src/db/ | SQLite schema and queries |

**Architecture notes:** ...

**Current status:** ...
```

## Configuration

| Variable | Default | Description |
|----------|---------|-------------|
| `CLAUDE_DEVKIT_REVIEW_MODEL` | `sonnet` | Claude model to use |

## Tips

- Use `--save` to create a `.project-brief.md` you can reference later
- Add `.project-brief.md` to `.gitignore` (already in claude-devkit's default)
- Works on any project in any language — it adapts to whatever package files it finds
- Great for onboarding new team members: `project-brief --save` and commit the result

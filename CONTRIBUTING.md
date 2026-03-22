# Contributing to claude-devkit

Thanks for your interest in contributing!

## Development

1. Fork and clone the repo
2. Make your changes in a feature branch (`feat/my-feature`)
3. Test your changes locally
4. Submit a pull request

## Guidelines

- Keep scripts portable — target zsh and bash where possible
- No external dependencies beyond Claude Code CLI and git
- Optional dependencies (eza, tokei) should have fallbacks
- Scripts should handle errors gracefully — never leave the user with a blank screen
- Keep prompts concise — large prompts cost more tokens and are slower
- Test on both macOS and Linux if possible

## Adding a New Tool

1. Create the script in `bin/`
2. Add `--help` support
3. Add a section to README.md
4. Add the tool to the install script
5. Test it against 2-3 real repos

## Commit Messages

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```
feat(ai-review): add --json output format
fix(devlog-hook): handle repos with no prior commits
docs: add Starship integration examples
```

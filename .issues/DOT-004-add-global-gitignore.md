# DOT-004: Add global gitignore patterns

**Status**: TODO
**Created**: 2025-12-27
**Completed**:
**Blocked By**: DOT-001

## Description

Create global .config/git/ignore with common macOS, Claude, and temporary file patterns.

## Acceptance Criteria

- [x] Ignores .DS_Store and macOS patterns
- [x] Ignores Claude Code config files
- [x] Ignores temporary files (*.swp, *.swo, *~)
- [x] File at ~/.config/git/ignore

## Implementation Notes

Global gitignore applies to all repos. Can expand as needed.

## Related Commits

- `1881991`: DOT-004: Add global gitignore patterns

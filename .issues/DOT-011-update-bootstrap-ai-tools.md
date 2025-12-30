# DOT-011: Update bootstrap for AI tool installation

**Status**: DONE
**Created**: 2025-12-27
**Completed**: 2025-12-30
**Blocked By**:

## Description

Update .config/yadm/bootstrap script to include optional AI tool installation and configuration.

## Acceptance Criteria

- [x] Bootstrap checks if Homebrew is installed
- [x] Bootstrap can optionally install Claude Code
- [x] Bootstrap prompts user before installing
- [x] Decryption still happens first (existing functionality preserved)
- [x] Error handling for missing Homebrew

## Implementation Notes

Expandable design allows adding more AI tools (Codex, Gemini, GitHub Copilot CLI) as needed.

## Related Commits

- `520f78f`: DOT-011: Add AI tool installation to bootstrap

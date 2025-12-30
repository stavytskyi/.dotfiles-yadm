# DOT-001: Add install.sh for fresh macOS

**Status**: DONE
**Created**: 2025-12-27
**Completed**: 2025-12-30
**Blocked By**:

## Description

Create curl-based installer script that bootstraps fresh macOS system with Homebrew, git, and yadm. This is the entry point for new machines.

## Acceptance Criteria

- [x] Installs Homebrew if not present
- [x] Installs git via Homebrew
- [x] Installs yadm via Homebrew
- [x] Clones dotfiles repository
- [x] Detects both Intel and Apple Silicon architectures
- [x] Handles errors gracefully with clear messages
- [x] Can be curl'd from GitHub raw URL

## Implementation Notes

Script location: `./install.sh` (repo root for easy curl access)
Format: DOT-001: Add install.sh for fresh macOS

## Related Commits

- `HASH_PENDING`: DOT-001: Add install.sh for fresh macOS

# DOT-010: Update .zshrc to source .secrets

**Status**: DONE
**Created**: 2025-12-27
**Completed**: 2025-12-30
**Blocked By**:

## Description

Update .zshrc to conditionally source .secrets file for decrypted API keys and environment variables.

## Acceptance Criteria

- [x] .zshrc includes conditional source of ~/.secrets
- [x] Gracefully handles missing .secrets file
- [x] Sourcing happens after Homebrew initialization
- [x] Maintains existing PATH configuration

## Implementation Notes

File is sourced if it exists, allowing API keys to be available in shell environment after decryption.

## Related Commits

- `4fdff7f`: DOT-010: Update .zshrc to source .secrets

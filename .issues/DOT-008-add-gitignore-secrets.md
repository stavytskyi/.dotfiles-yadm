# DOT-008: Add .gitignore for secrets

**Status**: TODO
**Created**: 2025-12-27
**Completed**:
**Blocked By**: DOT-006

## Description

Create .gitignore in repo root to prevent accidentally committing unencrypted secrets.

## Acceptance Criteria

- [x] Ignores .secrets file
- [x] Ignores .env files
- [x] Ignores .key, .pem files
- [x] Ignores SSH private keys (*_rsa, *_ed25519)
- [x] File at repo root

## Implementation Notes

Critical safety net before storing encrypted configs.

## Related Commits

- `ddac4e4`: DOT-008: Add .gitignore for secrets

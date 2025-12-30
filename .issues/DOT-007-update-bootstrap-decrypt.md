# DOT-007: Update bootstrap to handle decrypt

**Status**: TODO
**Created**: 2025-12-27
**Completed**:
**Blocked By**: DOT-006

## Description

Update .config/yadm/bootstrap to handle decryption of encrypted archive.

## Acceptance Criteria

- [x] Checks for ~/.local/share/yadm/archive
- [x] Calls yadm decrypt if archive exists
- [x] Handles missing archive gracefully
- [x] Handles decryption failure with clear error

## Implementation Notes

Decryption will prompt for password on new machines. May fail on wrong password.

## Related Commits

- `ef19012`: DOT-007: Update bootstrap to handle decrypt

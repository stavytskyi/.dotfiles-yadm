# DOT-014: Add Tart VM testing infrastructure

**Status**: DONE
**Created**: 2025-12-30
**Completed**: 2025-12-30
**Blocked By**:

## Description

Налаштувати Tart для тестування dotfiles bootstrap в ізольованій macOS VM.

## Acceptance Criteria

- [x] Tart встановлено через Homebrew
- [x] Базовий macOS VM створено
- [x] Snapshot "clean" системи збережено
- [x] Документація в .tart/README.md
- [x] Скрипт test-dotfiles.sh для автоматизації
- [x] Тест install.sh пройдено в VM (Homebrew/git/yadm OK, yadm clone pending GitHub push)

## Implementation Notes

Tart дозволяє тестувати повний bootstrap flow без ризику для основної системи.

Uses Virtualization.framework on Apple Silicon for native macOS VMs.

## Related Commits

- `611004e`: DOT-014: Add Tart VM testing infrastructure

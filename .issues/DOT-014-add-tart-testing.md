# DOT-014: Add Tart VM testing infrastructure

**Status**: TODO
**Created**: 2025-12-30
**Completed**:
**Blocked By**:

## Description

Налаштувати Tart для тестування dotfiles bootstrap в ізольованій macOS VM.

## Acceptance Criteria

- [ ] Tart встановлено через Homebrew
- [ ] Базовий macOS VM створено
- [ ] Snapshot "clean" системи збережено
- [x] Документація в .tart/README.md
- [x] Скрипт test-dotfiles.sh для автоматизації
- [ ] Тест install.sh пройдено в VM

## Implementation Notes

Tart дозволяє тестувати повний bootstrap flow без ризику для основної системи.

Uses Virtualization.framework on Apple Silicon for native macOS VMs.

## Related Commits

- `611004e`: DOT-014: Add Tart VM testing infrastructure

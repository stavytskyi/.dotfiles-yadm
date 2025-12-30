# DOT-012: Encrypt AI tool configs

**Status**: TODO
**Created**: 2025-12-27
**Completed**:
**Blocked By**:

## Description

Encrypt AI tool configuration files containing API keys using yadm encryption. This creates .local/share/yadm/archive.

## Acceptance Criteria

- [ ] All AI tool config files have real API keys
- [ ] Configs tested locally to verify keys work
- [ ] yadm encrypt creates encrypted archive
- [ ] Encrypted archive tracked by git
- [ ] .config/yadm/encrypt manifest updated
- [ ] All unencrypted config files removed from working directory

## Implementation Notes

**CRITICAL**: Only proceed when you have actual API keys that have been tested locally.

Requires:
- GITHUB_PERSONAL_ACCESS_TOKEN (for GitHub MCP)
- ANTHROPIC_API_KEY (for Claude API)
- Any other API keys for configured tools

Files to encrypt:
- .mcp.json (with GitHub token)
- .secrets (with OPENAI_API_KEY, ANTHROPIC_API_KEY, etc.)
- .config/claude/settings.json (with any sensitive Claude settings)

## Related Commits

- `2ff875e`: DOT-012: Placeholder for encrypting AI tool configs (issue creation)

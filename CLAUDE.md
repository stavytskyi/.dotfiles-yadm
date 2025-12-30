# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

**See Also**: `.claude-repo-config.json` - Configuration rules for commits and workflow

## Repository Purpose

Personal yadm-managed dotfiles repository for macOS development environment focused on:
- DevSecOps workflows
- Data Engineering and AI Development
- AI/Agentic tool configuration (Claude Code, Codex CLI, Gemini CLI, GitHub Copilot CLI)
- Cloud-native development (AWS, GCP, Azure - configured as needed)
- Container orchestration (Docker, Kubernetes - configured as needed)
- Python development (conda, poetry, pip - configured as needed)

---

## Understanding Yadm vs Regular Git

### What is Yadm?
Yadm (Yet Another Dotfiles Manager) is a **git wrapper** specifically designed for managing dotfiles. The key insight: your home directory becomes a git repository, but files stay where they belong.

### How It's Different from Regular Git

**Regular Git Repository:**
```bash
cd ~/my-project          # Go into project folder
git add file.txt         # Add file
git commit -m "msg"      # Commit
# Files are INSIDE the project folder
```

**Yadm Repository:**
```bash
cd ~                     # You're anywhere in $HOME
yadm add .zshrc          # Add dotfile from wherever it lives
yadm commit -m "msg"     # Commit
# Files stay in their NATURAL locations (~/.zshrc stays at ~/.zshrc)
```

### Key Differences

| Aspect | Regular Git | Yadm |
|--------|-------------|------|
| **Working Directory** | Project folder | Your entire $HOME |
| **Repo Location** | `.git` in project | `~/.local/share/yadm/repo.git` (hidden) |
| **Command** | `git <command>` | `yadm <command>` |
| **What Tracked** | Everything (unless .gitignore) | ONLY files you explicitly add |
| **File Location** | Files in project folder | Files stay in natural locations |

### Why This Matters

**Problem**: You want to version control `~/.zshrc`, `~/.gitconfig`, `~/.tmux.conf`, etc.

**Bad Solution**: Move them all to a folder and symlink back (complicated, error-prone)

**Good Solution**: Use yadm - files stay where they belong, git tracks them anyway

### This Repository Setup
- **Remote**: https://github.com/stavytskyi/.dotfiles-yadm.git
- **Current Working Copy**: `/Users/Maksym_Stavytskyi/claude-code/.dotfiles-yadm` (testing before GitHub)
- **What It Manages**: Your home directory (`$HOME`)

---

## Essential Yadm Commands

### Daily Workflow

```bash
# Check what's modified
yadm status

# Track a new dotfile
yadm add ~/.zshrc
yadm add ~/.config/git/config
yadm add ~/.local/bin/myscript.sh

# View changes
yadm diff

# Commit changes
yadm commit -m "Update zshrc with new aliases"

# Push to GitHub
yadm push

# Pull latest changes
yadm pull
```

### Setup on New Machine

```bash
# Install yadm first
brew install yadm

# Clone dotfiles repository
yadm clone https://github.com/stavytskyi/.dotfiles-yadm.git

# Run bootstrap (when created)
yadm bootstrap

# Decrypt encrypted files (if any)
yadm decrypt

# Reload shell
exec zsh
```

### Managing Files

```bash
# List all tracked files
yadm list -a

# Process OS-specific alternates
yadm alt

# Encrypt sensitive files (after adding paths to ~/.config/yadm/encrypt)
yadm encrypt

# Decrypt sensitive files
yadm decrypt

# Show all files yadm would encrypt
cat ~/.config/yadm/encrypt
```

### Advanced Operations

```bash
# Diff between working copy and HEAD
yadm diff HEAD

# View commit history
yadm log --oneline

# Tag a version
yadm tag v1.0.0

# Push tags to remote
yadm push --tags

# Check remote config
yadm remote -v

# Stash changes temporarily
yadm stash
```

---

## AI/Agentic Tool Configurations

This repository manages configurations for multiple AI coding assistants. Each tool is tracked separately so they can be synchronized across machines.

### Claude Code

**Config Locations**:
- Global: `~/.claude/settings.json`
- Per-project: `.claude/settings.json` (in project root)

**What to Track**:
- Global IDE preferences
- Custom prompt templates
- Hook configurations
- MCP server definitions (without API keys!)
- Custom commands

**Example Workflow**:
```bash
# Track global Claude settings (no API keys!)
yadm add ~/.claude/settings.json

# Track custom hooks
yadm add ~/.config/claude/hooks/

# Commit
yadm commit -m "Update Claude Code settings"
```

**Never Track**:
- API tokens in ~/.claude.json
- Personal API keys
- Session tokens

### Codex CLI

**Config Location**: `~/.codex/config.toml` or `~/.config/codex/`

**What to Track**:
- CLI preferences and defaults
- Custom command aliases
- Prompt templates
- Integration settings with other tools

**Example**:
```bash
yadm add ~/.config/codex/config.toml
yadm commit -m "Add Codex CLI configuration"
```

### Gemini CLI

**Config Location**: `~/.config/gemini/config.json` or `~/.gemini/`

**What to Track**:
- CLI configuration
- Model preferences
- Safety and content settings
- Custom system prompts

**Example**:
```bash
yadm add ~/.config/gemini/
yadm commit -m "Configure Gemini CLI"
```

### GitHub Copilot CLI

**Config Location**: `~/.config/github-copilot/config.json`

**What to Track**:
- CLI preferences
- Shell alias configurations
- Integration with other tools
- Custom command settings

**Example**:
```bash
yadm add ~/.config/github-copilot/config.json
yadm commit -m "Setup GitHub Copilot CLI"
```

### Security for AI Tools

**CRITICAL: Never Track**:
- API keys or tokens
- Authentication credentials
- Session cookies
- Personal access tokens
- OAuth tokens

**SAFE to Track**:
- Config structures
- Tool preferences
- Custom prompts/templates
- Aliases and keybindings

**Use These Instead**:
- **Environment variables**: `export CLAUDE_API_KEY=$HOME/.secrets`
- **Keychain**: Store tokens in macOS Keychain
- **Credential helpers**: AWS, GCP, Docker credential helpers
- **Encrypted archive**: Use yadm encrypt for secrets

**Example Config with Env Vars**:
```json
{
  "api_key": "${CLAUDE_API_KEY}",
  "model": "claude-opus-4.5",
  "defaults": {
    "temperature": 0.7
  }
}
```

---

## Directory Structure & Organization

### XDG Base Directory Compliance

Store configurations in `~/.config/` following XDG standard:

```
~/.config/
├── git/                    # Git configuration
│   ├── config
│   ├── ignore
│   └── attributes
├── zsh/                    # Zsh modular configuration
│   ├── .zshenv             # Environment (symlinked from ~/)
│   ├── .zshrc              # Interactive shell (symlinked from ~/)
│   ├── .zprofile           # Login shell (symlinked from ~/)
│   ├── aliases.zsh
│   ├── functions.zsh
│   ├── path.zsh
│   ├── completion.zsh
│   └── history.zsh
├── tmux/                   # Terminal multiplexer
│   ├── tmux.conf
│   └── tmux.conf.local     # Machine-specific overrides
├── claude/                 # Claude Code
│   ├── settings.json
│   └── hooks/
├── codex/                  # Codex CLI
├── gemini/                 # Gemini CLI
├── github-copilot/         # GitHub Copilot
├── aws/                    # AWS CLI (no credentials!)
│   └── config
├── gcloud/                 # Google Cloud SDK
├── azure/                  # Azure CLI
├── docker/                 # Docker CLI
│   └── config.json
├── kubernetes/             # Kubectl/Kubernetes
├── conda/                  # Conda/Anaconda
│   └── .condarc
├── poetry/                 # Poetry (Python)
│   └── config.toml
├── pip/                    # Pip (Python)
│   └── pip.conf
├── yadm/                   # Yadm management
│   ├── bootstrap           # Main bootstrap script
│   └── encrypt             # List of files to encrypt
└── [other tools]/
```

### Root Level Symlinks

Maintain backward compatibility with symlinks:
```bash
~/.zshenv → ~/.config/zsh/.zshenv
~/.zshrc → ~/.config/zsh/.zshrc
~/.zprofile → ~/.config/zsh/.zprofile
~/.gitconfig → ~/.config/git/config
~/.tmux.conf → ~/.config/tmux/tmux.conf
```

### Scripts in ~/.local/bin/

```
~/.local/bin/
├── bootstrap-helpers/      # Helper scripts for bootstrap
│   ├── install-homebrew.sh
│   ├── install-python-tools.sh
│   ├── install-cloud-tools.sh
│   ├── install-container-tools.sh
│   └── setup-macos-defaults.sh
├── [custom scripts]        # Your utility scripts
└── [symlinked binaries]    # From pipx, etc.
```

### Documentation

```
~/.local/share/yadm/docs/
├── CLAUDE.md               # This file
├── README.md               # User-facing guide (future)
└── SETUP.md                # Detailed setup instructions (future)
```

---

## Files to Track with Yadm

### Shell Configuration
- `~/.zshenv` - Environment variables (loaded always, first)
- `~/.zprofile` - Login shell initialization
- `~/.zshrc` - Interactive shell configuration
- `~/.config/zsh/*.zsh` - Modular configs (aliases, functions, path, completion, history)

### Version Control
- `~/.gitconfig` - Git user, aliases, settings
- `~/.config/git/ignore` - Global gitignore patterns
- `~/.config/git/attributes` - Git attributes

### Terminal Multiplexer
- `~/.tmux.conf` - Tmux main configuration
- `~/.config/tmux/tmux.conf.local` - Machine-specific overrides

### AI Tools
- `~/.claude/settings.json` - Claude Code global settings
- `~/.config/claude/hooks/` - Custom hooks
- `~/.config/codex/config.toml` - Codex CLI configuration
- `~/.config/gemini/` - Gemini CLI configuration
- `~/.config/github-copilot/` - GitHub Copilot configuration

### Cloud Provider CLIs
- `~/.config/aws/config` - AWS CLI configuration (no credentials!)
- `~/.config/gcloud/` - Google Cloud SDK configurations
- `~/.config/azure/config` - Azure CLI configuration

### Container Tools
- `~/.config/docker/config.json` - Docker CLI preferences
- `~/.kube/config##template.default` - Kubeconfig template (not actual clusters!)

### Python Development
- `~/.config/conda/.condarc` - Conda settings
- `~/.config/poetry/config.toml` - Poetry configuration
- `~/.config/pip/pip.conf` - Pip defaults
- `~/.config/jupyter/` - Jupyter notebook config (if used)

### Package Management
- `~/.Brewfile` - Homebrew packages and applications

### SSH
- `~/.ssh/config` - SSH client configuration (track this, NOT private keys!)

### Custom Scripts
- `~/.local/bin/*` - All custom scripts and utilities
- `~/.config/yadm/bootstrap` - Bootstrap script (when created)

---

## Files to NEVER Track

**These contain secrets and should be encrypted or excluded:**
- `~/.aws/credentials` - AWS credentials (use encryption)
- `~/.aws/sso/` - AWS SSO cache
- `~/.kube/config` - Actual kubeconfig with cluster access (use encryption or templates)
- `~/.ssh/id_*` - SSH private keys (NEVER track!)
- `~/.ssh/authorized_keys` - SSH public keys (depends on use case)
- `.env` files with secrets
- `.secrets` file with API keys (encrypt it!)
- `~/.gnupg/private-keys-v1.d/` - GPG private keys
- `~/.docker/config.json` - Contains credential helpers
- Any file with passwords, tokens, or API keys

**To encrypt sensitive files:**
1. Add paths to `~/.config/yadm/encrypt`
2. Run `yadm encrypt`
3. Track the encrypted archive: `yadm add ~/.local/share/yadm/archive`

---

## Zsh Configuration Strategy

### Modular Approach

Instead of one large `.zshrc`, use modular files sourced by the main config:

**`.zshenv`** (ALWAYS loaded, before anything else):
```bash
# Environment variables that should be available everywhere
# PATH modifications
# XDG Base Directory variables
# Language and locale settings
```

**`.zprofile`** (Login shells only):
```bash
# Homebrew initialization
# One-time setup tasks
# Programs that should run once per login
```

**`.zshrc`** (Interactive shells):
```bash
# Source modular configs from ~/.config/zsh/
# Shell options and settings
# Plugins and completions
# Aliases and functions (or source them)
```

**`.config/zsh/aliases.zsh`**:
```bash
# alias ll='ls -la'
# alias gs='git status'
# etc.
```

**`.config/zsh/functions.zsh`**:
```bash
# Custom shell functions
# Helper utilities
# Complex operations as reusable functions
```

**`.config/zsh/path.zsh`**:
```bash
# PATH management
# Tool-specific paths
# Order matters!
```

**`.config/zsh/completion.zsh`**:
```bash
# Completion settings
# Tool-specific completions
# Completion styles
```

**`.config/zsh/history.zsh`**:
```bash
# HISTFILE location
# History settings
# History options
```

### Current .zshrc Migration

Your existing `.zshrc` is minimal:
```bash
export PATH="/opt/homebrew/opt/node@22/bin:/Users/Maksym_Stavytskyi/mcp-cox-bin:$PATH"
export PATH="$PATH:/Users/Maksym_Stavytskyi/.local/bin"
if [ -f "$HOME/.secrets" ]; then
    source "$HOME/.secrets"
fi
```

Migration plan:
1. Move `PATH` exports → `~/.config/zsh/path.zsh`
2. Move secrets loading → `~/.zshenv` (or keep encrypted)
3. Create `.zshrc` that sources modular configs
4. Track all with yadm

---

## Common Workflows

### Adding a New Configuration

```bash
# 1. Create config in appropriate location
mkdir -p ~/.config/newtool
vim ~/.config/newtool/config.yaml

# 2. Track with yadm
yadm add ~/.config/newtool/config.yaml

# 3. View what you added
yadm diff --cached

# 4. Commit
yadm commit -m "Add newtool configuration"

# 5. Push to GitHub
yadm push
```

### Migrating an Existing Config to XDG

```bash
# 1. Move config to XDG location
mkdir -p ~/.config/tool
mv ~/old-config ~/.config/tool/config

# 2. Create symlink for backward compatibility (if needed)
ln -s ~/.config/tool/config ~/old-config

# 3. Track both
yadm add ~/.config/tool/config
yadm add ~/old-config  # Symlink

# 4. Verify and commit
yadm diff
yadm commit -m "Migrate tool config to XDG structure"
```

### Tracking a Sensitive File

```bash
# 1. Add file path to encryption list
echo "~/.secrets" >> ~/.config/yadm/encrypt
echo "~/.aws/credentials" >> ~/.config/yadm/encrypt

# 2. Encrypt files
yadm encrypt

# 3. Verify archive was created
ls -lh ~/.local/share/yadm/archive

# 4. Track the encrypted archive
yadm add ~/.local/share/yadm/archive
yadm add ~/.config/yadm/encrypt

# 5. Commit
yadm commit -m "Add encrypted secrets"

# On new machine, decrypt:
yadm decrypt
```

### Handling OS-Specific Files

```bash
# Create macOS-specific file
yadm add ~/.config/tool/config##os.Darwin

# Create Linux-specific file (for future)
yadm add ~/.config/tool/config##os.Linux

# Process all alternates
yadm alt

# View which files are being used
yadm list | grep '##'
```

### Updating on Existing Machine

```bash
# Pull latest changes
yadm pull

# Process OS-specific alternates
yadm alt

# Restart shell to load new configs
exec zsh
```

---

## Bootstrap Script Architecture

### When to Create

Create `~/.config/yadm/bootstrap` after you have multiple tools and configurations tracked.

### Design Principles

- **Idempotent**: Safe to run multiple times
- **Modular**: Separate scripts for each tool category
- **Logged**: All output saved for debugging
- **Optional**: Can skip specific tools with environment variables
- **Error-tolerant**: Continues on failure

### Bootstrap File Structure (Future)

```
~/.config/yadm/bootstrap              # Main orchestrator
├── install-homebrew.sh               # Homebrew packages
├── install-python-tools.sh           # Python tools (pipx, poetry, conda)
├── install-cloud-tools.sh            # AWS, GCP, Azure CLIs (as needed)
├── install-container-tools.sh        # Docker, Kubernetes (as needed)
├── setup-macos-defaults.sh           # macOS preferences
├── setup-symlinks.sh                 # Create XDG symlinks
└── setup-zsh.sh                      # Zsh configuration
```

### Bootstrap Usage (Future)

```bash
# Full bootstrap
yadm bootstrap

# Skip specific tools
SKIP_HOMEBREW=1 yadm bootstrap
SKIP_AWS=1 yadm bootstrap

# Dry run
DRY_RUN=1 yadm bootstrap

# Check logs
tail ~/.local/share/yadm/bootstrap-$(date +%Y%m%d).log
```

### Bootstrap Development

When developing bootstrap scripts:
1. Make them idempotent (check before installing)
2. Capture output for debugging
3. Handle missing dependencies gracefully
4. Test in isolation first
5. Commit with clear messages

---

## Troubleshooting

### Bootstrap Issues

```bash
# Check bootstrap logs
ls ~/.local/share/yadm/bootstrap-*.log
tail -f ~/.local/share/yadm/bootstrap-latest.log

# Run specific bootstrap step with debugging
bash -x ~/.local/bin/bootstrap-helpers/install-python-tools.sh

# Test in dry-run mode
DRY_RUN=1 yadm bootstrap
```

### Merge Conflicts

```bash
# Check status
yadm status

# See what's in conflict
yadm diff

# Edit conflicted file
vim ~/.zshrc  # Fix markers <<<<<<<, =======, >>>>>>>

# Mark as resolved
yadm add ~/.zshrc

# Continue if rebasing
yadm rebase --continue
```

### Encryption Issues

```bash
# View files to be encrypted
cat ~/.config/yadm/encrypt

# Verify encrypted archive exists
ls -lh ~/.local/share/yadm/archive

# Re-encrypt
yadm encrypt

# Decrypt on new machine
yadm decrypt

# Check if decryption failed
yadm decrypt -v  # Verbose mode
```

### Alternates Not Processing

```bash
# Check OS detection
yadm config local.os  # Should show "Darwin"

# List all alternate files
yadm list | grep '##'

# Process alternates with verbose output
yadm alt -v

# Manually process alternates
yadm alt
```

### Remote Issues

```bash
# Check remote configuration
yadm remote -v

# Verify remote connection
yadm fetch

# Set upstream branch
yadm branch -u origin/main

# Pull with rebase if diverged
yadm pull --rebase
```

---

## Repository Branch Strategy

This repository uses multiple branches for different purposes:

### Main Branch (`main`)

**Purpose**: Production dotfiles for deployment to $HOME

**Contains**:
- Only files that should be in your home directory
- Files tracked via `yadm add`
- Examples: `.zshrc`, `.gitconfig`, `~/.config/tmux/tmux.conf`, `~/.local/bin/*`

**When Used**:
- When user runs `yadm clone https://github.com/stavytskyi/.dotfiles-yadm.git`
- Files are automatically deployed to $HOME

**Important**: Nothing else goes here - no documentation, no scripts for claude

### Documentation Branch (`docs`)

**Purpose**: Documentation and guidance for Claude instances

**Contains**:
- CLAUDE.md (this file)
- README.md (future)
- CONTRIBUTING.md (future)
- Development guides
- Instructions for other claude instances

**NOT deployed to**: $HOME (intentionally excluded)

**When Used**:
- Claude instances work on this branch
- Rebase with main as needed to get latest dotfiles info
- Keep in sync but separate from production files

### Branch Workflow for Claude Instances

**When You (User) Switch Claude to a Different Branch**:

```bash
# User tells Claude which branch to check out
git checkout docs  # Or whichever branch has the work

# Claude then works on that branch normally
git status
git add [files]
git commit -m "message"
```

**Important for Claude Instances**:
1. Always check which branch you're on: `git branch`
2. If on `main` - use `yadm add` for home directory files
3. If on `docs` - use regular `git add` for documentation/guides
4. Never mix files from different purposes in the same branch

### Synchronizing Between Branches

**When `main` gets updated and `docs` needs to sync**:

```bash
# User does this (not Claude):
git checkout docs
git rebase main       # Bring in latest from main
git push origin docs  # Push updated docs branch
```

**Why This Matters**:
- `main` = what gets deployed to machines
- `docs` = how to work with this repo
- They're kept separate but synchronized
- When new configs appear in `main`, documentation can be updated accordingly

---

## Best Practices for Claude Instances

When assisting with this dotfiles repository:

### Branch-Specific Rules

**If on `main` branch** (working with dotfiles):
1. **Always check branch first**: `git branch` - verify you're on main
2. **Use yadm for $HOME files**: `yadm add ~/.zshrc`, `yadm status`, `yadm commit`
3. **Never use git add** for home directory files - use yadm!
4. **Only production files**: Keep only files that should be in $HOME

**If on `docs` branch** (working with documentation):
1. **Verify branch**: `git branch` - confirm you're on docs
2. **Use regular git**: `git add`, `git commit` for documentation files
3. **Update documentation**: When main changes affect how things work
4. **Don't track dotfiles**: Never add ~/.zshrc, ~/.gitconfig here

### General Best Practices

1. **Always check which branch you're on**: `git branch` first thing
2. **Follow XDG structure**: Put configs in `~/.config/` when possible
3. **Keep changes modular**: Small, focused files instead of monoliths
4. **Document why**: Explain non-obvious configuration choices
5. **Test locally**: Verify changes work before committing
6. **Use clear messages**: Commit messages should explain what and why
7. **Never commit secrets**: Check for API keys, tokens, credentials
8. **Consider alternates**: Use `##os.Darwin` for macOS-specific files
9. **Update documentation**: When you change main, consider updating docs
10. **Verify on test machines**: Ensure bootstrap works end-to-end (when available)

### Atomic Commits

**What is an atomic commit?**
A change that modifies ONE aspect and is independently testable/verifiable as working.

**Good Examples**:
```
✅ Add tmux configuration
✅ Configure Claude Code MCP servers
✅ Update Zsh PATH configuration
✅ Add AWS CLI configuration
```

**Bad Examples**:
```
❌ Update stuff (too vague)
❌ Add tmux + update zsh + fix git (multiple changes mixed together)
❌ WIP: configuring (incomplete)
```

**Rules**:
1. One logical change per commit
2. Commit after each testable change
3. Use imperative mood in messages
4. Be descriptive about what changed and why

### Common User Requests

**"Add configuration for X"**:
1. Create config in appropriate location
2. Track with `yadm add` (on main branch)
3. Review with `yadm diff`
4. Commit with atomic, descriptive message
5. Push to GitHub

**"Update tool Y settings"**:
1. Modify config file
2. Run `yadm diff` to review changes
3. Test the changes
4. Commit if working

**"Set up new machine"**:
1. Verify yadm is installed
2. Clone: `yadm clone <repo-url>`
3. Run: `yadm bootstrap` (when available)
4. Decrypt: `yadm decrypt`
5. Verify all tools installed

**"Fix broken configuration"**:
1. Check recent changes: `yadm log -n 5`
2. View diff: `yadm show <commit>`
3. Revert if needed: `yadm revert <commit>`
4. Or fix and commit: `yadm add <file>` + `yadm commit`

---

## Resources

### Official Documentation
- **Yadm Docs**: https://yadm.io/docs/overview
- **Yadm Alternates**: https://yadm.io/docs/alternates
- **Yadm Bootstrap**: https://yadm.io/docs/bootstrap
- **Yadm Encryption**: https://yadm.io/docs/encryption

### Standards & References
- **XDG Base Directory**: https://specifications.freedesktop.org/basedir-spec/latest/
- **Homebrew**: https://brew.sh/
- **Zsh Manual**: https://zsh.sourceforge.io/Doc/Release/

### Related Projects
- **Oh My Zsh**: https://ohmyz.sh/
- **Starship Prompt**: https://starship.rs/ (modern shell prompt)
- **Tmux Plugin Manager**: https://github.com/tmux-plugins/tpm

---

## Current State

### Existing Configurations
- `~/.zshrc` - Minimal, needs modularization
- `~/.gitconfig` - User identity configured ✓
- `~/.config/git/ignore` - Global gitignore exists ✓
- `~/.local/bin/whisper-dictation.sh` - Custom script exists ✓

### Next Steps (On Demand)

When you need something, just ask:
- "Modularize my zsh config" → I'll create `~/.config/zsh/*.zsh` files
- "Configure tmux" → I'll create `~/.config/tmux/tmux.conf`
- "Track my Brewfile" → I'll create and track `~/.Brewfile`
- "Set up Claude Code config tracking" → I'll configure `~/.claude/`
- "Add AWS CLI" → I'll create `~/.config/aws/config`
- "Build bootstrap script" → I'll create modular bootstrap when ready

**This is built incrementally - add what you need, when you need it!**

---

## Repository Information

- **Remote Repository**: https://github.com/stavytskyi/.dotfiles-yadm.git
- **Maintainer**: Maksym Stavytskyi (stavytskyi@gmail.com)
- **Focus Areas**: DevSecOps, Data Engineering, AI Development
- **Platform**: macOS with Zsh
- **Last Updated**: 2025-12-26

---

## Notes for Future Users

This repository is designed to be:
- **Minimal at start**: Only what you need
- **Incremental**: Add configs as needed
- **Portable**: Restore on any macOS machine
- **Secure**: Encrypts sensitive data
- **Well-documented**: Clear workflows and explanations

The philosophy: **Start simple, add as you go, keep it organized.**

All configurations follow XDG Base Directory specification for modern, organized file structure.

All documentation is in English for clarity and broad understanding.

Questions about specific tools? Ask and I'll help add them!

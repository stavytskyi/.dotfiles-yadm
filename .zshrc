# Minimal .zshrc for yadm-managed dotfiles
# Created: 2025-12-27

# Homebrew setup (Apple Silicon)
if [[ -f "/opt/homebrew/bin/brew" ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Add user binaries to PATH
export PATH="$HOME/.local/bin:$PATH"

# Load secrets (decrypted by yadm bootstrap)
if [ -f "$HOME/.secrets" ]; then
    source "$HOME/.secrets"
fi

# Expand incrementally - modular configs coming soon

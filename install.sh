#!/bin/bash
set -e

echo "=== Dotfiles Installation Started ==="

# STEP 1: Install Homebrew (if not present)
if ! command -v brew &> /dev/null; then
    echo "Installing Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add Homebrew to PATH for this session
    if [[ $(uname -m) == 'arm64' ]]; then
        eval "$(/opt/homebrew/bin/brew shellenv)"
    else
        eval "$(/usr/local/bin/brew shellenv)"
    fi
else
    echo "✓ Homebrew already installed"
fi

# STEP 2: Install git via Homebrew (better than Apple's git)
if ! brew list git &> /dev/null; then
    echo "Installing git via Homebrew..."
    brew install git
else
    echo "✓ Git already installed"
fi

# STEP 3: Install yadm
if ! command -v yadm &> /dev/null; then
    echo "Installing yadm..."
    brew install yadm
else
    echo "✓ Yadm already installed"
fi

# STEP 4: Clone dotfiles repository
if [ -d "$HOME/.local/share/yadm/repo.git" ]; then
    echo "✓ Dotfiles already cloned"
else
    echo "Cloning dotfiles repository..."
    yadm clone https://github.com/stavytskyi/.dotfiles-yadm.git
fi

# STEP 5: Run yadm bootstrap (if exists)
if [ -f "$HOME/.config/yadm/bootstrap" ]; then
    echo "Running bootstrap script..."
    "$HOME/.config/yadm/bootstrap"
else
    echo "! No bootstrap script found (will be added in later commits)"
fi

echo "=== Installation Complete ==="
echo ""
echo "Next steps:"
echo "1. Restart your shell: exec zsh"
echo "2. Verify installation: yadm status"
echo ""
echo "Your dotfiles are now managed by yadm!"

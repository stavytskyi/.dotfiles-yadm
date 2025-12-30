#!/bin/bash
set -e

# Tart VM Testing Script for Dotfiles
# Usage: ./.tart/test-dotfiles.sh [--no-restore]

VM_NAME="dotfiles-test"
CLEAN_SNAPSHOT="dotfiles-test-clean"

echo "=== Dotfiles Testing with Tart ==="
echo ""

# Check if Tart is installed
if ! command -v tart &> /dev/null; then
    echo "Error: Tart is not installed."
    echo "Install with: brew install cirruslabs/cli/tart"
    exit 1
fi

# Check if clean snapshot exists
if ! tart list 2>/dev/null | grep -q "$CLEAN_SNAPSHOT"; then
    echo "Error: Clean snapshot '$CLEAN_SNAPSHOT' not found."
    echo ""
    echo "Create it first:"
    echo "  1. tart clone ghcr.io/cirruslabs/macos-sequoia-base:latest $VM_NAME"
    echo "  2. tart run $VM_NAME  # Configure VM, enable SSH"
    echo "  3. tart clone $VM_NAME $CLEAN_SNAPSHOT"
    exit 1
fi

# Restore clean state unless --no-restore flag
if [[ "$1" != "--no-restore" ]]; then
    echo "Restoring clean VM state..."
    tart delete "$VM_NAME" 2>/dev/null || true
    tart clone "$CLEAN_SNAPSHOT" "$VM_NAME"
    echo "Clean state restored."
    echo ""
fi

# Start VM
echo "Starting VM..."
echo "Connect via VNC window or SSH to test."
echo ""
echo "To test dotfiles, run in VM:"
echo "  curl -fsSL https://raw.githubusercontent.com/stavytskyi/.dotfiles-yadm/main/install.sh | bash"
echo ""
echo "To test local changes (not pushed):"
echo "  1. Get VM IP from network settings"
echo "  2. scp install.sh admin@<VM_IP>:~/"
echo "  3. ssh admin@<VM_IP>"
echo "  4. bash ~/install.sh"
echo ""
echo "Press Ctrl+C to stop VM when done."
echo ""

tart run "$VM_NAME"

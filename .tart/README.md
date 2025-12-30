# Tart VM Testing for Dotfiles

Testing dotfiles in isolated macOS VM using [Tart](https://github.com/cirruslabs/tart).

## What is Tart?

- Open-source macOS VM tool from Cirrus Labs
- Uses Apple's Virtualization.framework (Apple Silicon only)
- CLI-based, easy to automate
- Supports cloning for quick snapshot restore

## Prerequisites

```bash
# Install Tart via Homebrew
brew install cirruslabs/cli/tart
```

## Initial Setup (One-time)

### 1. Create Base VM

```bash
# Download macOS Sequoia base image (~15GB, takes time)
tart clone ghcr.io/cirruslabs/macos-sequoia-base:latest dotfiles-test
```

### 2. Configure VM

```bash
# Start VM
tart run dotfiles-test

# In VM:
# 1. Complete initial macOS setup
# 2. System Settings > General > Sharing > Enable "Remote Login" (SSH)
# 3. Note the VM IP: System Settings > Network > Wi-Fi/Ethernet > IP
```

### 3. Create Clean Snapshot

```bash
# Stop VM (Cmd+Q in VM window or shutdown from menu)

# Clone as clean snapshot
tart clone dotfiles-test dotfiles-test-clean

# Verify
tart list
```

## Testing Dotfiles

### Option 1: Manual Testing

```bash
# Restore clean state
tart delete dotfiles-test
tart clone dotfiles-test-clean dotfiles-test

# Start VM
tart run dotfiles-test

# In VM terminal, run:
curl -fsSL https://raw.githubusercontent.com/stavytskyi/.dotfiles-yadm/main/install.sh | bash
```

### Option 2: Automated Script

```bash
# Use the test script
./.tart/test-dotfiles.sh
```

### Option 3: SSH Testing

```bash
# Get VM IP (shown at boot or in network settings)
VM_IP="192.168.64.X"

# SSH into VM
ssh admin@$VM_IP

# Run dotfiles install
curl -fsSL https://raw.githubusercontent.com/stavytskyi/.dotfiles-yadm/main/install.sh | bash
```

## VM Management

```bash
# List all VMs
tart list

# Delete VM
tart delete dotfiles-test

# Get VM info
tart get dotfiles-test

# Stop running VM
tart stop dotfiles-test
```

## Testing Workflow

1. **Make changes** to dotfiles in repo
2. **Push to GitHub** (or test from local branch)
3. **Restore clean VM**: `tart delete dotfiles-test && tart clone dotfiles-test-clean dotfiles-test`
4. **Run VM**: `tart run dotfiles-test`
5. **Execute install.sh** in VM
6. **Verify** everything works
7. **Repeat** as needed

## Troubleshooting

### VM Won't Start
```bash
# Check if another VM is running
tart list

# Stop stuck VM
tart stop dotfiles-test
```

### SSH Connection Refused
- Ensure "Remote Login" is enabled in VM System Settings
- Check VM IP address (can change after restart)
- Default user is usually `admin`

### Slow Performance
- Close other apps on host
- Tart VMs use shared resources
- Consider adjusting VM resources: `tart set dotfiles-test --cpu 4 --memory 8192`

## Notes

- Base images are ~15GB, clones are differential (smaller)
- VMs are stored in `~/.tart/`
- SSH keys need to be set up separately in VM
- For testing local changes (not pushed), mount a shared folder or copy files via SSH

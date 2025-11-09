#!/usr/bin/env bash
set -e

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

backup_if_exists() {
    local target="$1"
    if [ -e "$target" ] || [ -L "$target" ]; then
        local backup="${target}.bak"
        if [ -e "$backup" ]; then
            backup="${target}.bak.$(date +%Y%m%d-%H%M%S)"
        fi
        echo "⚠️  Found existing $target — renaming to $backup"
        mv "$target" "$backup"
    fi
}

create_symlink() {
    local src="$1"
    local dest="$2"

    if [ ! -e "$src" ]; then
        echo "❌ Error: source $src does not exist!"
        return 1
    fi

    backup_if_exists "$dest"
    echo "🔗 Creating symlink: $dest -> $src"
    ln -s "$src" "$dest"
}

echo "🚀 Setting up development symlinks..."

# 1️⃣ Neovim config
create_symlink "$SCRIPT_DIR/nvim" "$HOME/.config/nvim"

# 2️⃣ Tmux config
create_symlink "$SCRIPT_DIR/.tmux.conf" "$HOME/.tmux.conf"

echo "✅ All symlinks created successfully."


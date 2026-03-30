#!/usr/bin/env bash
set -e

# ── Config ────────────────────────────────────────────────────────────────────
# The canonical dotfiles location. The repo should be cloned here, OR
# a symlink should exist here pointing to where it was cloned.
DOTFILES="$HOME/.dotfiles"

# If the repo was cloned as ~/dotfiles (no dot), create the canonical symlink.
if [ ! -e "$DOTFILES" ] && [ -d "$HOME/dotfiles" ]; then
  echo "==> Symlinking ~/dotfiles -> ~/.dotfiles..."
  ln -s "$HOME/dotfiles" "$DOTFILES"
fi

if [ ! -d "$DOTFILES" ]; then
  echo "ERROR: Dotfiles directory not found at $DOTFILES"
  echo "Clone the repo first: git clone <url> ~/.dotfiles"
  exit 1
fi

echo "==> Installing dependencies..."
sudo apt update && sudo apt install -y zsh git curl fzf tmux

echo "==> Installing Oh My Zsh..."
if [ ! -d "$HOME/.oh-my-zsh" ]; then
  RUNZSH=no CHSH=no sh -c \
    "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

echo "==> Installing zsh plugins..."
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

# Syntax highlighting
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
    "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
fi

# Autosuggestions (fish-style inline suggestions)
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions.git \
    "$ZSH_CUSTOM/plugins/zsh-autosuggestions"
fi

echo "==> Symlinking dotfiles..."
ln -sf "$DOTFILES/zsh/.zshrc" "$HOME/.zshrc"
ln -sf "$DOTFILES/zsh/aliases.zsh" "$HOME/.aliases.zsh"

echo "==> Setting zsh as default shell..."
# chsh may not work in WSL; if it fails, add 'exec zsh' to ~/.bashrc instead
if chsh -s "$(which zsh)" 2>/dev/null; then
  echo "    Default shell set to zsh."
else
  echo "    chsh failed (common in WSL). Adding 'exec zsh' to ~/.bashrc instead..."
  grep -qxF 'exec zsh' "$HOME/.bashrc" || echo 'exec zsh' >> "$HOME/.bashrc"
fi

echo "==> Done! Start a new session or run: exec zsh"

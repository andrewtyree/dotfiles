# ── Oh My Zsh ────────────────────────────────────────────────────────────────
export ZSH="$HOME/.oh-my-zsh"

# Prompt theme — agnoster shows git branch, exit code, virtualenv
ZSH_THEME="agnoster"

# Plugins
plugins=(
  git                        # git aliases (gst, gco, gp, etc.)
  fzf                        # Ctrl+R fuzzy history, Ctrl+T fuzzy file
  zsh-autosuggestions        # fish-style inline suggestions (→ to accept)
  zsh-syntax-highlighting    # red = bad command, green = good
  colored-man-pages          # colorized man pages
  sudo                       # press Esc Esc to prepend sudo
  tmux                       # tmux aliases
  extract                    # `extract file.tar.gz` just works
)

source "$ZSH/oh-my-zsh.sh"

# ── History ───────────────────────────────────────────────────────────────────
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.zsh_history
setopt HIST_IGNORE_DUPS       # don't save duplicate commands
setopt HIST_IGNORE_SPACE      # commands starting with space aren't saved
setopt SHARE_HISTORY          # share history across tmux panes

# ── fzf ───────────────────────────────────────────────────────────────────────
# Ctrl+R = fuzzy history search
# Ctrl+T = fuzzy file picker
# Alt+C  = fuzzy cd
export FZF_DEFAULT_OPTS="--height 40% --layout=reverse --border"
[ -f /usr/share/doc/fzf/examples/key-bindings.zsh ] && \
  source /usr/share/doc/fzf/examples/key-bindings.zsh

# ── Autosuggestions ───────────────────────────────────────────────────────────
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#666666"
bindkey '→' autosuggest-accept   # right arrow accepts suggestion

# ── Completion ────────────────────────────────────────────────────────────────
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select          # arrow-key menu
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'  # case-insensitive

# ── Aliases ───────────────────────────────────────────────────────────────────
[ -f "$HOME/.aliases.zsh" ] && source "$HOME/.aliases.zsh"

# ── Path ──────────────────────────────────────────────────────────────────────
export PATH="$HOME/bin:$PATH"

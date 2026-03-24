# ── Navigation ────────────────────────────────────────────────────────────────
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ~='cd ~'
alias ll='ls -lah --color=auto'
alias la='ls -A --color=auto'
alias l='ls -CF --color=auto'
alias cls='clear'

# mkdir + cd in one shot
mkcd() { mkdir -p "$1" && cd "$1"; }

# fuzzy cd into any subdirectory
fcd() { cd "$(find . -type d | fzf)" }

# ── Git ───────────────────────────────────────────────────────────────────────
# (Oh My Zsh git plugin covers most of these, but extras below)
alias gs='git status'
alias ga='git add'
alias gc='git commit -m'
alias gca='git commit --amend --no-edit'
alias gp='git push'
alias gpl='git pull'
alias gl='git log --oneline --graph --decorate --all'
alias gd='git diff'
alias gco='git checkout'
alias gcb='git checkout -b'
alias gundo='git reset --soft HEAD~1'   # undo last commit, keep changes

# ── Raspberry Pi ──────────────────────────────────────────────────────────────
alias sctl='sudo systemctl'
alias jctl='sudo journalctl -xe'
alias pinhole='ssh pi@pihole.local'     # adjust if you use Pi-hole by hostname

# ── TinTin++ / MUD ───────────────────────────────────────────────────────────
# Start a new named tmux session running tt++
mud-new() {
  local session="${1:-mud}"
  tmux new-session -s "$session" "tt++ ${2:-}"
}

# Attach to existing session, or create one
mud() {
  local session="${1:-mud}"
  tmux attach -t "$session" 2>/dev/null || mud-new "$session"
}

# List active mud sessions
mud-list() {
  tmux list-sessions 2>/dev/null | grep -i mud || echo "No active mud sessions"
}

# Kill a mud session
mud-kill() {
  tmux kill-session -t "${1:-mud}"
}

# ── Quality of Life ──────────────────────────────────────────────────────────
alias grep='grep --color=auto'
alias df='df -h'
alias du='du -sh'
alias free='free -h'
alias ports='ss -tulnp'                 # what's listening
alias myip='curl -s ifconfig.me'
alias path='echo $PATH | tr ":" "\n"'  # print PATH one entry per line
alias reload='source ~/.zshrc'

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export PRINTER=M70

export PATH="$PATH:$HOME/.local/bin:/home/user/.local/share/gem/ruby/3.0.0/bin"
# For Chromium development
export PATH="$PATH:$HOME/repos/depot_tools"
# Golang
export PATH="$PATH:$(go env GOBIN):"

# Editor exports
export VISUAL=nvim
export EDITOR="$VISUAL"
export FCEDIT="$VISUAL"
export MANPAGER='nvim +Man!'
export MANWIDTH=999

# Colorize less pages
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

export BAT_THEME="GitHub"

# History options
HISTFILE=~/.histfile
HISTSIZE=5000
SAVEHIST=5000
setopt EXTENDED_HISTORY          # Write the history file in the ":start:elapsed;command" format.
setopt INC_APPEND_HISTORY        # Write to the history file immediately, not when the shell exits.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire duplicate entries first when trimming history.
setopt HIST_IGNORE_DUPS          # Don't record an entry that was just recorded again.
setopt HIST_IGNORE_ALL_DUPS      # Delete old recorded entry if new entry is a duplicate.
setopt HIST_FIND_NO_DUPS         # Do not display a line previously found.
setopt HIST_IGNORE_SPACE         # Don't record an entry starting with a space.
setopt HIST_SAVE_NO_DUPS         # Don't write duplicate entries in the history file.
setopt HIST_REDUCE_BLANKS        # Remove superfluous blanks before recording entry.

setopt interactivecomments       # Allow typing comments at an interactive prompt

setopt CD_SILENT

# Aliases and Functions
alias ls='exa --git --classify --group-directories-first --sort=extension --color=always'
alias cat='bat'
alias shred='shred --remove --zero --iterations=4'
alias rm='rm -Iv'
alias c='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias info='info --vi'
alias ssh='TERM=xterm-256color ssh' # So ssh works properly with kitty
alias v='nvim'
alias icat='kitty +kitten icat'
alias gdb='gdb -q'
alias npm='npm --color=always'
alias sudo='sudo ' # Allow for aliases https://askubuntu.com/questions/22037/aliases-not-available-when-using-sudo
alias odin='$HOME/repos/Odin/odin'

# https://stackoverflow.com/questions/2507766/merge-convert-multiple-pdf-files-into-one-pdf
function mergepdf() {
  gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/default \
    -dNOPAUSE -dQUIET -dBATCH -dDetectDuplicateImages -dCompressFonts=true \
    -r150 -sOutputFile="$1" "${@:1}"
}

# TODO is there a way to make these functions aliases?

venvdir="$HOME/.venv"

function activate() {
  source "$venvdir"/"$1"/bin/activate
}

# Prompt fanciness
autoload -Uz vcs_info add-zsh-hook
setopt PROMPT_SUBST
add-zsh-hook precmd vcs_info
zstyle ':vcs_info:git:*' formats '(%b) '
PROMPT='%F{blue}%~ %F{red}${vcs_info_msg_0_}%f%F{blue}%#%f '

# Use emacs-like keybinds at the command line
bindkey -e

# fzf
source $HOME/.config/fzf/fzf.zsh
export FZF_DEFAULT_OPTS="-m --color='light,fg:#586069,bg:#ffffff,preview-fg:#586069,preview-bg:#ffffff,bg+:#dbe9f9,pointer:#cd3131,spinner:#dbe9f9,hl:#14ce14,hl+:#14ce14' --preview 'bat --style=numbers --color=github {} 2>/dev/null'"

# Keybinds
bindkey "^[[3~" delete-char     # Make 'delete' actually delete
bindkey \^U backward-kill-line  # CTRL-u works as in bash
bindkey "^[[1;5C" forward-word  # CTRL-right moves right a word
bindkey "^[[1;5D" backward-word # CTRL-left moves left a word

### Added by Zinit's installer
if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit" && command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
### End of Zinit's installer chunk

autoload -Uz compinit; compinit

zinit wait lucid blockf for \
    atinit"zicompinit; zicdreplay" \
    zdharma-continuum/fast-syntax-highlighting \
    chisui/zsh-nix-shell \
    atload"prompt_nix_shell_setup" \
    spwhitt/nix-zsh-completions \
    Aloxaf/fzf-tab \
    MichaelAquilina/zsh-auto-notify \
    hlissner/zsh-autopair

# fzf-tab config TODO -- see brokenbyte's

# Autocompletion
# The following lines were added by compinstall
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' completer _complete _ignored _correct
zstyle ':completion:*' format '%d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' ignore-parents parent
zstyle ':completion:*' insert-unambiguous true
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list '' 'm:{[:lower:]}={[:upper:]} m:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*' max-errors 2 numeric
zstyle ':completion:*' menu select=7
zstyle ':completion:*' original true
zstyle ':completion:*' preserve-prefix '//[^/]##/'
zstyle ':completion:*' select-prompt %S current selection at %p%s
zstyle ':completion:*' squeeze-slashes true
zstyle ':completion:*' verbose true
zstyle :compinstall filename '/home/user/.zshrc'
# End of lines added by compinstall

# autoload -U colors && colors TODO is this necessary?
autoload edit-command-line # Prevent weird things from happening with entering text on the command line
zle -N edit-command-line
setopt COMPLETE_ALIASES # autocompletion of command line switches for aliases
kitty + complete setup zsh | . /dev/stdin # Completion for kitty

_ZD_FZF_OPTS="-m --preview 'bat --style=numbers --color=always {} 2>/dev/null'"

# zoxide (must be called after compinit)
eval "$(zoxide init zsh --cmd j)"

# nvm (normally in `init-nvm.sh`, but I prefer to be explicit)
[ -z "$NVM_DIR" ] && export NVM_DIR="$HOME/.nvm"
source /usr/share/nvm/nvm.sh
source /usr/share/nvm/install-nvm-exec
#source /usr/share/nvm/bash_completion we use zsh

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

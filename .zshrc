# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export PRINTER=M70

export PATH="$PATH:$HOME/.local/bin:/home/user/.local/share/gem/ruby/3.0.0/bin"

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

# Changing directories
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
alias icat="kitty +kitten icat"
alias gdb="gdb -q"
alias npm="npm --color=always"

# https://stackoverflow.com/questions/2507766/merge-convert-multiple-pdf-files-into-one-pdf
function mergepdf() {
  gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/default \
    -dNOPAUSE -dQUIET -dBATCH -dDetectDuplicateImages -dCompressFonts=true \
    -r150 -sOutputFile=$1 ${@:1}
}

venvdir="$HOME/.venv"

function activate() {
  source $venvdir/$1/bin/activate
}

function venv() {
  cd $venvdir
  python3 -m venv $1
  cd -
}

####################
# zsh-only configs #
####################

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
autoload -Uz compinit
compinit
# End of lines added by compinstall
autoload edit-command-line # Prevent weird things from happening with entering text on the command line
zle -N edit-command-line
setopt COMPLETE_ALIASES # autocompletion of command line switches for aliases
kitty + complete setup zsh | . /dev/stdin # Completion for kitty

# Prompt fanciness
autoload -Uz promptinit
setopt prompt_subst
RPROMPT='%F{red}'\$vcs_info_msg_0_'%f'
PROMPT='%F{blue}%~%f %F{blue}%#%f '

# Syntax highlighting!
. /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh

# Use emacs-like keybinds at the command line
bindkey -e

# FZF
export FZF_DEFAULT_OPTS="-m --preview 'bat --style=numbers --color=always {} 2>/dev/null'"
. ~/.config/fzf/fzf.zsh

# Keybinds
bindkey "^[[3~" delete-char     # Make 'delete' actually delete
bindkey \^U backward-kill-line  # CTRL-u works as in bash
bindkey "^[[1;5C" forward-word  # Ctrl-right moves right a word
bindkey "^[[1;5D" backward-word # Ctrl-left moves left a word

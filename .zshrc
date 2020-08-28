# If not running interactively, don't do anything
[[ $- != *i* ]] && return

export PRINTER=M70
export PATH=$PATH:/home/josh/.local/bin
export VISUAL=nvim
export EDITOR="$VISUAL"
export FCEDIT="$VISUAL"
# Python virtual environments
source /home/josh/.local/bin/virtualenvwrapper.sh

# Colorize man pages
export LESS_TERMCAP_mb=$'\e[1;32m'
export LESS_TERMCAP_md=$'\e[1;32m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[1;4;31m'

# Aliases
#alias ls='ls --color=auto --group-directories-first --sort=extension'
alias ls='exa --git --classify --group-directories-first --sort=extension --color-scale'
alias cat='bat'
alias pacman='sudo pacman'
alias aurupdate='trizen -Syu --aur --noconfirm'
alias pip-update='pip install --upgrade --user $(pip list --outdated --user --format=freeze | cut -f 1 -d =)'
alias rmorphan='pacman -Rns $(pacman -Qtdq)'
alias shred='shred --remove --zero --iterations=4' # Overwrites a file with zeros, then removes it
alias rm='rm -Iv'
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias wifi-menu='sudo wifi-menu -o' # Hide passwords with asterisks
alias wifi-off='sudo rfkill block all'
alias wifi-on='sudo rfkill unblock all'
alias info='info --vi'
# the following is from [this](https://stackoverflow.com/questions/2507766/merge-convert-multiple-pdf-files-into-one-pdf) Stack Overflow answer.
# add '-sOutputFile=output.pdf input1.pdf input2.pdf' to make it work.
alias mergepdf='gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/default -dNOPAUSE -dQUIET -dBATCH -dDetectDuplicateImages -dCompressFonts=true -r150'

####################
# zsh-only configs #
####################

# Autocompletion
zstyle :compinstall filename "$HOME/.zshrc"
autoload -Uz compinit && compinit
autoload edit-command-line # Prevent weird things from happening with entering text on the command line
zle -N edit-command-line 
setopt COMPLETE_ALIASES # autocompletion of command line switches for aliases
zstyle ':completion:*:*:*:default' menu yes select search yes # arrow-key driven interface

# fzf defaults
export FZF_DEFAULT_OPTS="-m --preview 'bat --style=numbers --color=always {} 2>/dev/null'"

# Prompt fanciness
autoload -Uz promptinit vcs_info && promptinit
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT='%F{red}'\$vcs_info_msg_0_'%f'
zstyle ':vcs_info:git:*' formats '%b' enable git
PROMPT='%F{yellow}%~%f %F{7}%#%f '

# Syntax highlighting!
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh

# fzf settings for zsh
[ -f ~/.config/fzf/fzf.zsh ] && source ~/.config/fzf/fzf.zsh

# Completion for kitty
kitty + complete setup zsh | source /dev/stdin
alias ssh='TERM=xterm-256color ssh' # So ssh works properly with kitty
bindkey -e

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

bindkey "^[[3~" delete-char     # Make 'delete' actually delete
bindkey \^U backward-kill-line  # CTRL-u works as in bash
bindkey "^[[1;5C" forward-word  # Ctrl-right moves right a word
bindkey "^[[1;5D" backward-word # Ctrl-left moves left a word

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/home/josh/code/google-cloud-sdk/path.zsh.inc' ]; then . '/home/josh/code/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/home/josh/code/google-cloud-sdk/completion.zsh.inc' ]; then . '/home/josh/code/google-cloud-sdk/completion.zsh.inc'; fi

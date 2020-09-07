#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# http://ezprompt.net/
PS1='[\u@\h \W]\$ '

export PRINTER=M70
export PATH=$PATH:/home/josh/.local/bin
export VISUAL=nvim
export EDITOR="$VISUAL"

# Aliases
alias ls='ls --color=auto --group-directories-first --sort=extension'
alias pacman='sudo pacman'
alias rmorphan='pacman -Rns $(pacman -Qtdq)'
alias shred='shred --remove --zero --iterations=4' # Overwrites a file with zeros, then removes it
alias rm='rm -Iv'
alias dotdrop='/usr/bin/dotdrop --cfg=~/dotdrop/config.yaml'
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias wifi-menu='sudo wifi-menu -o' # Hide passwords with asterisks
alias flameshot='flameshot && flameshot gui'
alias info='info --vi'
alias R='R --quiet'
# the following is from [this](https://stackoverflow.com/questions/2507766/merge-convert-multiple-pdf-files-into-one-pdf) Stack Overflow answer.
# add '-sOutputFile=output.pdf input1.pdf input2.pdf' to make it work.
alias mergepdf='gs -sDEVICE=pdfwrite -dCompatibilityLevel=1.4 -dPDFSETTINGS=/default -dNOPAUSE -dQUIET -dBATCH -dDetectDuplicateImages -dCompressFonts=true -r150'

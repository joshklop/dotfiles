# Preparationn
* Delete files, clean home directory, delete programs
* Export Bitwarden
  + Encrypt Bitwarden using GPG
* pacman -Syu
* reboot
* pacman -Qet > ~/pkglist.txt
* pip list > python_pkglist.txt

# tar
tar -czvpf {archive-name} {~josh} {/etc}

# dotdrop
## If updating dotfiles in ~/dotdrop/dotfiles directory
* Recommended: compare files to see what needs updated
  + dotdrop compare -p {profile}
* Update dotfiles in ~/dotdrop/dotfiles directory
  + dotdrop update -p {profile} [files; if none specified, all are updated]
* Add dotfiles to ~/dotdrop/dotfiles directory
  + dotdrop import -p {profile} {filepath}
* Remove dotfiles from ~/dotdrop/dotfiles
  + dotdrop remove -p {profile} {files}
## If installing dotfiles on new machine
* Make sure you already have dotdrop installed and the local git repo set up
* dotdrop install -p {profile}

# git
* Run inside of ~/dotdrop directory
  + diff, stage and commit changes
  + git push origin master

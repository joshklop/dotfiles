# Dotfiles

I manage my dotfiles with a bare git repository. 
Motivation came from [this Hacker News Post](https://news.ycombinator.com/item?id=11070797) and 
[this blog post](https://www.atlassian.com/git/tutorials/dotfiles).

Most of my configs come from [brokenbyte's dotfile repo](https://gitlab.com/brokenbyte/dotdrop). 
Definitely take a look!

## Manage

To manage my dotfiles, I usually follow something close to the steps outlined below:

* Clean home directory
* Delete unnecessary programs and Python packages
* Run the `$HOME/.local/bin/cleanup.sh` script to update packages.
  + Note that this is tailored to my directory structure. 
  You may want to change the script before using.
* Run the `$HOME/.local/bin/backup.sh` script to backup packages.
  + Note that this is tailored to my directory structure. 
  You may want to change the script before using.

## Install

Read [this tutorial](https://www.atlassian.com/git/tutorials/dotfiles).
Below is a summary. Nearly all of the steps are directly copied from the tutorial.

```bash
# Create a bare git repo to track our files
git init --bare $HOME/.dotfiles
# Create an alias to interact with the repo
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
# Set a flag to hid files we are not explicitly tracking yet
config config --local status.showUntrackedFiles no
# Add the alias definition to your .zshrc
echo "alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> $HOME/.zshrc
```
Now you can version the `$HOME` directory like any other repository, just replace `git` with the `config` alias.

## Import

```bash
# Add the alias definition to your .zshrc
echo "alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'" >> $HOME/.zshrc
# Apply the alias
source $HOME/.zshrc
# Ensure the source repository ignores the folder where you'll clone it to avoid recursion problems
echo ".dotfiles" >> .gitignore
# Clone the dotfiles into a bare repo
git clone --bare <git-repo-url> $HOME/.dotfiles
# Checkout the actual content from the bare repo to your $HOME
config checkout
# The above might fail because some existing files may have been overwritten by git.
# Solution: backup the files if you care about them, otherwise remove them.
# Set the flag showUntrackedFiles to no on this specific (local) repository
config config --local status.showUntrackedFiles no
```
Now you can version the `$HOME` directory like any other repository, just replace `git` with the `config` alias.

A few other things you need to do:

* Symlink root's `init.vim` to your `init.vim`.
* Change pacman's settings in `/etc` (I use Arch Linux)
* Symlink `$HOME/.local/share/applications/mimeapps.list` to `$HOME/.config/mimeapps.list`.

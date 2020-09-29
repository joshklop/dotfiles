# Dotfiles

I manage my dotfiles with a bare git repository. 
Motivation came from [this Hacker News Post](https://news.ycombinator.com/item?id=11070797) and 
[this blog post](https://www.atlassian.com/git/tutorials/dotfiles).
See the blog post above for a tutorial on how to set-up, manage, and import dotfiles using this workflow.

Most of my configs come from [brokenbyte's dotfile repo](https://gitlab.com/brokenbyte/dotdrop). 
Definitely take a look!

## Manage

To manage my dotfiles, I usually follow something close to the steps outlined below
(assume these scripts depend on my directory structure and that you will have to change things):

* Clean out any files I'm no longer using.
* Delete unnecessary programs and Python packages
* Run the `$HOME/.local/bin/git_unsaved_changes.sh` script to check for untracked,
  unadded, uncommited, and/or unpushed changes in git repos.
* Run the `$HOME/.local/bin/cleanup.sh` script to update packages.
* Run the `$HOME/.local/bin/backup.sh` script. It does what it says.

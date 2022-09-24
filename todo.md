# Notes

Fine-Grained Sandboxing with V8 Isolates - youtube infoq channel

# Todo

* [ ] Look into Tshaka's bat program and its compatibility with MSI
* [ ] automate nethermind invoice creation (use Notion and then export to PDF)
* [ ] set up [powertop](https://wiki.archlinux.org/title/Powertop)
* [ ] use systemd-timer so `batchecker.sh` will run after putting computer to sleep
* [ ] figure out dunst context menu
* [ ] Bluetooth on linux/windows
* [ ] Really understand how git works
* [ ] Really understand how nix works
* [ ] Really understand how ansible works
* [ ] Switch from i3 to xmonad (haskell all the things!)
* [ ] Rice zathura
* [ ] Rice rofi
* [ ] `Xresources`
* zinit
  + [ ] plugin to manage python virtualenvs
  + [ ] see brokenbyte's configs
  + [ ] prompt for git fanciness
  + [ ] completions, plus you want to use compinit in turbo mode (no `autoload -Uz compinit; compinit`)
* neovim
  + [ ] mason.nvim, etc. + formatters (clangformat, eslint, gofumpt, etc. with null_ls?! seems amazing)
  + [ ] project-specific configuration
  + [ ] get github permalink for line at current commit
  + [ ] gofumpt on command
  + [ ] toggle ltex
  + [ ] refresh sidebar (e.g. removing dap breakpoints doesn't collapse the sidebar)
  + [ ] prettier plugin or something. eslint?
  + [ ] use jdtls with package manager -- keep having to redownload snapshot
  + [ ] rename `setup_lsp` to `setup_lspconfig`
  + [ ] js/ts debugger
  + [ ] luasnips instead of vsnips
  + [ ] write ts parser and grammar for wat filetype
  + [ ] write ts parser and grammar for cairo filetype
  + [ ] better ui for nvim-dap
  + [ ] use buf-local settings (e.g. declutter your keymaps, declutter latex autocomplete)
  + [ ] use `ftplugin` directories, etc. instead of autocommands
  + [ ] Organize directories (i.e. use ftdetect, ftplugin, colors, etc.)
  + [ ] lualine
  + [ ] Look into using treesitter to do cool things with latex

# Done

* [X] json language server
* [X] Set up C and Java and bash and latex
* [X] Set up `nvim-jdtls`+`nvim-dap` for Java
* [X] `nvim-dap`: fix signs
* [X] `nvim-jdtls`: fix :JdtJshell command (didn't need fixing: it will only work in .java buffers)
* [X] Telescope.nvim: use fzf instead of native searching
* [X] Use light theme supported by treesitter (or make one)
* [X] Fix dunst CTRL-space keymaps
* [X] Install a compositor
* [X] Change zathura colorscheme to github
* [X] gitsigns
* [X] Transition to pacmanfile
* [X] plugin manager (`zinit`)
* [X] Get hls working
* [X] Nix setup: zsh-nix-shell, nix-zsh-completions
* [X] Use zoxide
* [X] `fzf` github colors
* [X] fix zoom and picom
* [X] Sync time b/t linux and windows (see arch wiki article)
* [X] Enable `awk_ls` once neovim 0.7 is released
* [X] migrate to new diagnostic api

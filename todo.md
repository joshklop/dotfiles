# Notes

Fine-Grained Sandboxing with V8 Isolates - youtube infoq channel

# Todo

- [ ] Look into Tshaka's bat program and its compatibility with MSI
- [ ] set up [powertop](https://wiki.archlinux.org/title/Powertop)
- [ ] use systemd-timer so `batchecker.sh` will run after putting computer to sleep
- [ ] figure out dunst context menu
- [ ] Bluetooth on linux/windows
- [ ] Really understand how git works
- [ ] Switch from i3 to xmonad (haskell all the things!)
- [ ] Rice zathura
- [ ] Rice rofi
- [ ] `Xresources`
- zinit
  - [ ] https://github.com/ianthehenry/sd
  - [ ] plugin to manage python virtualenvs
  - [ ] see brokenbyte's configs
  - [ ] prompt for git fanciness
  - [ ] completions, plus you want to use compinit in turbo mode (no `autoload -Uz compinit; compinit`)
- neovim
  - [ ] disable formatting for all lsp servers (we use null_ls anyway)
  - [ ] de-clutter keymaps
  - [ ] signature_help vs lspsignature plugin?
  - [ ] make an update function that contains lsp updates, packer updates, etc. so you can call from command line or from within neovim
  - [ ] better ui for nvim-dap
  - [ ] toggle ltex
  - [ ] luasnips
  - [ ] write ts parser and grammar for wat filetype
  - [ ] write ts parser and grammar for cairo filetype
  - [ ] use `ftplugin` directories, etc. instead of autocommands
  - [ ] Organize directories (i.e. use ftdetect, ftplugin, colors, etc.) - split plugin configs into different files
  - [ ] lualine
  - [ ] Look into using treesitter to do cool things with latex

# Done

- [x] json language server
- [x] Set up C and Java and bash and latex
- [x] Set up `nvim-jdtls`+`nvim-dap` for Java
- [x] `nvim-dap`: fix signs
- [x] `nvim-jdtls`: fix :JdtJshell command (didn't need fixing: it will only work in .java buffers)
- [x] Telescope.nvim: use fzf instead of native searching
- [x] Use light theme supported by treesitter (or make one)
- [x] Fix dunst CTRL-space keymaps
- [x] Install a compositor
- [x] Change zathura colorscheme to github
- [x] gitsigns
- [x] Transition to pacmanfile
- [x] plugin manager (`zinit`)
- [x] Get hls working
- [x] Nix setup: zsh-nix-shell, nix-zsh-completions
- [x] Use zoxide
- [x] `fzf` github colors
- [x] fix zoom and picom
- [x] Sync time b/t linux and windows (see arch wiki article)
- [x] Enable `awk_ls` once neovim 0.7 is released
- [x] migrate to new diagnostic api
- [x] formatters (clangformat, eslint, gofumpt, etc. with null_ls?! seems amazing--some lsps provide formatting also)

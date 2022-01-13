# System

* [ ] Use power toys for managing keybinds on windows instead of autohotkey
* [ ] Install source code pro with nerdfont installer, set as default in nvim-qt
* [ ] Win+enter to open neovim terminal
* [ ] Make cross-platform batchecker (haskell or go may be fun...? Should be able to easily generate `.exe`)
* [ ] Make backup/update script
* [ ] Learn cmake?

# Neovim

* [ ] Add solidity lsp
* [ ] Get C, java, and python debuggers working
* [ ] Improve lsp server loading, init, and install process
* [ ] Organize `get_capabilities`
* [ ] Remove deprecated keymaps `vim.lsp.diagnostic.goto_prev/next`
* [ ] Add clangd swithsourceheader keybind
* [ ] Look into improved `:cd` (telescope?)
* [ ] Use https://github.com/windwp/nvim-autopairs
* [ ] Use improved `nvim-dap` UI
* [ ] Is autocmd necessary for `nvim-jdtls`?
* [ ] Transition to 100% lua in `*.lua` if possible (autocmds, command, etc.)
* [ ] Organize keymaps (buf, global, etc.)
* [ ] Make configs as cross-platform as possible
  + i.e. abstract away `os.getenv` calls. 
  + get rid of as many `if vim.fn.has('win32')` calls as possible
* [ ] Add ftplugin/ftdetect, etc. (see other folks' configs for examples, read docs)
* [ ] Get rid of all TODOs and FIXMEs
* [ ] Add `stylua.toml`

# Done

* [X] Add scoop-installed programs to dotfiles
* [X] Make terminal github dark theme (remove borders?)
* [X] Swap escape and caps lock
* [X] Fix dotfile system
* [X] Get rid of gui tabline
* [X] Get lua, latex, c, python, go, haskell, powershell, java LSPs working

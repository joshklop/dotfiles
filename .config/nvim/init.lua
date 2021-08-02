vim.g.python3_host_prog = '/bin/python3'
vim.g.loaded_python_provider = 0


vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.autoindent = true
vim.opt.smarttab = true
vim.opt.wildmenu = true
vim.opt.showmode = false
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.completeopt = {'menuone', 'noinsert', 'noselect'}
vim.opt.hidden = true
vim.opt.termguicolors = true
vim.opt.wrap = false
vim.opt.relativenumber = true
vim.opt.number = true
vim.opt.swapfile = false
vim.opt.mouse = ''
vim.opt.inccommand = 'nosplit'
vim.opt.scrolloff = 3
vim.opt.sidescrolloff = 8


-- Keymaps
local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end
-- Remap leader keys
map('n', '<SPACE>', '<NOP>')
vim.g.mapleader = ' '
vim.g.maplocalleader = ','
-- Transpose lines and characters
map('n', '<Up>', 'ddkP')
map('n', '<Down>', 'ddp')
map('n', '<Left>', 'xhP')
map('n', '<Right>', 'xp')
-- Allow easier navigation on broken lines
map('n', 'j', 'gj')
map('n', 'k', 'gk')
-- Redraw screen
map('n', '<ESC>', '<CMD>nohlsearch<CR>')
-- Easier Window Navigation
map('', '<C-h>', '<C-w>h')
map('', '<C-j>', '<C-w>j')
map('', '<C-k>', '<C-w>k')
map('', '<C-l>', '<C-w>l')
map('', '<C-w>t', '<CMD>tabnew<CR>')
-- Delete buffer without deleting window
map('n', '<Leader>d', [[<CMD>bp\|bd]])


-- Filetype-specific settings
vim.cmd [[
augroup omnifuncs
au BufNew,BufNewFile,BufRead,BufEnter *.snippets :setfiletype snippets
au BufNew,BufNewFile,BufRead,BufEnter *.js :setfiletype javascript
au BufNew,BufNewFile,BufRead,BufEnter *.ts :setfiletype typescript
au FileType python,c,cpp,lua setlocal colorcolumn=79
au FileType magit setlocal nowrap
au FileType java setlocal colorcolumn=99
augroup end
]]


-- Plugins
require('me.plugins')


-- LSP
require('me.setup_lsp').setup_lua()
vim.cmd [[
augroup lsp
"au FileType python lua reuqire('setup_lsp').setup_python()
"au FileType c,cpp lua require('lspconfig').clangd.setup({on_attach = on_attach})
au FileType java lua require('setup_lsp').setup_jdtls()
augroup end
]]

-- TODO
-- telescope + lsp commands
-- jdtls, nvim-dap
-- pyright
-- clangd
-- wildmenu.nvim
-- set up other plugins with previous configuration (eg. vimtex)
-- search dotfiles with telescope
-- why do i need to do autocommand with jdtls? is there a better way? ftplugin?

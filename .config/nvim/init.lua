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

local map = require('me.utils').map

-- Keymaps
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
vim.api.nvim_set_keymap('n', '<C-j>', '<C-w>j', {})
map('', '<C-k>', '<C-w>k')
map('', '<C-l>', '<C-w>l')
map('', '<C-w>t', '<CMD>tabnew<CR>')
-- Delete buffer without deleting window
-- TODO make this the default for `:bd`
map('n', '<Leader>bd', [[<CMD>bp\|bd<CR>]])


-- Filetype-specific settings
vim.cmd [[
augroup omnifuncs
au BufNew,BufNewFile,BufRead,BufEnter *.snippets :setfiletype snippets
au FileType python,lua setlocal colorcolumn=79
au FileType c,cpp setlocal colorcolumn=89
au FileType magit setlocal nowrap
au FileType javascript setlocal shiftwidth=2
au FileType typescript setlocal shiftwidth=2
au FileType javascript setlocal softtabstop=2
au FileType typescript setlocal softtabstop=2
au FileType java setlocal colorcolumn=99
au BufNew,BufNewFile,BufRead,BufEnter *.tex :setfiletype tex
augroup end
]]


-- Plugins
require('me.plugins')


-- LSP
local lsp = require('me.setup_lsp')
lsp.setup_lua()
lsp.setup_latex()
lsp.setup_c()
lsp.setup_python()
lsp.setup_css()
lsp.setup_typescript()
lsp.setup_haskell()
vim.cmd [[
augroup lsp
au FileType java lua require('me.setup_lsp').setup_java()
augroup end
]]
-- Set up logging (useful for troubleshooting frequent LSP mishaps)
vim.lsp.set_log_level("debug")
vim.cmd [[
command LspLog lua vim.cmd('e'..vim.lsp.get_log_path())
]]

-- Debugging
local dap_install = require("dap-install")
local dbg_list = require("dap-install.api.debuggers").get_installed_debuggers()
for _, debugger in ipairs(dbg_list) do
    dap_install.config(debugger)
end

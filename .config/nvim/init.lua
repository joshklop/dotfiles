local utils = require('me.utils')
local map = utils.map
local home = utils.home

if vim.fn.has('win32') ~= 0 then
    vim.g.python3_host_prog = home .. '/scoop/apps/python/current/python.exe'
else
    vim.g.python3_host_prog = '/usr/bin/python'
end

vim.opt.expandtab = true
vim.opt.softtabstop = 4
vim.opt.shiftwidth = 4
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.showmode = false
vim.opt.shiftround = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
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
vim.opt.guifont = 'SauceCodePro NF:h12'

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
-- Easier navigation on broken lines
map('n', 'j', 'gj')
map('n', 'k', 'gk')
-- Redraw screen
map('n', '<ESC>', '<CMD>nohlsearch<CR>')
-- Easier Window Navigation
map('', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j', {})
map('', '<C-k>', '<C-w>k')
map('', '<C-l>', '<C-w>l')
map('', '<C-w>t', '<CMD>tabnew<CR>')

-- TODO move to ftdetect
vim.cmd [[
augroup omnifuncs
au BufNew,BufNewFile,BufRead,BufEnter *.snippets setfiletype snippets
au BufNew,BufNewFile,BufRead,BufEnter *.sol setfiletype solidity
au BufNewFile,BufRead *.rasi setfiletype css
au BufNew,BufNewFile,BufRead,BufEnter *.tex :setfiletype tex
au BufNew,BufNewFile,BufRead,BufEnter *.mdx :setfiletype markdown
augroup end
]]

-- Plugins
require('me.plugins')

-- LSP
vim.diagnostic.config({
    signs = {
        severity = {
            min=vim.diagnostic.severity.WARN,
        },
    },
})
require('me.lsp').setup()

-- Make Powershell the default shell on Windows
if vim.fn.has('win32') ~= 0 then
    vim.opt.shell = 'pwsh' -- Assume we have Powershell Core
    vim.opt.shellcmdflag = '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
    vim.opt.shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
    vim.opt.shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
    vim.opt.shellquote = ""
    vim.opt.shellxquote = '"'
end

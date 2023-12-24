local utils = require('me.utils')

if vim.fn.has('win32') ~= 0 then
    vim.g.python3_host_prog = utils.home .. '/scoop/apps/python/current/python.exe'
else
    vim.g.python3_host_prog = '/usr/bin/python'
end

vim.opt.cmdheight = 0
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
utils.map('n', '<SPACE>', '<NOP>')
vim.g.mapleader = ' '
vim.g.maplocalleader = ','
-- Transpose lines and characters
utils.map('n', '<Up>', 'ddkP')
utils.map('n', '<Down>', 'ddp')
utils.map('n', '<Left>', 'xhP')
utils.map('n', '<Right>', 'xp')
-- Easier navigation on broken lines
utils.map('n', 'j', 'gj')
utils.map('n', 'k', 'gk')
-- Redraw screen
utils.map('n', '<ESC>', '<CMD>nohlsearch<CR>')
-- Easier Window Navigation
utils.map('', '<C-h>', '<C-w>h')
utils.map('n', '<C-j>', '<C-w>j', {})
utils.map('', '<C-k>', '<C-w>k')
utils.map('', '<C-l>', '<C-w>l')
utils.map('', '<C-w>t', '<CMD>tabnew<CR>')

vim.cmd([[
augroup omnifuncs
au BufNew,BufNewFile,BufRead,BufEnter *.snippets setfiletype snippets
au BufNew,BufNewFile,BufRead,BufEnter *.sol setfiletype solidity
au BufNew,BufNewFile,BufRead,BufEnter *.sls setfiletype scheme
au BufNewFile,BufRead *.rasi setfiletype css
au BufNew,BufNewFile,BufRead,BufEnter *.tex :setfiletype tex
au BufNew,BufNewFile,BufRead,BufEnter *.mdx :setfiletype markdown
augroup end
]])

vim.api.nvim_create_autocmd({ 'BufNew', 'BufNewFile', 'BufRead', 'BufEnter' }, {
    pattern = { utils.home .. '/repos/joshklop.github.io/*.md' },
    callback = function()
        vim.opt_local.textwidth = 80
        vim.opt_local.linebreak = true
        vim.opt_local.colorcolumn = '80'
    end,
})

-- Plugins
require('me.plugins')

vim.diagnostic.config({
    signs = {
        severity = {
            min = vim.diagnostic.severity.WARN,
        },
    },
})
vim.keymap.set('n', '<Leader>e', function()
    vim.diagnostic.open_float(nil, { scope = 'line' })
end)
vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)

-- Make Powershell the default shell on Windows
if vim.fn.has('win32') ~= 0 then
    vim.opt.shell = 'pwsh' -- Assume we have Powershell Core
    vim.opt.shellcmdflag =
        '-NoLogo -NoProfile -ExecutionPolicy RemoteSigned -Command [Console]::InputEncoding=[Console]::OutputEncoding=[System.Text.Encoding]::UTF8;'
    vim.opt.shellredir = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
    vim.opt.shellpipe = '2>&1 | Out-File -Encoding UTF8 %s; exit $LastExitCode'
    vim.opt.shellquote = ''
    vim.opt.shellxquote = '"'
end

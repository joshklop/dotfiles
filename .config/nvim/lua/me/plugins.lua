-- Bootstrap packer
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

require('packer').startup(function(use)
    use {'wbthomason/packer.nvim'}
    use {'windwp/nvim-ts-autotag'}
    use {'hrsh7th/vim-vsnip'}
    use {'hrsh7th/vim-vsnip-integ'}
    use {'projekt0n/github-nvim-theme'}
    use {
        'nvim-telescope/telescope.nvim',
        requires = {'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim'}
    }
    use {'nvim-telescope/telescope-ui-select.nvim'}
    use {'jvgrootveld/telescope-zoxide'}
    use {'lewis6991/gitsigns.nvim'}
    use {'psliwka/vim-smoothie'}
    use {'neovim/nvim-lspconfig'}
    use {'tpope/vim-repeat'}
    use {'tpope/vim-surround'}
    use {'chaoren/vim-wordmotion'}
    use {'windwp/nvim-autopairs'}
    use {'hrsh7th/nvim-cmp'}
    use {'hrsh7th/cmp-calc'}
    use {'hrsh7th/cmp-omni'}
    use {'hrsh7th/cmp-vsnip'}
    use {'kdheepak/cmp-latex-symbols'}
    use {'hrsh7th/cmp-buffer'}
    use {'hrsh7th/cmp-path'}
    use {'hrsh7th/cmp-nvim-lsp'}
    use {'hrsh7th/cmp-nvim-lua'}
    use {'mfussenegger/nvim-jdtls'} -- Do not set to only run on ft = java
    use {'mfussenegger/nvim-dap'}
    use {'nvim-telescope/telescope-dap.nvim'}
    use {'theHamsta/nvim-dap-virtual-text'}
    use {'mfussenegger/nvim-dap-python'}
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
    use {'williamboman/nvim-lsp-installer'}
    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}
    use {'chrisbra/csv.vim', ft = {'csv'}}
    use {'thesis/vim-solidity'} -- TODO replace with tree-sitter when available
    use {'jalvesaq/nvim-r', ft = {'r', 'Rmd'}}
    use {'ray-x/lsp_signature.nvim'}
    use {'ten3roberts/qf.nvim'}
    use {'winston0410/commented.nvim'}
    if PACKER_BOOTSTRAP then
        require('packer').sync()
    end
end)

local utils = require('me.utils')
local map = utils.map
local home = utils.home
local sanitize_binary = utils.sanitize_binary

-- projekt0n/github-nvim-theme
vim.opt.background = 'light'
require('github-theme').setup({
    theme_style = 'light',
    comment_style = 'NONE',
    keyword_style = 'NONE',
    dark_float = true,
})

-- winston0410/commented.nvim
require('commented').setup({
    keybindings = {
        n = '<Leader>oo',
        v = '<Leader>oo',
        nl = '<Leader>od'
    }
})

-- ten3roberts/qf.nvim
require('qf').setup({})
map('n', '<Leader>lt', '<CMD>lua require("qf").toggle("l", true)<CR>')
map('n', '<Leader>lj', '<CMD>lua require("qf").below("visible")<CR>')
map('n', '<Leader>lk', '<CMD>lua require("qf").above("visible")<CR>')
map('n', '<Leader>ct', '<CMD>lua require("qf").toggle("c", true)<CR>')
map('n', '<Leader>cj', '<CMD>lua require("qf").below("visible")<CR>')
map('n', '<Leader>ck', '<CMD>lua require("qf").above("visible")<CR>')

-- windwp/nvim-autopairs
require('nvim-autopairs').setup({
    fast_wrap = {},
})

-- windwp/nvim-ts-autotag
require('nvim-ts-autotag').setup()

-- hrsh7th/nvim-cmp
local cmp = require('cmp')
cmp.setup({
  completion = {
    completeopt = 'menu,menuone,preview,noselect',
  },
  snippet = {
      expand = function(args)
          vim.fn["vsnip#anonymous"](args.body)
      end
  },
  sources = {
    {name = 'buffer'}, -- hrsh7th/cmp-buffer
    {name = 'path'}, -- hrsh7th/cmp-path
    {name = 'nvim_lua'}, -- hrsh7th/cmp-nvim-lua
    {name = 'omni'}, -- hrsh7th/cmp-omni
    {name = 'calc'}, -- hrsh7th/cmp-calc
    {name = 'nvim_lsp'}, -- hrsh7th/cmp-nvim-lsp
    {name = 'vsnip'}, -- hrsh7th/cmp-vnsip
    {name = 'latex_symbols'}, -- hrsh7th/cmp-latex-symbols
  },
  mapping = cmp.mapping.preset.insert({
     ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item({ behavior = require('cmp.types').cmp.SelectBehavior.Insert }), { 'i', 'c' }),
  }),
})
-- Integrate with windwp/nvim-autopairs
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on(
    'confirm_done',
    cmp_autopairs.on_confirm_done({map_char = { tex = '' }})
)

-- nvim-treesitter/nvim-treesitter
require('nvim-treesitter.configs').setup({
    highlight = {
        enable = true,
        disable = {'latex'},
    },
    incremental_selection = {
	enable = true
    },
    textobjects = {enable = true}
})

-- nvim/nvim-lspconfig
vim.lsp.set_log_level('ERROR')
vim.cmd [[
command! LspLog lua vim.cmd('e '.. vim.lsp.get_log_path())
]]

-- hrsh7th/vim-vnsip and hrsh7th/vim-vsnip-integ
vim.g.vsnip_snippet_dir = vim.fn.stdpath('config') .. '/snippets'
-- Expand
vim.cmd [[
imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
]]
-- Expand or jump
vim.cmd [[
imap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
smap <expr> <C-l>   vsnip#available(1)  ? '<Plug>(vsnip-expand-or-jump)' : '<C-l>'
]]
-- Jump forward or backward
vim.cmd [[
imap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
smap <expr> <Tab>   vsnip#jumpable(1)   ? '<Plug>(vsnip-jump-next)'      : '<Tab>'
imap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
smap <expr> <S-Tab> vsnip#jumpable(-1)  ? '<Plug>(vsnip-jump-prev)'      : '<S-Tab>'
]]

-- nvim-telescope/telescope.nvim
local telescope = require('telescope')
telescope.setup()
map('n', '<Leader>ff', '<CMD>Telescope find_files<CR>')
map('n', '<Leader>fk', '<CMD>Telescope keymaps<CR>')
map('n', '<Leader>fg', '<CMD>Telescope live_grep<CR>')
map('n', '<Leader>fb', '<CMD>Telescope buffers<CR>')
map('n', '<Leader>fh', '<CMD>Telescope help_tags<CR>')
map('n', '<Leader>fm', '<CMD>lua require("telescope.builtin").man_pages({sections = {"ALL"}})<CR>')
map('n', '<Leader>fl', '<CMD>lua vim.lsp.buf.code_action()<CR>')
map('n', '<Leader>fd', '<CMD>lua require("me.utils").find_dotfiles()<CR>')
-- nvim-telescope/telescope-fzf-native
telescope.load_extension('fzf')
-- nvim-telescope/telescope-zoxide
telescope.load_extension('zoxide')
map('n', '<Leader>fj', '<CMD>Telescope zoxide list<CR>')
-- nvim-telescope/telescope-dap.nvim
telescope.load_extension('dap')
map('n', '<leader>df', '<CMD>Telescope dap frames<CR>')
map('n', '<leader>dl', '<CMD>Telescope dap list_breakpoints<CR>')
-- nvim-telescope/telescope-ui-select.nvim
telescope.load_extension('ui-select')
-- mfussenegger/nvim-dap-python
require('dap-python').setup(os.getenv('HOME') .. '.venv/debugpy/bin/python')
require('dap-python').test_runner = 'pytest'

-- lewis6991/gitsigns.nvim
require('gitsigns').setup({
    signcolumn = false,
    numhl = true,
})

-- mfussenegger/nvim-dap
local dap = require('dap') -- Need to load the plugin in order for signs to work
vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointRejected', {text='🟦', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='⭐️', texthl='', linehl='', numhl=''})
map('n', '<Leader>dh', '<CMD>lua require("dap").toggle_breakpoint()<CR>')
map('n', '<Leader>do', '<CMD>lua require("dap").step_out()<CR>')
map('n', '<Leader>di', '<CMD>lua require("dap").step_into()<CR>')
map('n', '<Leader>ds', '<CMD>lua require("dap").step_over()<CR>')
map('n', '<Leader>db', '<CMD>lua require("dap").step_back()<CR>')
map('n', '<Leader>dc', '<CMD>lua require("dap").continue()<CR>')
map('n', '<Leader>dq', '<CMD>lua require("dap").disconnect({ terminateDebuggee = true });require("dap").close()<CR>')
map('n', '<Leader>dr', '<CMD>lua require("dap").repl.toggle({}, "vsplit")<CR><C-w>l')
map('n', '<Leader>d?', '<CMD>lua local widgets=require"dap.ui.widgets";widgets.centered_float(widgets.scopes)<CR>')
dap.set_log_level('ERROR')
vim.cmd [[
command! DAPLog lua vim.cmd('e '.. vim.fn.stdpath('cache') .. '/dap.log')
]]

-- Debuggers
local dbg_path = vim.fn.stdpath('data') .. '/dapinstall'
dap.adapters.cpptools = {
    type = 'executable',
    command = sanitize_binary(dbg_path .. '/ccppr_vsc/extension/debugAdapters/bin/OpenDebugAD7'),
}
local mi_debugger_path = '/usr/bin/gdb'
if vim.fn.has('win32') ~= 0 then
    mi_debugger_path = home .. '/scoop/apps/mingw-winlibs/current/bin/gdb.exe'
end

dap.configurations.c = {
    {
        name = 'Launch file',
        type = 'cpptools',
        request = 'launch',
        miMode = 'gdb',
        miDebuggerPath = mi_debugger_path,
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = true,
    }
}
dap.configurations.cpp = dap.configurations.c

-- theHamsta/nvim-dap-virtual-text
require('nvim-dap-virtual-text').setup()

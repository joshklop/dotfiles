-- Bootstrap packer
local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = vim.fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
end

-- Plugins
require('packer').startup(function(use)
    use {'wbthomason/packer.nvim'}
    use {'hrsh7th/vim-vsnip'}
    use {'hrsh7th/vim-vsnip-integ'}
    use {'projekt0n/github-nvim-theme'}

    use {
        'nvim-telescope/telescope.nvim',
        requires = {'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim'}
    }

    use {'lewis6991/gitsigns.nvim'}

    use {'psliwka/vim-smoothie'}
    use {'neovim/nvim-lspconfig'}
    use {'tpope/vim-repeat'}
    use {'tpope/vim-surround'}
    use {'chaoren/vim-wordmotion'}
    use {'jiangmiao/auto-pairs'}
    use {'jreybert/vimagit'}

    use {'hrsh7th/nvim-cmp'}
    use {'hrsh7th/cmp-calc'}
    use {'hrsh7th/cmp-omni'}
    use {'hrsh7th/cmp-vsnip'}
    use {'kdheepak/cmp-latex-symbols'}
    use {'hrsh7th/cmp-buffer'}
    use {'hrsh7th/cmp-path'}
    use {'hrsh7th/cmp-nvim-lsp'}
    use {'hrsh7th/cmp-nvim-lua'}

    use {'ap/vim-css-color'}
    use {'Vimjas/vim-python-pep8-indent', ft = {'python'}}
    use {
        'prettier/vim-prettier',
        ft = {'javascript', 'typescript', 'json', 'css'}
    }
    use {'MaxMEllon/vim-jsx-pretty'}
    use {'pangloss/vim-javascript'}
    use {'mfussenegger/nvim-jdtls'} -- Do not set to only run on ft = java
    use {'mfussenegger/nvim-dap'}
    use {'Pocco81/DAPInstall.nvim'}
    use {'nvim-telescope/telescope-dap.nvim'}
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
    use {'theHamsta/nvim-dap-virtual-text'}

    use {'williamboman/nvim-lsp-installer'}

    use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}

    use {'chrisbra/csv.vim', ft = {'csv'}}
    use { 'thesis/vim-solidity' }
    use {'jalvesaq/nvim-r', ft = {'r', 'Rmd'}}
    use {'neovimhaskell/haskell-vim'}
    use {'ray-x/lsp_signature.nvim'}
    if PACKER_BOOTSTRAP then
        require('packer').sync()
    end
end)

local utils = require('me.utils')
local map = utils.map

-- colorscheme
vim.opt.background = 'light'
require('github-theme').setup({
    theme_style = 'light',
    comment_style = 'NONE',
    keyword_style = 'NONE',
    dark_float = true,
})

-- completion
require('cmp').setup({
  completion = {
    completeopt = 'menu,menuone,noselect',
  },
  snippet = {
      expand = function(args)
          vim.fn["vsnip#anonymous"](args.body)
      end
  },
  sources = {
    {name = 'buffer'},
    {name = 'path'},
    {name = 'nvim_lua'},
    {name = 'omni'},
    {name = 'calc'},
    {name = 'nvim_lsp'},
    {name = 'vsnip'},
    {name = 'latex_symbols'}
  }
})

-- treesitter
require('nvim-treesitter.configs').setup({
    highlight = {
        enable = true,
        disable = {'latex'}
    },
    incremental_selection = {enable = true},
})

-- snippets
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

-- nvim-dap
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
-- nvim-dap-virtual-text
require('nvim-dap-virtual-text').setup()

-- nvim-telescope/telescope.nvim
local telescope = require('telescope')
telescope.setup()
map('n', '<Leader>ff', '<CMD>Telescope find_files<CR>')
map('n', '<Leader>fk', '<CMD>Telescope keymaps<CR>')
map('n', '<Leader>fg', '<CMD>Telescope live_grep<CR>')
map('n', '<Leader>fb', '<CMD>Telescope buffers<CR>')
map('n', '<Leader>fh', '<CMD>Telescope help_tags<CR>')
map('n', '<Leader>fm', '<CMD>Telescope man_pages<CR>')
map('n', '<Leader>fd', '<CMD>lua require("me.utils").find_dotfiles()<CR>')
telescope.load_extension('fzf')
-- nvim-telescope/telescope-dap.nvim
telescope.load_extension('dap')
map('n', '<leader>df', '<CMD>Telescope dap frames<CR>')
map('n', '<leader>dl', '<CMD>Telescope dap list_breakpoints<CR>')

-- haskell-vim
vim.g.haskell_enable_quantification = 1   -- `forall`
vim.g.haskell_enable_recursivedo = 1      -- `mdo` and `rec`
vim.g.haskell_enable_arrowsyntax = 1      -- `proc`
vim.g.haskell_enable_pattern_synonyms = 1 -- `pattern`
vim.g.haskell_enable_typeroles = 1        -- type roles
vim.g.haskell_enable_static_pointers = 1  -- `static`
vim.g.haskell_backpack = 1                -- backpack keywords

-- gitsigns
require('gitsigns').setup({
    signcolumn = false,
    numhl = true
})

-- dap-install
if vim.fn.has('win32') then -- dap-install does not support windows yet
    local dbg_path = vim.fn.stdpath('data') .. '/dapinstall'

    -- Modified from https://github.com/Pocco81/DAPInstall.nvim/blob/main/lua/dap-install/core/debuggers/ccppr_vsc.lua
    -- FIXME Not working
    dap.adapters.cpptools = {
        type = 'executable',
        command = dbg_path .. '/ccppr_vsc/extension/debugAdapters/bin/OpenDebugAD7.exe',
    }
    dap.configurations.c = {{
        name = 'Launch file',
        type = 'cpptools',
        request = 'launch',
        miDebuggerPath = 'gdb', -- Tried path here, didn't work
        program = function()
            return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
        end,
        cwd = "${workspaceFolder}",
        stopOnEntry = true,
    }}
    dap.configurations.cpp = dap.configurations.c
else
    M = {}
    function M.refresh_debuggers()
        local dap_install = require("dap-install")
        local dbg_list = require("dap-install.api.debuggers").get_installed_debuggers()
        for _, debugger in ipairs(dbg_list) do
            dap_install.config(debugger)
        end
    end
    M.refresh_debuggers()
    vim.cmd([[command! DIRefresh lua M.refresh_debuggers()]])
end

return M

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
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
    }
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
    use {'HerringtonDarkholme/yats.vim'}
    use {'turbio/bracey.vim', run = 'npm install --prefix server'}
    use {'MaxMEllon/vim-jsx-pretty'}
    use {'pangloss/vim-javascript'}
    use {'mfussenegger/nvim-jdtls'} -- Do not set to only run on ft = java
    use {'mfussenegger/nvim-dap'}
    use {'Pocco81/DAPInstall.nvim'}
    use {'nvim-telescope/telescope-dap.nvim'}
    use {'nvim-telescope/telescope-fzf-native.nvim', run = 'make'}
    use {'theHamsta/nvim-dap-virtual-text'}

    use {'williamboman/nvim-lsp-installer'}

    use {
        'nvim-treesitter/nvim-treesitter',
        branch = '0.5-compat',
        run = ':TSUpdate'
    }
    use {'chrisbra/csv.vim', ft = {'csv'}}
    use {'jalvesaq/nvim-r', ft = {'r', 'Rmd'}}
    use {'neovimhaskell/haskell-vim'}
    use {'ray-x/lsp_signature.nvim'}
    if PACKER_BOOTSTRAP then
        require('packer').sync()
    end
end)

local map = require('me.utils').map

-- colorscheme
vim.opt.background = 'light'
require('github-theme').setup({
    theme_style = 'light',
    comment_style = 'NONE',
    keyword_style = 'NONE',
    dark_float = true,
})

local cmp = require('cmp');
cmp.setup({
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

require('nvim-treesitter.configs').setup({
    highlight = {
        enable = true,
        disable = {'json', 'latex'}
    },
    incremental_selection = {enable = true},
})

vim.g.bracey_server_port = 3000

-- vsnip
-- Expand
vim.g.vsnip_snippet_dir = os.getenv('HOME') .. '/.config' .. '/nvim' .. '/snippets'
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

-- Telescope
local telescope = require('telescope')
telescope.setup()
telescope.load_extension('fzf')
map('n', '<Leader>ff', '<CMD>Telescope find_files<CR>')
map('n', '<Leader>fk', '<CMD>Telescope keymaps<CR>')
map('n', '<Leader>fg', '<CMD>Telescope live_grep<CR>')
map('n', '<Leader>fb', '<CMD>Telescope buffers<CR>')
map('n', '<Leader>fh', '<CMD>Telescope help_tags<CR>')
map('n', '<Leader>fm', '<CMD>Telescope man_pages<CR>')
map('n', '<Leader>fd', '<CMD>lua require("me.utils").find_dotfiles()<CR>')

-- nvim-dap
require('dap') -- Need to load the plugin in order for signs to work
vim.fn.sign_define('DapBreakpoint', {text='🛑', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapBreakpointRejected', {text='🟦', texthl='', linehl='', numhl=''})
vim.fn.sign_define('DapStopped', {text='⭐️', texthl='', linehl='', numhl=''})
map('n', '<Leader>dh', '<CMD>lua require("dap").toggle_breakpoint()<CR>')
map('n', '<Leader>do', '<CMD>lua require("dap").step_out()<CR>')
map('n', '<Leader>di', '<CMD>lua require("dap").step_into()<CR>')
map('n', '<Leader>ds', '<CMD>lua require("dap").step_over()<CR>')
map('n', '<Leader>db', '<CMD>lua require("dap").step_back()<CR>')
map('n', '<Leader>dc', '<CMD>lua require("dap").continue()<CR>')
map('n', '<Leader>dq', '<CMD>lua require("dap").disconnect({ terminateDebuggee = true });require"dap".close()<CR>')
map('n', '<Leader>dr', '<CMD>lua require("dap").repl.toggle({}, "vsplit")<CR><C-w>l')
map('n', '<Leader>d?', '<CMD>lua local widgets=require"dap.ui.widgets";widgets.centered_float(widgets.scopes)<CR>')
-- nvim-dap-virtual-text
require('nvim-dap-virtual-text').setup()
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

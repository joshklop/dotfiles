-- Plugins
require('packer').startup(function(use)
    use {'wbthomason/packer.nvim'}
    use {'hrsh7th/vim-vsnip'}
    use {'hrsh7th/vim-vsnip-integ'}
    use {'cormacrelf/vim-colors-github'}
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

    use {'Vimjas/vim-python-pep8-indent', ft = {'python'}}
    use {
        'prettier/vim-prettier',
        ft = {'javascript', 'typescript', 'json', 'css'}
    }
    use {'mfussenegger/nvim-jdtls'} -- Do not set to only run on ft = java
    use {'mfussenegger/nvim-dap'}
    use {'kabouzeid/nvim-lspinstall'}
    use {
        'nvim-treesitter/nvim-treesitter',
        branch = '0.5-compat',
        run = ':TSUpdate'
    }
    use {'chrisbra/csv.vim', ft = {'csv'}}
    use {'jalvesaq/nvim-r', ft = {'r', 'Rmd'}}
    use {'ray-x/lsp_signature.nvim'}
end)


-- colorscheme
vim.opt.background = 'light'
vim.g.github_colors_soft = 1
vim.cmd 'colorscheme github'

local cmp = require('cmp');
cmp.setup {
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
}

require('nvim-treesitter.configs').setup {
    highlight = {enable = true, disable = {'lua', 'json', 'latex'}},
    incremental_selection = {enable = true},
}

-- TODO make this a global or something, you're using it everywhere
local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

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
map('n', '<Leader>ff', '<CMD>Telescope find_files<CR>')
map('n', '<Leader>fg', '<CMD>Telescope live_grep<CR>')
map('n', '<Leader>fb', '<CMD>Telescope buffers<CR>')
map('n', '<Leader>fh', '<CMD>Telescope help_tags<CR>')
-- map('n', '<Leader>fd', "<CMD>lua require('custom').find_dotfiles()<CR>") FIXME

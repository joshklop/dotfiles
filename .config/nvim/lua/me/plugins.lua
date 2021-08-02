-- Plugins
require('packer').startup(function(use)
    use {'wbthomason/packer.nvim'}
    use {'cormacrelf/vim-colors-github'}
    use {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}}
    }
    use {'KeitaNakamura/tex-conceal.vim', ft = {'tex'}}
    use {'psliwka/vim-smoothie'}
    use {'neovim/nvim-lspconfig'}
    use {'tpope/vim-repeat'}
    use {'tpope/vim-surround'}
    use {'chaoren/vim-wordmotion'}
    use {'jiangmiao/auto-pairs'}
    use {'sirver/UltiSnips', ft = {'tex', 'python', 'java'}}
    use {'jreybert/vimagit'}
    use {'lervag/vimtex', ft = {'tex'}}
    use {'hrsh7th/nvim-compe'}
    use {'Vimjas/vim-python-pep8-indent', ft = {'python'}}
    use {
        'prettier/vim-prettier',
        ft = {'javascript', 'typescript', 'json', 'css'}
    }
    use {'mfussenegger/nvim-jdtls'} -- Do not set to only run on ft = java
    use {
        'glacambre/firenvim',
        run = function() vim.fn['firenvim#install'](0) end
    }
    use {'kabouzeid/nvim-lspinstall'}
    use {
        'nvim-treesitter/nvim-treesitter',
        branch = '0.5-compat',
        run = ':TSUpdate'
    }
    use {'chrisbra/csv.vim', ft = {'csv'}}
    use {'jalvesaq/nvim-r', ft = {'r', 'Rmd'}}
end)


-- colorscheme
vim.opt.background = 'light'
vim.g.github_colors_soft = 1
vim.cmd 'colorscheme github'

require('compe').setup {
    enabled = true;
    autocomplete = true;
    debug = false;
    min_length = 1;
    throttle_time = 80;
    source_timeout = 200;
    incomplete_delay = 400;
    max_abbr_width = 100;
    max_kind_width = 100;
    max_menu_width = 100;
    documentation = true;
    source = {
        omni = {
            filetypes = {'tex', 'java', 'python', 'c'},
        },
        path = true;
        buffer = true;
        calc = true;
        nvim_lsp = true;
        nvim_lua = true;
        ultisnips = true;
        treesitter = true;
        emoji = false;
        vim_dadbod_completion = true;
    };
}

require('nvim-treesitter.configs').setup {
    highlight = {enable = true, disable = {'lua'}},
    incremental_selection = {enable = true},
}


local M = {}

-- Telescope
-- TODO make this a global or something, you're using it everywhere
local function map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end
map('n', '<Leader>ff', '<CMD>Telescope find_files<CR>')
map('n', '<Leader>fg', '<CMD>Telescope live_grep<CR>')
map('n', '<Leader>fb', '<CMD>Telescope buffers<CR>')
map('n', '<Leader>fh', '<CMD>Telescope help_tags<CR>')
map('n', '<Leader>fd', "<CMD>lua require('custom').find_dotfiles()<CR>")

return M

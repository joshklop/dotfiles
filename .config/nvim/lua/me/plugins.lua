local utils = require('me.utils')
local buf_map = utils.buf_map
local map = utils.map

-- Bootstrap lazy
local lazypath = vim.fn.stdpath('data') .. '/lazy/lazy.nvim'
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        'git',
        'clone',
        '--filter=blob:none',
        'https://github.com/folke/lazy.nvim.git',
        '--branch=stable',
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

require('lazy').setup({
    {
        'nvim-lualine/lualine.nvim',
        config = function()
            require('lualine').setup({
                options = {
                    theme = 'auto',
                    icons_enabled = false,
                    component_separators = { left = '', right = '' },
                    section_separators = { left = '', right = '' },
                },
                sections = {
                    lualine_a = { '' },
                    lualine_b = { 'b:gitsigns_head', 'diagnostics' },
                    lualine_c = { '%f' },
                    lualine_x = { 'progress', 'location' },
                    lualine_y = { '' },
                    lualine_z = { 'searchcount' },
                },
                inactive_sections = {
                    lualine_a = {},
                    lualine_b = {},
                    lualine_c = { 'filename' },
                    lualine_x = { 'location' },
                    lualine_y = {},
                    lualine_z = {},
                },
                -- https://github.com/nvim-lualine/lualine.nvim/issues/904
                tabline = {},
            })
        end,
    },
    {
        'windwp/nvim-ts-autotag',
        config = function()
            require('nvim-ts-autotag').setup()
        end,
    },
    {
        'nvim-telescope/telescope.nvim',
        version = '0.1.4',
        config = function()
            local telescope = require('telescope')
            telescope.setup({})
            local telescope_builtin = require('telescope.builtin')
            local find_prefix = '<Leader>f'
            local find_keymaps = {
                { 'b', telescope_builtin.buffers, {} },
                { 'd', utils.find_dotfiles, {} },
                { 'e', telescope_builtin.diagnostics, {} },
                { 'f', telescope_builtin.find_files, {} },
                { 'g', telescope_builtin.live_grep, {} },
                { 'h', telescope_builtin.help_tags, {} },
                { 'k', telescope_builtin.keymaps, {} },
                { 'l', vim.lsp.buf.code_action, nil }, -- TODO should this be here or in lsp.lua?
                { 'm', telescope_builtin.man_pages, { sections = { 'ALL' } } },
            }
            for _, keymap in ipairs(find_keymaps) do
                vim.keymap.set('n', find_prefix .. keymap[1], function()
                    keymap[2](keymap[3])
                end)
            end
        end,
        dependencies = {
            'nvim-lua/popup.nvim',
            'nvim-lua/plenary.nvim',
        },
    },
    {
        'olivertaylor/vacme',
        config = function()
            vim.o.background = 'light'
            vim.cmd.colorscheme('vacme')
        end,
        priority = 1000,
    },
    {
        'nvim-telescope/telescope-ui-select.nvim',
        dependencies = {
            'nvim-telescope/telescope.nvim',
        },
    },
    {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('gitsigns').setup({
                signcolumn = false,
                numhl = true,
                on_attach = function(bufnr)
                    buf_map(bufnr, 'n', '<Leader>gb', '<CMD>Gitsigns blame_line<CR>')
                    buf_map(bufnr, 'n', '<Leader>gp', '<CMD>Gitsigns preview_hunk<CR>')
                    buf_map(bufnr, 'n', '<Leader>gr', '<CMD>Gitsigns reset_hunk<CR>')
                    buf_map(bufnr, 'n', '<Leader>g]', '<CMD>Gitsigns next_hunk<CR>')
                    buf_map(bufnr, 'n', '<Leader>g[', '<CMD>Gitsigns prev_hunk<CR>')
                end,
            })
        end,
    },
    'tpope/vim-fugitive',
    'tpope/vim-repeat',
    'tpope/vim-surround',
    'chaoren/vim-wordmotion',
    'jiangmiao/auto-pairs',
    {
        'hrsh7th/nvim-cmp',
        config = function()
            vim.opt.completeopt = { 'menuone', 'noinsert', 'noselect' }
            local cmp = require('cmp')
            local cmp_mappings = {
                ['<C-n>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
                ['<C-p>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
            }
            cmp.setup({
                sources = {
                    { name = 'nvim_lsp' }, -- hrsh7th/cmp-nvim-lsp
                    { name = 'buffer' }, -- hrsh7th/cmp-buffer
                    { name = 'path' }, -- hrsh7th/cmp-path
                    { name = 'luasnip' }, -- saadparwaiz1/cmp_luasnip
                    { name = 'latex_symbols' }, -- hrsh7th/cmp-latex-symbols
                },
                mapping = cmp_mappings,
                snippet = {
                    expand = function(args)
                        require('luasnip').lsp_expand(args.body)
                    end,
                },
            })
        end,
    },
    'hrsh7th/cmp-omni',
    'kdheepak/cmp-latex-symbols',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-nvim-lsp',
    'mfussenegger/nvim-jdtls',
    {
        'nvim-telescope/telescope-fzf-native.nvim',
        config = function()
            require('telescope').load_extension('fzf')
        end,
        build = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build',
        dependencies = {
            'nvim-telescope/telescope.nvim',
        },
    },
    {
        'williamboman/mason.nvim',
        config = function()
            require('mason').setup()
        end,
    },
    {
        'williamboman/mason-lspconfig.nvim',
        config = function()
            require('mason-lspconfig').setup()
        end,
        dependencies = {
            'williamboman/mason.nvim',
            {
                'neovim/nvim-lspconfig',
                config = function()
                    vim.lsp.set_log_level('ERROR')
                    vim.cmd([[
                    command! LspLog lua vim.cmd('e '.. vim.lsp.get_log_path())
                    ]])
                end,
            },
        },
    },
    {
        'nvim-treesitter/nvim-treesitter',
        build = ':TSUpdate',
        config = function()
            require('nvim-treesitter.configs').setup({
                incremental_selection = {
                    enable = true,
                },
                textobjects = {
                    enable = true,
                },
            })
        end,
    },
    {
        'mhartington/formatter.nvim',
        config = function()
            map('n', '<Leader>gf', '<CMD>FormatWrite<CR>')
            require('formatter').setup({
                logging = true,
                log_level = vim.log.levels.WARN,
                filetype = {
                    lua = {
                        require('formatter.filetypes.lua').stylua,
                    },
                    go = {
                        require('formatter.filetypes.go').gofumpt,
                    },
                    rust = {
                        vim.lsp.buf.format,
                    },
                    ['*'] = {
                        require('formatter.filetypes.any').remove_trailing_whitespace,
                    },
                },
            })
        end,
    },
})

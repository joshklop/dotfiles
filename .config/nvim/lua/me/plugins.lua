local utils = require('me.utils')
local map = utils.map
local buf_map = utils.buf_map

-- Bootstrap packer
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP =
        vim.fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
end

require('packer').startup({
    function(use)
        use({ 'nvim-lualine/lualine.nvim' })
        use({ 'wbthomason/packer.nvim' })
        use({ 'windwp/nvim-ts-autotag' })
        use({
            'nvim-telescope/telescope.nvim',
            requires = { 'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim' },
        })
        use({ 'nvim-tree/nvim-tree.lua' })
        use({ 'olivertaylor/vacme' })
        use({ 'nvim-telescope/telescope-ui-select.nvim' })
        use({ 'L3MON4D3/LuaSnip', tag = 'v<CurrentMajor>.*' })
        use({ 'saadparwaiz1/cmp_luasnip' })
        use({ 'jvgrootveld/telescope-zoxide' })
        use({ 'lewis6991/gitsigns.nvim' })
        use({ 'tpope/vim-fugitive' })
        use({ 'tpope/vim-repeat' })
        use({ 'tpope/vim-surround' })
        use({ 'chaoren/vim-wordmotion' })
        use({ 'jiangmiao/auto-pairs' })
        use({ 'hrsh7th/nvim-cmp' })
        use({ 'hrsh7th/cmp-omni' })
        use({ 'kdheepak/cmp-latex-symbols' })
        use({ 'hrsh7th/cmp-buffer' })
        use({ 'hrsh7th/cmp-path' })
        use({ 'hrsh7th/cmp-nvim-lsp' })
        use({ 'mfussenegger/nvim-jdtls' })
        use({ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' })
        use({
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'neovim/nvim-lspconfig',
            run = ':MasonUpdate',
        })
        use({ 'jose-elias-alvarez/null-ls.nvim' })
        use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })
        use({ 'jalvesaq/nvim-r', ft = { 'r', 'Rmd' } })
        use({ 'ray-x/lsp_signature.nvim' })
        if PACKER_BOOTSTRAP then
            require('packer').sync()
        end
    end,
})

vim.o.background = 'light'
vim.cmd.colorscheme('vacme')

-- nvim-tree/nvim-tree.lua
require("nvim-tree").setup()

-- windwp/nvim-ts-autotag
require('nvim-ts-autotag').setup()

-- hrsh7th/nvim-cmp
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

-- jose-elias-alvarez/null-ls.nvim
local null_ls = require('null-ls')
null_ls.setup({
    sources = {
        -- null_ls.builtins.code_actions.gitsigns,
        -- null_ls.builtins.diagnostics.eslint_d,
        -- null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.clang_format,
        null_ls.builtins.formatting.gofumpt,
        -- null_ls.builtins.formatting.prettierd,
        null_ls.builtins.formatting.stylua,
    },
    on_attach = function(_, bufnr)
        vim.keymap.set('n', '<Leader>gf', function()
            vim.lsp.buf.format({
                bufnr = bufnr,
                filter = function(client)
                    return client.name == 'null-ls'
                end,
            })
        end, { buffer = bufnr, silent = true })
    end,
})
-- https://github.com/jose-elias-alvarez/null-ls.nvim/issues/428
local notify = vim.notify
vim.notify = function(msg, ...)
    if msg:match('warning: multiple different client offset_encodings') then
        return
    end

    notify(msg, ...)
end

-- nvim-treesitter/nvim-treesitter
require('nvim-treesitter.configs').setup({
    highlight = {
        enable = true,
        disable = { 'latex' },
    },
    indent = {
        enable = false,
    },
    incremental_selection = {
        enable = true,
    },
    textobjects = { enable = true },
})

-- williamboman/mason.nvim
require('mason').setup()

-- williamboman/mason-lspconfig.nvim
require('mason-lspconfig').setup()
require('mason-registry')

-- nvim/nvim-lspconfig
vim.lsp.set_log_level('ERROR')
vim.cmd([[
command! LspLog lua vim.cmd('e '.. vim.lsp.get_log_path())
]])

-- nvim-telescope/telescope.nvim
local telescope = require('telescope')
telescope.setup({})
local telescope_builtin = require('telescope.builtin')
local find_prefix = '<Leader>f'
local find_keymaps = {
    { 'b', telescope_builtin.buffers, {} },
    { 'd', utils.find_dotfiles, {} },
    { 'e', telescope_builtin.diagnostics, {} },
    { 'f', telescope_builtin.find_files, { hidden = true } },
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
-- nvim-telescope/telescope-fzf-native
telescope.load_extension('fzf')
-- nvim-telescope/telescope-zoxide
telescope.load_extension('zoxide')
map('n', '<Leader>fj', '<CMD>Telescope zoxide list<CR>')
require('telescope._extensions.zoxide.config').setup({
    mappings = {
        default = {
            action = function(selection)
                vim.cmd('lcd ' .. selection.path)
            end,
        },
    },
})

-- lewis6991/gitsigns.nvim
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

-- nvim-lualine/lualine.nvim
local function diff_source()
    local gitsigns = vim.b.gitsigns_status_dict
    if gitsigns then
        return {
            added = gitsigns.added,
            modified = gitsigns.changed,
            removed = gitsigns.removed,
        }
    end
end

require('lualine').setup({
    options = {
        theme = 'auto',
        icons_enabled = false,
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
    },
    sections = {
        lualine_a = { '' },
        lualine_b = { 'b:gitsigns_head', { 'diff', source = diff_source }, 'diagnostics' },
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

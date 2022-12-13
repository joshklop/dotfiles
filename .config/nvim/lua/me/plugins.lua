-- Bootstrap packer
local install_path = vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP =
        vim.fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
end

require('packer').startup({
    function(use)
        use({ 'wbthomason/packer.nvim' })
        use({ 'windwp/nvim-ts-autotag' })
        use({ 'projekt0n/github-nvim-theme' })
        use({
            'nvim-telescope/telescope.nvim',
            requires = { 'nvim-lua/popup.nvim', 'nvim-lua/plenary.nvim' },
        })
        use({ 'nvim-telescope/telescope-ui-select.nvim' })
        use({ 'tpope/vim-eunuch' })
        use({ 'L3MON4D3/LuaSnip', tag = 'v<CurrentMajor>.*' })
        use({ 'saadparwaiz1/cmp_luasnip' })
        use({ 'jvgrootveld/telescope-zoxide' })
        use({ 'lewis6991/gitsigns.nvim' })
        use({ 'mxsdev/nvim-dap-vscode-js', requires = { 'mfussenegger/nvim-dap' } })
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
        use({ 'mfussenegger/nvim-dap' })
        use({ 'jose-elias-alvarez/null-ls.nvim' })
        use({ 'leoluz/nvim-dap-go' })
        use({ 'nvim-telescope/telescope-dap.nvim' })
        use({ 'mfussenegger/nvim-dap-python' })
        use({ 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' })
        use({
            'williamboman/mason.nvim',
            'williamboman/mason-lspconfig.nvim',
            'neovim/nvim-lspconfig',
        })
        use({ 'nvim-treesitter/nvim-treesitter', run = ':TSUpdate' })
        use({ 'chrisbra/csv.vim', ft = { 'csv' } })
        use({ 'jalvesaq/nvim-r', ft = { 'r', 'Rmd' } })
        use({ 'ray-x/lsp_signature.nvim' })
        use({ 'ten3roberts/qf.nvim' })
        use({ 'winston0410/commented.nvim' })
        if PACKER_BOOTSTRAP then
            require('packer').sync()
        end
    end,
    --    config = {
    --        display = {
    --            open_fn = function()
    --                require('packer.util').float({ border = 'single' })
    --            end,
    --        },
    --    },
})

local utils = require('me.utils')
local map = utils.map
local buf_map = utils.buf_map

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
        nl = '<Leader>od',
    },
})

-- ten3roberts/qf.nvim
require('qf').setup({})
map('n', '<Leader>lt', '<CMD>lua require("qf").toggle("l", true)<CR>')
map('n', '<Leader>lj', '<CMD>lua require("qf").below("visible")<CR>')
map('n', '<Leader>lk', '<CMD>lua require("qf").above("visible")<CR>')
map('n', '<Leader>ct', '<CMD>lua require("qf").toggle("c", true)<CR>')
map('n', '<Leader>cj', '<CMD>lua require("qf").below("visible")<CR>')
map('n', '<Leader>ck', '<CMD>lua require("qf").above("visible")<CR>')

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

-- jose-elias-alvarez/null-ls.nvim
local null_ls = require('null-ls')
null_ls.setup({
    sources = {
        null_ls.builtins.code_actions.gitsigns,
        null_ls.builtins.diagnostics.eslint_d,
        null_ls.builtins.formatting.black,
        null_ls.builtins.formatting.clang_format,
        null_ls.builtins.formatting.gofumpt,
        null_ls.builtins.formatting.prettierd,
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

-- williamboman/mason.nvim
require('mason').setup()

-- williamboman/mason-lspconfig.nvim
require('mason-lspconfig').setup()
local mason_registry = require('mason-registry')

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
    { 'l', vim.lsp.buf.code_action, {} }, -- TODO should this be here or in lsp.lua?
    { 'm', telescope_builtin.man_pages, { sections = { 'ALL' } } },
    { 'p', telescope_builtin.git_branches, {} },
    { 'u', telescope_builtin.git_bcommits, {} },
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
-- nvim-telescope/telescope-dap.nvim
telescope.load_extension('dap')
map('n', '<leader>df', '<CMD>Telescope dap frames<CR>')
map('n', '<leader>dl', '<CMD>Telescope dap list_breakpoints<CR>')
-- nvim-telescope/telescope-ui-select.nvim
telescope.load_extension('ui-select')

-- lewis6991/gitsigns.nvim
require('gitsigns').setup({
    signcolumn = false,
    numhl = true,
    on_attach = function(bufnr)
        buf_map(bufnr, 'n', '<Leader>gp', '<CMD>Gitsigns preview_hunk<CR>')
        buf_map(bufnr, 'n', '<Leader>gr', '<CMD>Gitsigns reset_hunk<CR>')
        buf_map(bufnr, 'n', '<Leader>g]', '<CMD>Gitsigns next_hunk<CR>')
        buf_map(bufnr, 'n', '<Leader>g[', '<CMD>Gitsigns prev_hunk<CR>')
        buf_map(bufnr, 'n', '<Leader>gb', '<CMD>Gitsigns toggle_current_line_blame<CR>')
        buf_map(bufnr, 'n', '<Leader>ga', '<CMD>Gitsigns stage_hunk<CR>')
        buf_map(bufnr, 'n', '<Leader>gA', '<CMD>Gitsigns undo_stage_hunk<CR>')
        buf_map(bufnr, 'v', '<Leader>ga', [[<CMD>'<,'>Gitsigns stage_hunk <CR>]])
        buf_map(bufnr, 'v', '<Leader>gA', [[<CMD>'<,'>Gitsigns undo_stage_hunk <CR>]])
    end,
})

-- mfussenegger/nvim-dap
local dap = require('dap') -- Need to load the plugin in order for signs to work
vim.fn.sign_define('DapBreakpoint', { text = '🛑', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapBreakpointRejected', { text = '🟦', texthl = '', linehl = '', numhl = '' })
vim.fn.sign_define('DapStopped', { text = '⭐️', texthl = '', linehl = '', numhl = '' })
map('n', '<Leader>dh', '<CMD>lua require("dap").toggle_breakpoint()<CR>')
map('n', '<Leader>do', '<CMD>lua require("dap").step_out()<CR>')
map('n', '<Leader>ds', '<CMD>lua require("dap").step_into()<CR>')
map('n', '<Leader>dn', '<CMD>lua require("dap").step_over()<CR>')
map('n', '<Leader>db', '<CMD>lua require("dap").step_back()<CR>')
map('n', '<Leader>dc', '<CMD>lua require("dap").continue()<CR>')
map('n', '<Leader>dq', '<CMD>lua require("dap").disconnect({ terminateDebuggee = true });require("dap").close()<CR>')
map('n', '<Leader>dr', '<CMD>lua require("dap").repl.toggle({}, "vsplit")<CR><C-w>l')
map('n', '<Leader>d?', '<CMD>lua local widgets=require"dap.ui.widgets";widgets.centered_float(widgets.scopes)<CR>')
dap.set_log_level('ERROR')
--vim.api.nvim_create_autocmd({'DirChanged', 'UIEnter'}, {
--    callback = function()
--        local vscode_dir = '.vscode'
--        local root_finder = require('lspconfig.util').root_pattern(vscode_dir)
--        local root_path = root_finder(vim.api.nvim_buf_get_name(0))
--        if root_path then
--            require('dap.ext.vscode').load_launchjs(root_path .. '/' .. vscode_dir .. '/launch.json', {
--                pwa_node_pre_launch = {'typescript', 'javascript'},
--            })
--        end
--    end,
--    pattern = {'*.ts'},
--})
-- mfussenegger/nvim-dap-python
require('dap-python').setup(os.getenv('HOME') .. '/.venv/debugpy/bin/python', {})
require('dap-python').test_runner = 'pytest'
-- leoluz/nvim-dap-go
require('dap-go').setup()
-- mxsdev/nvim-dap-vscode-js
require('dap-vscode-js').setup({
    debugger_path = mason_registry.get_package('js-debug-adapter'):get_install_path(),
    adapters = { 'pwa-node' },
})
--local plenary_async = require('plenary.async')
--dap.adapters['pwa_node_pre_launch'] = function(_, config)
--    if config.preLaunchTask then
--        plenary_async.run(function()
--            vim.notify('Running [' .. config.preLaunchTask .. ']')
--        end,
--        function()
--            vim.fn.system(config.preLaunchTask)
--            config.type = 'pwa-node'
--            dap.run(config)
--        end)
--    end
--end
dap.configurations.c = {
    {
        name = 'Launch file',
        type = 'cpptools',
        request = 'launch',
        miMode = 'gdb',
        miDebuggerPath = mason_registry.get_package('cpptools'):get_install_path(),
        program = function()
            return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
        end,
        cwd = '${workspaceFolder}',
        stopOnEntry = true,
    },
}
dap.configurations.cpp = dap.configurations.c

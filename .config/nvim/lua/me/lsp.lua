local lspconfig = require('lspconfig')
local mason_lspconfig = require('mason-lspconfig')
local lsp_signature = require('lsp_signature')
local cmp_nvim_lsp = require('cmp_nvim_lsp')

lspconfig.util.on_setup = lspconfig.util.add_hook_after(lspconfig.util.on_setup, function(config)
    config.on_attach = lspconfig.util.add_hook_before(config.on_attach, function(client, bufnr)
        -- see https://github.com/mfussenegger/dotfiles/blob/e5606c42ce1dc167047f32008e311ec7c22a0407/vim/.config/nvim/lua/me/lsp.lua#L65-L76
        -- array of mappings to setup; {<capability>, <mode>, <lhs>, <rhs>}
        local key_mappings = {
            { 'definitionProvider', 'n', 'gd', vim.lsp.buf.definition },
            { 'referencesProvider', 'n', 'gr', vim.lsp.buf.references },
            { 'hoverProvider', 'n', 'K', vim.lsp.buf.hover },
            { 'implementationProvider', 'n', 'gi', vim.lsp.buf.implementation },
            { 'typeDefinitionProvider', 'n', '<Leader>gD', vim.lsp.buf.type_definition },
            { 'renameProvider', 'n', '<Leader>rn', vim.lsp.buf.rename },
        }
        for _, mappings in pairs(key_mappings) do
            local capability, mode, lhs, rhs = unpack(mappings)
            if client.server_capabilities[capability] then
                vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, silent = true })
            end
        end

        vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
        lsp_signature.on_attach()
    end)

    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = cmp_nvim_lsp.default_capabilities(capabilities)
    config.capabilities = vim.tbl_deep_extend('force', capabilities, config.capabilities or {})
end)

mason_lspconfig.setup_handlers({
    function(server_name)
        lspconfig[server_name].setup({})
    end,
    ['html'] = function()
        lspconfig.html.setup({
            capabilities = {
                textDocument = {
                    completion = {
                        completionItem = {
                            snippetSupport = true,
                        },
                    },
                },
            },
        })
    end,
    ['bashls'] = function()
        lspconfig.bashls.setup({
            filetypes = { 'sh', 'bash', 'zsh' },
        })
    end,
    ['gopls'] = function()
        lspconfig.gopls.setup({
            settings = {
                gopls = {
                    analyses = {
                        unusedparams = true,
                    },
                    staticcheck = true,
                    -- https://github.com/golang/go/issues/29202
                    -- env = {
                    --     GOFLAGS = '-tags=integration',
                    -- },
                },
            },
        })
    end,
    ['clangd'] = function()
        local target = ''
        if vim.fn.has('win32') ~= 0 then
            target = '--target=x86_64-w64-mingw64' -- Use gcc for linking on Windows
        end
        lspconfig.clangd.setup({
            init_options = {
                fallbackFlags = { target, '-Wall' },
            },
        })
    end,
    --['texlab'] = function()
    --    lspconfig.texlab.setup()
    --    -- {
    --    --     on_attach = function(_, buf)
    --    --         -- TODO I think there is a better way to do this. Use the actual function instead of '<CMD>...<CR>'
    --    --         -- vim.keymap.set('n', '<Leader>lb', '<CMD>TexlabBuild<CR>', { buffer = buf })
    --    --     end,
    --    -- })
    --end,
    ['lua_ls'] = function()
        local runtime_path = vim.split(package.path, ';')
        table.insert(runtime_path, 'lua/?.lua')
        table.insert(runtime_path, 'lua/?/init.lua')
        lspconfig.lua_ls.setup({
            filetypes = { 'lua' },
            settings = {
                Lua = {
                    runtime = {
                        version = 'LuaJIT',
                        path = runtime_path,
                    },
                    diagnostics = {
                        globals = { 'vim' },
                    },
                    workspace = {
                        library = vim.api.nvim_get_runtime_file('', true),
                    },
                    telemetry = {
                        enable = false,
                    },
                },
            },
        })
    end,
})

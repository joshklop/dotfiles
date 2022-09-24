local lspconfig = require('lspconfig')
local utils = require('me.utils')
local map = utils.map
local on_attach = utils.on_attach
local capabilities = utils.capabilities

local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')
lspconfig.sumneko_lua.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = {'lua'},
    settings = {
        Lua = {
            runtime = {
                version = 'LuaJIT',
                path = runtime_path,
            },
            diagnostics = {
                globals = {'vim'},
            },
            workspace = {
                library = vim.api.nvim_get_runtime_file("", true),
            },
            telemetry = {
                enable = false,
            },
        },
    },
})

local function latex_on_attach(client, bufnr)
    on_attach(client, bufnr)
    map('n', '<Leader>lb', '<CMD>TexlabBuild<CR>')
end
lspconfig.texlab.setup({
    capabilities = capabilities,
    on_attach = latex_on_attach,
})

local target = ''
if vim.fn.has('win32') ~= 0 then
    target = '--target=x86_64-w64-mingw64' -- Use gcc for linking on Windows
end
lspconfig.clangd.setup({
    capabilities = capabilities,
    init_options = {
        fallbackFlags = {target, '-Wall'},
    },
    on_attach = on_attach,
})

lspconfig.pylsp.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

lspconfig.gopls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
            },
            staticcheck = true,
        },
    }
})

lspconfig.solc.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

lspconfig.bashls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = {'sh', 'bash', 'zsh'},
})

lspconfig.tsserver.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

lspconfig.awk_ls.setup({
    capabilities, capabilities,
    on_attach = on_attach,
})

lspconfig.groovyls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

lspconfig.jsonls.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

lspconfig.rust_analyzer.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

lspconfig.eslint.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

capabilities.textDocument.completion.completionItem.snippetSupport = true
lspconfig.html.setup({
    capabilities = capabilities,
    on_attach = on_attach,
})

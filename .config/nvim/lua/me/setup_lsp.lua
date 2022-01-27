local lspconfig = require('lspconfig')
local utils = require('me.utils')
local map = utils.map
local on_attach = utils.on_attach
local sanitize_binary = utils.sanitize_binary
local servers = vim.fn.stdpath('data') .. '/lsp_servers'

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local sumneko_root_path = servers .. '/sumneko_lua/extension/server'
local sumneko_binary_path = sanitize_binary(sumneko_root_path .. '/bin/lua-language-server')
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, 'lua/?.lua')
table.insert(runtime_path, 'lua/?/init.lua')
lspconfig.sumneko_lua.setup({
    cmd = {sumneko_binary_path, '-E', sumneko_root_path .. '/main.lua'},
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
            }
        }
    }
})

local function latex_on_attach(client, bufnr)
    on_attach(client, bufnr)
    map('n', '<Leader>lb', '<CMD>TexlabBuild<CR>')
end
lspconfig.texlab.setup({
    capabilities = capabilities,
    cmd = {sanitize_binary(servers .. '/latex/texlab')},
    on_attach = latex_on_attach
})

local target = ''
if vim.fn.has('win32') ~= 0 then
    target = '--target=x86_64-w64-mingw64' -- Use gcc for linking on Windows
end
lspconfig.clangd.setup({
    capabilities = capabilities,
    cmd = {sanitize_binary(servers .. '/clangd/clangd/bin/clangd')},
    init_options = {
        fallbackFlags = {target, '-Wall'}
    },
    on_attach = on_attach
})

lspconfig.pylsp.setup({
    capabilities = capabilities,
    cmd = {sanitize_binary(servers .. '/pylsp/venv/bin/pylsp')},
    on_attach = on_attach
})

lspconfig.hls.setup({
    capabilities = capabilities,
    cmd = {sanitize_binary(servers .. '/haskell/haskell-language-server-wrapper'), '--lsp'},
    on_attach = on_attach
})

lspconfig.powershell_es.setup({
    capabilities = capabilities,
    bundle_path = servers .. '/powershell_es',
    on_attach = on_attach
})

lspconfig.gopls.setup({
    capabilities = capabilities,
    cmd = {sanitize_binary(servers .. '/go/gopls')},
    on_attach = on_attach
})

lspconfig.solc.setup({
    capabilities = capabilities,
    cmd = {sanitize_binary(servers .. '/solc/solc'), '--lsp'},
    on_attach = on_attach
})

lspconfig.bashls.setup({
    capabilities = capabilities,
    cmd = {servers .. '/bash/node_modules/bash-language-server/bin/main.js', 'start'},
    on_attach = on_attach,
    filetypes = {'sh', 'bash', 'zsh'},
})

lspconfig.tsserver.setup({
    capabilities = capabilities,
    cmd = {servers .. '/tsserver/node_modules/typescript-language-server/lib/cli.js', '--stdio'},
    on_attach = on_attach,
})

capabilities.textDocument.completion.completionItem.snippetSupport = true
lspconfig.html.setup({
    capabilities = capabilities,
    cmd = {sanitize_binary(servers .. '/html/node_modules/vscode-langservers-extracted/bin/vscode-html-language-server'), '--stdio'},
    on_attach = on_attach,
})

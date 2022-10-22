local lspconfig = require('lspconfig')

local function snake_to_camel(s)
    for i = 1, s:len() do
       if s[i] == '_' and i < s:len() then
           s[i] = ''
           i = i + 1
           s[i] = string.upper(s[i])
       end
    end
    return s
end

return {
    setup = function() -- should only be called once
        vim.api.nvim_create_autocmd('LspAttach', {
            callback = function(args)
                local client = vim.lsp.get_client_by_id(args.data.client_id)
                local map = function(binding, capability)
                    if client.server_capabilities[snake_to_camel(capability) .. 'Provider'] then
                        vim.keymap.set('n', binding, vim.lsp.buf[capability], {buffer = args.buf})
                    end
                end

                map('gd', 'definition')
                map('gr', 'references')
                map('K', 'hover')
                map('gi', 'implementation')
                map('<Leader>D', 'type_definition')
                map('<Leader>rn', 'rename')

                vim.keymap.set('n', '<Leader>e', function()
                    vim.diagnostic.open_float(nil, {scope = "line"})
                end, {buffer = args.buf})
                vim.keymap.set('n', ']d', vim.diagnostic.goto_next, {buffer = args.buf})
                vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, {buffer = args.buf})
            end
        })

        lspconfig.util.on_setup = lspconfig.util.add_hook_after(lspconfig.util.on_setup, function(config)
            config.on_attach = lspconfig.util.add_hook_before(config.on_attach, function(_, bufnr)
                vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
                vim.cmd [[
                hi LspDiagnosticsVirtualTextError guifg=red
                hi LspDiagnosticsVirtualTextWarning guifg=orange
                hi LspDiagnosticsVirtualTextInformation guifg=gray
                hi LspDiagnosticsVirtualTextHint guifg=green
                ]]
                require('lsp_signature').on_attach()
            end)
            config.capabilities = vim.tbl_deep_extend("force", require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities()), config.capabilities or {})
        end)

        require('mason-lspconfig').setup_handlers({
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
                    filetypes = {'sh', 'bash', 'zsh'},
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
                        },
                    }
                })
            end,
            ['clangd'] = function()
                local target = ''
                if vim.fn.has('win32') ~= 0 then
                    target = '--target=x86_64-w64-mingw64' -- Use gcc for linking on Windows
                end
                lspconfig.clangd.setup({
                    init_options = {
                        fallbackFlags = {target, '-Wall'},
                    },
                })
            end,
            ['texlab'] = function()
                lspconfig.texlab.setup({
                    on_attach = function(_, buf)
                        vim.keymap.set('n', '<Leader>lb', '<CMD>TexlabBuild<CR>', {buffer = buf}) -- TODO I think there is a better way to do this
                    end,
                })

            end,
            ['sumneko_lua'] = function()
                local runtime_path = vim.split(package.path, ';')
                table.insert(runtime_path, 'lua/?.lua')
                table.insert(runtime_path, 'lua/?/init.lua')
                lspconfig.sumneko_lua.setup({
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

            end
        })
    end,
}

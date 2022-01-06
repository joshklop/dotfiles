local LSP = {}

local map = require('me.utils').map
local servers = vim.fn.stdpath('data') .. '/lsp_servers'

local function get_capabilities()
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    return require('cmp_nvim_lsp').update_capabilities(capabilities)
end

local function on_attach(_, bufnr)
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
    map('n', 'gd', '<CMD>lua vim.lsp.buf.definition()<CR>')
    map('n', 'gr', '<CMD>lua vim.lsp.buf.references()<CR>')
    map('n', 'K', '<CMD>lua vim.lsp.buf.hover()<CR>')
    map('n', 'gi', '<CMD>lua vim.lsp.buf.implementation()<CR>')
    map('n', '<Leader>D', '<CMD>lua vim.lsp.buf.type_definition()<CR>')
    map('n', '<Leader>rn', '<CMD>lua vim.lsp.buf.rename()<CR>')
    map('n', '<Leader>e', '<CMD>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>')
    map('n', '[d', '<CMD>lua vim.lsp.diagnostic.goto_prev()<CR>')
    map('n', ']d', '<CMD>lua vim.lsp.diagnostic.goto_next()<CR>')
    map('n', '<Leader>q', '<CMD>lua vim.lsp.diagnostic.set_loclist()<CR>')
    vim.cmd [[
    hi LspDiagnosticsVirtualTextError guifg=red
    hi LspDiagnosticsVirtualTextWarning guifg=orange
    hi LspDiagnosticsVirtualTextInformation guifg=gray
    hi LspDiagnosticsVirtualTextHint guifg=green
    ]]
    require('lsp_signature').on_attach()
end


function LSP.setup_lua()
    local sumneko_root_path = servers .. '/sumneko_lua/extension/server/bin/lua-language-server.exe'
    local runtime_path = vim.split(package.path, ';')
    table.insert(runtime_path, 'lua/?.lua')
    table.insert(runtime_path, 'lua/?/init.lua')
    require('lspconfig').sumneko_lua.setup {
        cmd = {sumneko_binary, '-E', sumneko_root_path .. '/main.lua'},
        capabilities = get_capabilities(),
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
                    library = vim.api.nvim_get_runtime_file('', true),
                }
            }
        }
    }
end

function LSP.setup_latex()
    require('lspconfig').texlab.setup {
        cmd = {servers .. '/latex/texlab'},
        capabilities = get_capabilities(),
        on_attach = on_attach
    }
    map('n', '<Leader>lb', '<CMD>TexlabBuild<CR>')
end

function LSP.setup_java()
    local jdtls = require('jdtls')
    local on_attach_jdtls = function(client, bufnr)
        on_attach(client, bufnr)
        jdtls.setup_dap({hotcodereplace = 'auto'})
        jdtls.setup.add_commands()
        map('n', '<Leader>dm', '<CMD>lua require("jdtls").test_nearest_method()<CR>')
        map('n', '<Leader>dC', '<CMD>lua require("jdtls").test_class()<CR>')
    end
    local settings = {
        --    ['java.format.settings.url'] = home .. "/.config/nvim/language-servers/java-google-formatter.xml",
        --    ['java.format.settings.profile'] = "GoogleStyle",
        java = {
            signatureHelp = {enabled = true};
            contentProvider = {preferred = 'fernflower'};
            completion = {
                favoriteStaticMembers = {
                    "org.junit.jupiter.api.Assertions.*",
                    "java.util.Objects.requireNonNull",
                    "java.util.Objects.requireNonNullElse",
                    "org.mockito.Mockito.*"
                }
            },
            sources = {
                organizeImports = {
                    starThreshold = 9999,
                    staticStarThreshold = 9999
                }
            },
            codeGeneration = {
                toString = {
                    template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}"
                }
            },
            configuration = {
                runtimes = {
                    {
                        name = "JavaSE-17",
                        path = "/usr/lib/jvm/java-17-openjdk"
                    }
                }
            }
        }
    }
    local home = os.getenv('USERPROFILE');
    local bundles = {vim.fn.glob(home .. '/.config/nvim/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar')}
    vim.list_extend(bundles, vim.split(vim.fn.glob(home .. '/.config/nvim/vscode-java-test/server/*.jar'), '\n'))
    local root_dir = jdtls.setup.find_root({'.git', 'mvnw', 'gradlew'})
    local config = {
        capabilities = get_capabilities(),
        on_attach = on_attach_jdtls,
        settings = settings,
        init_options = { bundles = bundles },
        flags = {
            allow_incremental_sync = true,
            server_side_fuzzy_completion = true
        },
        root_dir = root_dir,
        cmd = {'java-lsp.sh', home .. '/.workspace' .. vim.fn.fnamemodify(root_dir, ':p:h:t')}
    }
    jdtls.start_or_attach(config)
end

function LSP.setup_c()
    require('lspconfig').clangd.setup {
        on_attach = on_attach,
        capabilities = get_capabilities()
    }
end

function LSP.setup_python()
    require('lspconfig').pylsp.setup {
        capabilities = get_capabilities(),
        on_attach = on_attach
    }
end

function LSP.setup_css()
    require('lspconfig').tailwindcss.setup {
        cmd = {servers .. '/tailwindcss_npm/node_modules/@tailwindcss/language-server/bin/tailwindcss-language-server'},
        capabilities = get_capabilities(),
        on_attach = on_attach
    }
end

function LSP.setup_typescript()
    require('lspconfig').tsserver.setup {
        capabilities = get_capabilities(),
        on_attach = on_attach
    }
end

-- FIXME Currently does not work
function LSP.setup_haskell()
    require('lspconfig').hls.setup {
        on_attach = on_attach,
        cmd = {servers .. '/haskell/haskell-language-server-wrapper', '--lsp'}
    }
end

function LSP.setup_svelte()
    require('lspconfig').svelte.setup {
        capabilities = get_capabilities(),
        cmd = {servers .. '/svelte/node_modules/svelte-language-server/bin/server.js', '--stdio'},
        on_attach = on_attach
    }
end

function LSP.setup_html()
    require('lspconfig').html.setup {
        capabilities = get_capabilities(),
        cmd = {servers .. '/html/node_modules/vscode-langservers-extracted/bin/vscode-html-language-server', '--stdio'},
        on_attach = on_attach
    }
end

return LSP

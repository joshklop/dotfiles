local lspconfig = require('lspconfig')
local utils = require('me.utils')
local map = utils.map
local home = utils.home
local servers = vim.fn.stdpath('data') .. '/lsp_servers'

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local function on_attach(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
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

local function sanitize_binary(path)
    if vim.fn.has('win32') then
        path = path .. '.exe'
    end
    return path
end

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
if vim.fn.has('win32') then
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
    cmd = {sanitize_binary(servers .. '/pylsp/venv/Scripts/pylsp')},
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

-- Java
local function setup_java()
    local jdtls = require('jdtls')
    local on_attach_jdtls = function(client, bufnr)
        on_attach(client, bufnr)
        jdtls.setup_dap({hotcodereplace = 'auto'})
        jdtls.setup.add_commands()
        map('n', '<Leader>dm', '<CMD>lua require("jdtls").test_nearest_method()<CR>')
        map('n', '<Leader>dC', '<CMD>lua require("jdtls").test_class()<CR>')
    end

    -- TODO Configure runtimes for Linux
    local runtime_root = ''
    local runtimes = ''
    if vim.fn.exists('win32') then
        runtime_root = home .. '/scoop/apps'
        runtimes = {
            {
                name = 'JavaSE-11',
                path = runtime_root .. '/openjdk11/current'
            },
            {
                name = 'JavaSE-17',
                path = runtime_root .. '/openjdk17/current'
            }
        }
    end

    local jdtls_root = home .. '/repos/jdtls'

    local bundles = {vim.fn.glob(jdtls_root .. '/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar')}
    vim.list_extend(bundles, vim.split(vim.fn.glob(jdtls_root .. '/vscode-java-test/server/*.jar'), '\n'))

    local root_dir = jdtls.setup.find_root({'.git', 'mvnw', 'gradlew'})

    local config = {
        capabilities = capabilities,
        on_attach = on_attach_jdtls,
        settings = {
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
                configuration = {runtimes = runtimes}
            }
        },
        init_options = {bundles = bundles},
        flags = {
            allow_incremental_sync = true,
            server_side_fuzzy_completion = true
        },
        root_dir = root_dir,
        cmd = {
            'java',
            '-Declipse.application=org.eclipse.jdt.ls.core.id1',
            '-Dosgi.bundles.defaultStartLevel=4',
            '-Declipse.product=org.eclipse.jdt.ls.core.product',
            '-Dlog.protocol=true',
            '-Dlog.level=ALL',
            '-Xms1g',
            '--add-modules=ALL-SYSTEM',
            '--add-opens', 'java.base/java.util=ALL-UNNAMED',
            '--add-opens', 'java.base/java.lang=ALL-UNNAMED',
            '-jar', jdtls_root .. '/server/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
            '-configuration', jdtls_root .. '/server/config_win',
            '-data', jdtls_root .. '/.workspace' .. vim.fn.fnamemodify(root_dir, ':p:t')
        }
    }
    jdtls.start_or_attach(config)
end

vim.cmd [[
augroup lsp
au FileType java lua setup_java()
augroup end
]]

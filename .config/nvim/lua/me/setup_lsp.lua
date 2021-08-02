local LSP = {}

local function on_attach(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
    buf_set_option('omnifunc', 'v:lua.vim.lsp.omnifunc')
    local opts = {noremap=true, silent=true}
    buf_set_keymap('n', 'gd', '<CMD>lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'gr', '<CMD>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', 'K', '<CMD>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gi', '<CMD>lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', '<Leader>D', '<CMD>lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<Leader>rn', '<CMD>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<Leader>e', '<CMD>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>', opts)
    buf_set_keymap('n', '[d', '<CMD>lua vim.lsp.diagnostic.goto_prev()<CR>', opts)
    buf_set_keymap('n', ']d', '<CMD>lua vim.lsp.diagnostic.goto_next()<CR>', opts)
    buf_set_keymap('n', '<Leader>q', '<CMD>lua vim.lsp.diagnostic.set_loclist()<CR>', opts)
    -- Set highlights
    vim.cmd [[
    hi LspDiagnosticsVirtualTextError guifg=red
    hi LspDiagnosticsVirtualTextWarning guifg=orange
    hi LspDiagnosticsVirtualTextInformation guifg=yellow
    hi LspDiagnosticsVirtualTextHint guifg=green
    ]]
    -- Set some keybinds conditional on server capabilities
    if client.resolved_capabilities.document_formatting then
        buf_set_keymap('n', '<Leader>f', '<CMD>lua vim.lsp.buf.formatting()<CR>', opts)
    elseif client.resolved_capabilities.document_range_formatting then
        buf_set_keymap('n', '<Leader>f', '<CMD>lua vim.lsp.buf.formatting()<CR>', opts)
    end
    -- Set autocommands conditional on server_capabilities
    if client.resolved_capabilities.document_highlight then
        vim.api.nvim_exec([[
        augroup lsp_document_highlight
            au! * <buffer>
            au CursorHold <buffer> lua vim.lsp.buf.document_highlight()
            au CursorMoved <buffer> lua vim.lsp.buf.clear_references()
        augroup END
        ]], false)
    end
end

function LSP.setup_lua()
    local sumneko_root_path = os.getenv('HOME') .. '/.local/share/nvim/lspinstall/lua/sumneko-lua/extension/server'
    local sumneko_binary = sumneko_root_path .. '/bin' .. '/Linux' .. '/lua-language-server'

    local runtime_path = vim.split(package.path, ';')
    table.insert(runtime_path, 'lua/?.lua')
    table.insert(runtime_path, 'lua/?/init.lua')

    require('lspconfig').sumneko_lua.setup {
      cmd = {sumneko_binary, '-E', sumneko_root_path .. '/main.lua'},
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

function LSP.setup_jdtls()
    local on_attach_jdtls = function(client, bufnr)
        on_attach(client, bufnr)
        local opts = {noremap=true, silent=true}
        local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
        local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end
        buf_set_keymap('n', '<Leader>di', "<CMD>lua require'jdtls'.organize_imports()<CR>", opts)
        buf_set_keymap('n', '<Leader>dc', "<CMD>lua require'jdtls'.test_class()<CR>", opts)
        buf_set_keymap('n', '<Leader>dm', "<CMD>lua require'jdtls'.test_nearest_method()<CR>", opts)
    end
    local capabilities = {
        workspace = {configuration = true},
        textDocument = {completion = {completionItem = {snippetSupport = true}}}
    }
    local workspace_folder = os.getenv('HOME') .. '/.workspace' .. vim.fn.fnamemodify(root_dir, ':p:h:t')
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
                        name = "JavaSE-16",
                        path = "/usr/lib/jvm/java-16-openjdk"
                    }
                }
            }
        }
    }
    local config = {
        capabilities = capabilities,
        on_attach = on_attach_jdtls,
        settings = settings,
        flags = {
            allow_incremental_sync = true,
            server_side_fuzzy_completion = true
        },
        cmd = {'java-lsp.sh', workspace_folder}
    }
    require('jdtls').start_or_attach(config)
end

return LSP

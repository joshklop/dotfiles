local utils = require('me.utils')
local home = utils.home
local map = utils.map
local on_attach = utils.on_attach
local capabilities = utils.capabilities
local jdtls = require('jdtls')

vim.opt_local.colorcolumn = 100

local on_attach_jdtls = function(client, bufnr)
    on_attach(client, bufnr)
    jdtls.setup_dap({hotcodereplace = 'auto'})
    jdtls.setup.add_commands() -- Must be run after `setup_dap`
    map('n', '<Leader>dm', '<CMD>lua require("jdtls").test_nearest_method()<CR>')
    map('n', '<Leader>dC', '<CMD>lua require("jdtls").test_class()<CR>')
end

local runtimes = {
    {
        name = 'JavaSE-17',
        path = '/usr/lib/jvm/java-17-openjdk/'
    }
}
if vim.fn.exists('win32') ~= 0 then
    runtimes = {
        {
            name = 'JavaSE-11',
            path = home .. '/scoop/apps/openjdk11/current'
        },
        {
            name = 'JavaSE-17',
            path = home .. '/scoop/apps/openjdk17/current'
        }
    }
end

local jdtls_root = home .. '/repos/jdtls'

local bundles = {vim.fn.glob(jdtls_root .. '/java-debug/com.microsoft.java.debug.plugin/target/com.microsoft.java.debug.plugin-*.jar')}
vim.list_extend(bundles, vim.split(vim.fn.glob(jdtls_root .. '/vscode-java-test/server/*.jar'), '\n'))

local root_dir = jdtls.setup.find_root({'.git', 'mvnw', 'gradlew'})

local configuration = jdtls_root .. '/server/config_linux'
if vim.fn.has('win32') ~= 0 then
    configuration = jdtls_root .. '/server/config_win'
end

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
        '-configuration', configuration,
        '-data', jdtls_root .. '/.workspace' .. vim.fn.fnamemodify(root_dir, ':p:t')
    }
}

jdtls.start_or_attach(config)

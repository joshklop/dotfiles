local mason_registry = require('mason-registry')
local utils = require('me.utils')
local jdtls = require('jdtls')

vim.opt_local.colorcolumn = '100'

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
            path = utils.home .. '/scoop/apps/openjdk11/current'
        },
        {
            name = 'JavaSE-17',
            path = utils.home .. '/scoop/apps/openjdk17/current'
        }
    }
end

local jdtls_path = mason_registry.get_package('jdtls'):get_install_path()

local root_dir = jdtls.setup.find_root({'.git', 'mvnw', 'gradlew'})

local configuration = jdtls_path .. '/config_linux'
if vim.fn.has('win32') ~= 0 then
    configuration = jdtls_path .. '/config_win'
end

local config = {
    on_attach = function(_, bufnr)
        jdtls.setup.add_commands()
        vim.keymap.set('n',  '<LocalLeader>dm', jdtls.test_nearest_method(), {buffer = bufnr})
        vim.keymap.set('n',  '<LocalLeader>dC', jdtls.test_class(), {buffer = bufnr})
    end,
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
        '-jar', jdtls_path .. '/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar',
        '-configuration', configuration,
        '-data', utils.home .. '/.workspace' .. vim.fn.fnamemodify(root_dir, ':p:t')
    }
}

jdtls.start_or_attach(config)

local M = {}

local Path = require('plenary.path')
local finders = require('telescope.finders')
local sorters = require('telescope.sorters')
local pickers = require('telescope.pickers')
local telescope_config = require('telescope.config')

M.home = os.getenv('HOME') or os.getenv('USERPROFILE')

-- TODO there should be a better way to do this (register as telescope extension or something)
function M.find_dotfiles(opts)
    opts = opts or {}
    opts.cwd = opts.cwd or vim.loop.cwd()
    opts.entry_maker = opts.entry_maker
        or function(entry)
            local path = Path:new(Path:new(M.home .. '/' .. entry):make_relative(opts.cwd)):normalize(opts.cwd)
            return {
                path = path,
                value = path,
                display = path,
                ordinal = path,
            }
        end
    -- c ls-tree --full-tree -r --name-only HEAD
    local custom_cmd = {
        'git',
        '--git-dir=' .. M.home .. '/.dotfiles',
        '--work-tree=' .. M.home,
        'ls-tree',
        '--full-tree',
        '-r',
        '--name-only',
        'HEAD',
    }
    pickers
        .new(opts, {
            results_title = 'dotfiles',
            finder = finders.new_oneshot_job(custom_cmd, opts),
            sorter = sorters.get_fuzzy_file(),
            previewer = telescope_config.values.file_previewer(opts),
        })
        :find()
end

function M.map(mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend('force', options, opts)
    end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function M.update()
    require('packer').sync()
    local packages = require('mason-registry').get_installed_packages()
    for _, package in ipairs(packages) do
        package:check_new_version(function(out_of_date)
            if out_of_date then
                package:install()
            end
        end)
    end
end

function M.buf_map(bufnr, mode, lhs, rhs, opts)
    local options = { noremap = true }
    if opts then
        options = vim.tbl_extend('force', options, opts)
    end
    vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, options)
end

function M.sanitize_binary(path)
    if vim.fn.has('win32') ~= 0 then
        path = path .. '.exe'
    end
    return path
end

return M

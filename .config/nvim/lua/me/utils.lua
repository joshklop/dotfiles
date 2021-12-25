local M = {}

function M.find_dotfiles(opts)
    opts = opts or {}
    opts.cwd = opts.cwd or vim.loop.cwd()
    local home = os.getenv('HOME')
    local Path = require('plenary.path')
    opts.entry_maker = opts.entry_maker or function(entry)
       local path = Path:new(Path:new(home .. entry):make_relative(opts.cwd)):normalize(opts.cwd)
       return {
           path = path,
           value = path,
           display = path,
           ordinal = path
       }
    end
    local custom_cmd = {
        'git', '--git-dir=' .. home .. '/.dotfiles', '--work-tree=' .. home,
        'ls-tree', '--full-tree', '-r', '--name-only', 'HEAD'
    }
    require('telescope.pickers').new(opts, {
        results_title = 'dotfiles',
        finder = require('telescope.finders').new_oneshot_job(custom_cmd, opts),
        sorter = require('telescope.sorters').get_fuzzy_file(),
        previewer = require('telescope.config').values.file_previewer(opts)
    }):find()
end

function M.map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

function M.buf_map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

return M

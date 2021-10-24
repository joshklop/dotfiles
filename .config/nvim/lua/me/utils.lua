local M = {}

function M.find_dotfiles(opts)
    opts = opts or {}
    local home = os.getenv('HOME')
    opts.entry_maker = opts.entry_maker or function(entry)
       -- TODO clean up so paths are relative
       local path = home .. '/' .. entry
       local display = '~/' .. entry
       return {
           path = path,
           value = display,
           display = display,
           ordinal = display
       }
    end
    local pickers = require('telescope.pickers')
    local sorters = require('telescope.sorters')
    local finders = require('telescope.finders')
    local custom_cmd = {
        'git', '--git-dir=' .. home .. '/.dotfiles', '--work-tree=' .. home,
        'ls-tree', '--full-tree', '-r', '--name-only', 'HEAD'
    }
    pickers.new(opts, {
        results_title = 'dotfiles',
        finder = finders.new_oneshot_job(custom_cmd, opts),
        sorter = sorters.get_fuzzy_file(),
        previewer = require('telescope.config').values.file_previewer(opts)
    }):find()
end

function M.map(mode, lhs, rhs, opts)
    local options = {noremap = true}
    if opts then options = vim.tbl_extend('force', options, opts) end
    vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

return M

local M = {}

-- WIP, does not work

function M.find_dotfiles()
    -- Code mostly taken from https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#running-external-commands
    local previewers = require('telescope.previewers')
    local pickers = require('telescope.pickers')
    local sorters = require('telescope.sorters')
    local finders = require('telescope.finders')
    local home = os.getenv('HOME')
    local custom_cmd = {
        'git', '--git-dir=' .. home .. '/.dotfiles', '--work-tree=' .. home,
        'ls-tree', '--full-tree', '-r', '--name-only', 'HEAD'
    }
    --custom_cmd[2] = '--git-dir=/home/user/.dotfiles'
    --custom_cmd[3] = '--work-tree=/home/user'
    pickers.new {
      results_title = 'dotfiles',
      -- Run an external command and show the results in the finder window
      finder = finders.new_oneshot_job(custom_cmd, {cwd = '/home/user'}),
      sorter = sorters.get_fuzzy_file(),
--      previewer = previewers.new_termopen_previewer {
--        -- Execute another command using the highlighted entry
--        get_command = function(entry)
--          return {'cat', entry.value}
--        end
--      },
    }:find()
end

return M

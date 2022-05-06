local opts = {silent = true}
require('me.utils').buf_map('n', '<LocalLeader>dm', '<CMD>lua require("dap-python").test_method()<CR>', opts)
require('me.utils').buf_map('n', '<LocalLeader>dC', '<CMD>lua require("dap-python").test_class()<CR>', opts)
require('me.utils').buf_map('n', '<LocalLeader>dv', '<ESC><CMD>lua require("dap-python").debug_selection()<CR>', opts)

vim.opt_local.colorcolumn = {80}

vim.opt_local.expandtab = false
vim.opt_local.softtabstop = 8
vim.opt_local.shiftwidth = 8
require('me.utils').buf_map('n', '<LocalLeader>dm', '<CMD>lua require("dap-go").debug_test()<CR>', {silent = true})

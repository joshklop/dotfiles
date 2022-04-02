local opts = {silent = true}
require('me.utils').buf_map('n', '<Leader>dn', '<CMD>require("dap-python").test_method()<CR>', opts)
require('me.utils').buf_map('n', '<Leader>df', '<CMD>require("dap-python").test_class()<CR>', opts)
require('me.utils').buf_map('n', '<Leader>ds', '<CMD>require("dap-python").debug_selection()<CR>', opts)

vim.opt_local.colorcolumn = 80

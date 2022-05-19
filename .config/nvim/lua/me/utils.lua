local M = {}

M.home = os.getenv('HOME') or os.getenv('USERPROFILE')

function M.find_dotfiles(opts)
    opts = opts or {}
    opts.cwd = opts.cwd or vim.loop.cwd()
    local Path = require('plenary.path')
    opts.entry_maker = opts.entry_maker or function(entry)
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
        'git', '--git-dir=' .. M.home .. '/.dotfiles',
        '--work-tree=' .. M.home, 'ls-tree', '--full-tree', '-r',
        '--name-only', 'HEAD'
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

function M.sanitize_binary(path)
    if vim.fn.has('win32') ~= 0 then
        path = path .. '.exe'
    end
    return path
end

function M.on_attach(_, bufnr)
    vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
    M.map('n', 'gd', '<CMD>lua vim.lsp.buf.definition()<CR>')
    M.map('n', 'gr', '<CMD>lua vim.lsp.buf.references()<CR>')
    M.map('n', 'K', '<CMD>lua vim.lsp.buf.hover()<CR>')
    M.map('n', 'gi', '<CMD>lua vim.lsp.buf.implementation()<CR>')
    M.map('n', '<Leader>D', '<CMD>lua vim.lsp.buf.type_definition()<CR>')
    M.map('n', '<Leader>rn', '<CMD>lua vim.lsp.buf.rename()<CR>')
    M.map('n', '<Leader>e', '<CMD>lua vim.diagnostic.open_float(nil, {scope = "line"})<CR>')
    M.map('n', ']d', '<CMD>lua vim.diagnostic.goto_next()<CR>')
    M.map('n', '[d', '<CMD>lua vim.diagnostic.goto_prev()<CR>')
    M.map('n', '<Leader>q', '<CMD>lua vim.diagnostic.set_loclist()<CR>')
    vim.cmd [[
    hi LspDiagnosticsVirtualTextError guifg=red
    hi LspDiagnosticsVirtualTextWarning guifg=orange
    hi LspDiagnosticsVirtualTextInformation guifg=gray
    hi LspDiagnosticsVirtualTextHint guifg=green
    ]]
    require('lsp_signature').on_attach()
end

M.capabilities = vim.lsp.protocol.make_client_capabilities()
M.capabilities = require('cmp_nvim_lsp').update_capabilities(M.capabilities)

return M

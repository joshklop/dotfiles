" Add dein.vim to path so we can find it
set runtimepath+=~/.config/nvim/dein/repos/github.com/Shougo/dein.vim 

let maplocalleader = ';' 

call dein#begin(expand('~/.config/nvim/dein'))

" Non-Lazy Loaded Plugins

call dein#add('Shougo/dein.vim') " Keep dein.vim up to date

call dein#add('Shougo/deoplete.nvim') " Framework for autocompletion plugins

call dein#add('lifepillar/vim-gruvbox8') " Gruvbox colorscheme variant 

call dein#add('tpope/vim-repeat') " Allows the 'dot' command to repeat plugin actions

call dein#add('tpope/vim-surround') " Surround.vim

call dein#add('chaoren/vim-wordmotion') " Enhanced word objects

call dein#add('takac/vim-hardtime') " Stop repeating the basic movement keys

call dein#add('caenrique/nvim-maximize-window-toggle') " Toggle to maximize the current buffer ina new tab and stack

" Lazy Loaded Plugins

call dein#add('chrisbra/csv.vim',
        \{'on_ft': 'csv'}) " Ease handling of csv files

call dein#add('junegunn/fzf.vim',
        \{'on_cmd': ['Files', 'Buffers']}) " fuzzy finder

call dein#add('jalvesaq/nvim-r',
        \{'on_ft': ['r', 'Rmd']}) " R environment

call dein#add('rhysd/reply.vim', {
        \   'lazy' : 1,
        \   'on_cmd' : ['Repl', 'ReplAuto']}) "REPLs play nicely with :terminal in Neovim

call dein#add('sirver/UltiSnips',
        \{'on_ft': ['tex', 'latex', 'python', 'java']}) " Snippet manager

call dein#add('ludovicchabant/vim-gutentags',
        \{'on_ft': ['tex', 'latex', 'python', 'java', 'r']}) " A Vim plugin that manages your tag files

call dein#add('conornewton/vim-pandoc-markdown-preview',
        \{'on_cmd': 'StartMdPreview'}) " Preview Pandoc markdown

call dein#add('lervag/vimtex',
        \{'on_ft': ['tex', 'latex']}) " Amazing LaTex tool

call dein#add('liuchengxu/vista.vim', 
        \{'on_ft': ['tex', 'latex', 'python', 'java', 'r']}) " tagbar for vim

call dein#add('wellle/visual-split.vim',
        \{'on_cmd': ['VSSplit', 'VSSplitAbove', 'VSSplitBelow']}) " Open a selection in a split for reference

" Remove disabled plugins
call map(dein#check_clean(), "delete(v:val, 'rf')")

call dein#end()

""""""""""""""""""
" Plugin Options "
""""""""""""""""""

" csv.vim
let b:csv_arrange_use_all_rows = 1

" dein
let g:dein#auto_recache = 1

" deoplete
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option({'camel_case': v:true,
                        \ 'smart_case': v:true})

" fzf.vim
nnoremap <C-p> :Files<CR>
"nnoremap <C-b> :Buffers<CR>
let g:fzf_colors =
      \ { 'fg':      ['fg', 'Normal'],
      \ 'bg':      ['bg', 'Normal'],
      \ 'hl':      ['fg', 'Comment'],
      \ 'fg+':     ['fg', 'CursorLine'],
      \ 'bg+':     ['bg', 'Normal'],
      \ 'hl+':     ['fg', 'Statement'],
      \ 'info':    ['fg', 'PreProc'],
      \ 'border':  ['fg', 'CursorLine'],
      \ 'prompt':  ['fg', 'Conditional'],
      \ 'pointer': ['fg', 'Exception'],
      \ 'marker':  ['fg', 'Keyword'],
      \ 'spinner': ['fg', 'Label'],
      \ 'header':  ['fg', 'Comment'] }

" gruvbox8
set background=dark
colorscheme gruvbox8_soft
let g:gruvbox_italics = 0
let g:gruvbox_italicize_strings = 0

" nvim-maximize-window-toggle
nnoremap <leader>f :ToggleOnly<CR>

" Nvim-R
let R_nvimpager = 'tab'
let R_assign = 2 
let rout_follow_colorscheme = 1
let Rout_more_colors = 1

" reply.vim
nnoremap <LocalLeader>rf :Repl<CR>
nnoremap <LocalLeader>l :ReplSend<CR>
xnoremap <LocalLeader>ss :ReplSend<CR>
nnoremap <LocalLeader>v :ReplRecv<CR>
xnoremap <LocalLeader>v :ReplRecv<CR>
nnoremap <LocalLeader>rq :ReplStop<CR>

" UltiSnips
inoremap <silent><expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'

" Undotree
nnoremap <Leader>u :UndotreeToggle<CR>

" vim-hardtime
let g:hardtime_default_on = 1
let g:hardtime_showmsg = 1
let g:hardtime_allow_different_key = 1

" vim-pandoc-markdown-preview
let g:md_pdf_viewer = 'okular'

" vimtex
let g:vimtex_enabled = 1
let g:tex_flavor = 'latex'
let g:tex_conceal = 'abdmg'
let g:vimtex_view_general_viewer = 'okular'
let g:vimtex_fold_enabled = 1
set conceallevel=2
nnoremap <Leader>q :cclose<CR>

" vista.vim
nnoremap <Leader>t :Vista!!<CR>
let g:vista_echo_cursor_strategy = 'both'

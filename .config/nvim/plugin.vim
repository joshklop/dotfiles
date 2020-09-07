nnoremap <SPACE> <Nop>
let maplocalleader = " "

" Add dein.vim to path so we can find it
set runtimepath+=~/.config/nvim/dein/repos/github.com/Shougo/dein.vim

call dein#begin(expand('~/.config/nvim/dein'))

call dein#add('Shougo/dein.vim') " Keep dein.vim up to date

call dein#add('Shougo/deoplete.nvim') " Autocomplete framework

call dein#add('lifepillar/vim-gruvbox8') " Gruvbox colorscheme variant

call dein#add('pangloss/vim-javascript',
      \{'on_ft': ['javascript']}) " Javascript syntax highlighting

call dein#add('othree/javascript-libraries-syntax.vim',
      \{'on_ft': ['javascript']})  " Syntax highlighting for JS libraries/frameworks

call dein#add('tpope/vim-repeat') " Allows the 'dot' command to repeat plugin actions

call dein#add('tpope/vim-surround') " Surround.vim

call dein#add('chaoren/vim-wordmotion') " Enhanced word objects

call dein#add('takac/vim-hardtime') " Stop repeating the basic movement keys

call dein#add('mhartington/nvim-typescript',
      \{'build': './install.sh'},
      \{'on_ft': ['typescript']}) " TypeScript plugin
call dein#add('HerringtonDarkholme/yats.vim',
      \{'on_ft': ['typescript']}) " Syntax file for TypeScript (nvim-typescript dependency)

call dein#add('dense-analysis/ale',
        \{'on_ft': ['python', 'javascript', 'typescript']}) " Asynchronous Lint Engine

call dein#add('chrisbra/csv.vim',
        \{'on_ft': 'csv'}) " Ease handling of csv files

call dein#add('junegunn/fzf.vim',
        \{'on_cmd': ['Files', 'Buffers']}) " fuzzy finder

call dein#add('jiangmiao/auto-pairs',
        \{'on_ft': ['javascript', 'typescript']}) " Automaically create matching brace/paren/quote/etc.

call dein#add('jalvesaq/nvim-r',
        \{'on_ft': ['r', 'Rmd']}) " R environment

call dein#add('sirver/UltiSnips',
        \{'on_ft': ['tex', 'latex', 'python', 'java']}) " Snippet manager

call dein#add('jreybert/vimagit') " Ease git workflow

call dein#add('justinmk/vim-sneak') " Improved f/F/t/T

call dein#add('ludovicchabant/vim-gutentags',
        \{'on_ft': ['tex', 'latex', 'python', 'java', 'r']}) " A Vim plugin that manages your tag files

call dein#add('conornewton/vim-pandoc-markdown-preview',
        \{'on_cmd': 'StartMdPreview'}) " Preview Pandoc markdown

call dein#add('lervag/vimtex',
        \{'on_ft': ['tex', 'latex']}) " Amazing LaTex tool

" Remove disabled plugins
call map(dein#check_clean(), "delete(v:val, 'rf')")

call dein#end()

""""""""""""""""""
" Plugin Options "
""""""""""""""""""

" ale
let g:ale_lint_on_text_changed = 'never'
let g:ale_lint_on_enter = 0
let g:lint_on_insert_leave = 1
let g:ale_lint_on_save = 1
let g:ale_linters = {'python': ['flake8']}
let g:ale_lsp_root = {'python': ['flake8']}
nnoremap <LocalLeader>gd :ALEGoToDefinition<CR>
nnoremap <LocalLeader>gr :ALEFindReferences<CR>

" csv.vim
let b:csv_arrange_use_all_rows = 1

" dein
let g:dein#auto_recache = 1

" deoplete
let g:deoplete#enable_at_startup = 1
" call deoplete#custom#option({'camel_case': v:true, 'smart_case': v:true})

" fzf.vim
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
command! -bang -nargs=* Rg
          \ call fzf#vim#grep(
          \   'rg --column --line-number --no-heading --color=always --smart-case '.shellescape(<q-args>), 1,
          \   fzf#vim#with_preview(), <bang>0)
nnoremap <C-s> :Rg<CR>
nnoremap <C-p> :Files<CR>
nnoremap <C-t> :Buffers<CR>

" gruvbox8
set background=dark
colorscheme gruvbox8_soft
let g:gruvbox_italics = 0
let g:gruvbox_italicize_strings = 0

" Netrw
let g:netrw_liststyle = 3
let g:netrw_banner = 0
let g:netrw_browse_split = 4
let g:netrw_altv = 1
let g:netrw_winsize = 15

" Nvim-R
let R_nvimpager = 'tab'
let R_assign = 2
let rout_follow_colorscheme = 1
let Rout_more_colors = 1

" vim-javascript
let g:javascript_plugin_jsdoc = 1
let g:javascript_plugin_ngdoc = 1

" vim-sneak
let g:sneak#label = 1

" UltiSnips
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
inoremap <silent><expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

" vim-hardtime
let g:hardtime_default_on = 1
let g:hardtime_showmsg = 1
let g:hardtime_allow_different_key = 1
let g:list_of_normal_keys = ['h', 'j', 'k', 'l']

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

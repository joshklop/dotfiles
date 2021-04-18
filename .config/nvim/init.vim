" Start Python 3; Disable Python 2 support
let g:python3_host_prog = '/bin/python3'
let g:loaded_python_provider = 0


" Filetype-specific settings
augroup omnifuncs
  autocmd BufNew,BufNewFile,BufRead,BufEnter *.snippets :setfiletype snippets
  autocmd BufNew,BufNewFile,BufRead,BufEnter *.js :setfiletype javascript
  autocmd BufNew,BufNewFile,BufRead,BufEnter *.ts :setfiletype typescript
  autocmd BufNew,BufNewFile,BufRead,BufEnter *.md :setfiletype markdown
  autocmd BufNew,BufNewFile,BufRead,BufEnter *.sol :setfiletype solidity
  autocmd FileType python setlocal colorcolumn=79
  autocmd FileType python let g:keywordprog='pydoc'
  autocmd FileType javascript setlocal colorcolumn=79
  autocmd FileType c setlocal colorcolumn=79
  autocmd FileType c setlocal tabstop=4
  autocmd FileType c setlocal shiftwidth=4
  autocmd FileType cpp setlocal colorcolumn=79
  autocmd FileType solidity setlocal colorcolumn=79
  autocmd FileType solidity setlocal tabstop=4
  autocmd FileType solidity setlocal shiftwidth=4
  autocmd FileType magit setlocal nowrap
"  autocmd FileType Makefile setlocal noexpandtab
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
augroup end


" Tabs, indents
set expandtab
set tabstop=2
set shiftwidth=2
set autoindent
set smartindent
set smarttab
" Command mode
set wildmenu
set noshowmode
" Line numbering
set relativenumber
set nu
" Filetype
filetype on
filetype plugin on
filetype indent on
" Searching
set ignorecase
set smartcase
" Other
set completeopt="menuone,noselect,preview,noinsert"
set hidden
set inccommand=nosplit
set scrolloff=3
set updatetime=100
set nomodeline
set mouse=""
set nowrap
set noswapfile


" Plugins
set runtimepath+=~/.config/nvim/dein/repos/github.com/Shougo/dein.vim
if dein#load_state('~/.config/nvim/dein')
  call dein#begin('~/.config/nvim/dein')
  call dein#add('~/.config/nvim/dein/repos/github.com/Shougo/dein.vim')
  call dein#add('Shougo/deoplete.nvim')
  call dein#add('deoplete-plugins/deoplete-clang', {'on_ft': ['c', 'cpp']})
  call dein#add('junegunn/fzf.vim')
  call dein#add('csexton/trailertrash.vim', {'on_cmd': 'TrailerTrim'})
  call dein#add('lifepillar/vim-gruvbox8')
  " Syntax plugins
  call dein#add('kchmck/vim-coffee-script', {'on_ft': ['coffee']})
  call dein#add('Vimjas/vim-python-pep8-indent', {'on_ft': 'python'})
  call dein#add('vim-python/python-syntax', {'on_ft': 'python'})
  call dein#add('pangloss/vim-javascript', {'on_ft': 'javascript'})
  call dein#add('othree/javascript-libraries-syntax.vim',
    \{'on_ft': 'javascript'})
  call dein#add('mhartington/nvim-typescript',
    \{'build': './install.sh'},
    \{'on_ft': 'typescript'})
  call dein#add('HerringtonDarkholme/yats.vim', {'on_ft': 'typescript'})
  call dein#add('ekalinin/Dockerfile.vim', {'on_ft': 'Dockerfile'})
  call dein#add('arzg/vim-sh', {'on_ft': ['zsh', 'bash', 'sh']})
  call dein#add('tomlion/vim-solidity')
  "
  call dein#add('tpope/vim-repeat')
  call dein#add('tpope/vim-surround')
  call dein#add('chaoren/vim-wordmotion')
  call dein#add('prettier/vim-prettier',
    \{'on_ft': ['javascript', 'typescript', 'json', 'css']})
  call dein#add('dense-analysis/ale',
    \{'on_ft': ['python', 'javascript', 'typescript', 'solidity', 'c', 'cpp']})
  call dein#add('chrisbra/csv.vim', {'on_ft': 'csv'})
  call dein#add('jiangmiao/auto-pairs')
  call dein#add('jalvesaq/nvim-r', {'on_ft': ['r', 'Rmd']})
  call dein#add('sirver/UltiSnips', {'on_ft': ['tex', 'python', 'java']})
  call dein#add('dmdque/solidity.vim', {'on_ft': 'sol'})
  call dein#add('jreybert/vimagit')
  call dein#add('justinmk/vim-sneak')
  call dein#add('ludovicchabant/vim-gutentags',
    \{'on_ft': ['tex', 'python', 'java', 'r', 'javascript', 'typescript', 'c', 'cpp']})
  call dein#add('lervag/vimtex', {'on_ft': 'tex'})
  " Remove disabled plugins
  call map(dein#check_clean(), "delete(v:val, 'rf')")
  call dein#end()
  call dein#save_state()
endif


" Plugin Options
" ale
let g:ale_lint_on_text_changed = 0
let g:ale_lint_on_insert_leave = 0
let g:ale_linters = {
  \'python': ['flake8'],
  \'typescript': ['eslint'],
  \'javascript': ['eslint'],
  \'solidity': ['solc'],
  \'c': ['clang'],
  \'cpp': ['clang'] }
let g:ale_lsp_root = {'python': ['flake8']}
let g:ale_fixers = {
  \'html':['prettier'],
  \'css': ['prettier'],
  \'javascript': ['prettier'],
  \'typescript' : ['prettier'] }
nnoremap <Leader>l :ALEToggle<CR>
nnoremap <Leader>gd :ALEGoToDefinition<CR>
nnoremap <Leader>gr :ALEFindReferences<CR>
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
" csv.vim
let b:csv_arrange_use_all_rows = 1
" dein
let g:dein#auto_recache = 1
" deoplete
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('enable_camel_case', 1 )
call deoplete#custom#var('around', {
	\ 'mark_above': '[↑]',
	\ 'mark_below': '[↓]',
	\ 'mark_changes': '[*]' })
" fzf.vim
let g:fzf_preview_window = ''
let g:fzf_colors = {
  \'fg':      ['fg', 'Normal'],
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
nnoremap <C-m> :Marks<CR>
nnoremap <C-l> :Tags<CR>
" gruvbox8
colorscheme gruvbox8_soft
let g:gruvbox_italics = 0
let g:gruvbox_italicize_strings = 0
syntax enable
set termguicolors
set background=dark
" gutentags
let g:gutentags_ctags_exclude = ['node_modules']
" Nvim-R
let R_nvimpager = 'tab'
let R_assign = 2
let rout_follow_colorscheme = 1
let Rout_more_colors = 1
" TrailerTrim
noremap <Leader>t :TrailerTrim<CR>
" UltiSnips
let g:UltiSnipsExpandTrigger = '<tab>'
let g:UltiSnipsJumpForwardTrigger = '<tab>'
let g:UltiSnipsJumpBackwardTrigger = '<s-tab>'
inoremap <silent><expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
" vim-python
let g:python_version_2 = 0
let b:python_version_2 = 0
let g:python_highlight_indent_errors = 0
let g:python_highlight_space_errors = 0
let g:python_highlight_all = 1
" vim-sneak
let g:sneak#label = 1
" vimtex
let g:vimtex_enabled = 1
let g:tex_flavor = 'latex'
let g:tex_conceal = 'abdmg'
let g:vimtex_view_general_viewer = "zathura"
set conceallevel=2
nnoremap <Leader>q :cclose<CR>


" Keymaps
" LocalLeader
nnoremap <SPACE> <Nop>
let maplocalleader = " "
" Transpose lines and characters
nnoremap <Up> ddkP
nnoremap <Down> ddp
nnoremap <Left> xhP
nnoremap <Right> xp
" Allow easier navigation on broken lines
nnoremap j gj
nnoremap k gk
" Redraw screen
nnoremap <ESC> :nohlsearch<CR>
" Spell-check
nnoremap <F5> :setlocal spell! spelllang=en_us<CR>
" Terminal Mode Keybindings "
tnoremap <Esc> <C-\><C-n>
tnoremap <expr> <C-R> '<C-\><C-n>"'.nr2char(getchar()).'pi' " Simlulate CTRL-R
" Easier Window Navigation
noremap <A-h> <C-w>h
noremap <A-j> <C-w>j
noremap <A-k> <C-w>k
noremap <A-l> <C-w>l
noremap <C-w>t :tabnew<CR>
nnoremap <C-w>s :split<CR>
nnoremap <C-w><A-s> :split<CR>
nnoremap <C-w>v :vsplit<CR>
nnoremap <C-w><A-v> :vsplit<CR>
" Compile C program
nnoremap <LocalLeader>c :!gcc -g %; ./a.out<CR>

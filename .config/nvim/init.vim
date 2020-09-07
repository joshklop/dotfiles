" Start Python 3; Disable Python 2 support
let g:python3_host_prog = '/bin/python3'
let g:loaded_python_provider = 0

" Load plugins
source $HOME/.config/nvim/plugin.vim

" Filetype-specific settings
augroup omnifuncs
  autocmd BufNew,BufNewFile,BufRead,BufEnter *.snippets :setfiletype snippets
  autocmd BufNew,BufNewFile,BufRead,BufEnter *.js :setfiletype javascript
  autocmd BufNew,BufNewFile,BufRead,BufEnter *.ts :setfiletype typescript
  autocmd BufNew,BufNewFile,BufRead,BufEnter *.md :setfiletype markdown
  autocmd FileType magit setlocal nowrap
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
augroup end

" General Settings

set termguicolors
set inccommand=nosplit
set nomodeline
set nocompatible
set expandtab
set tabstop=2
set shiftwidth=2
set autoindent
set smartindent
set smarttab
filetype on
filetype plugin on
filetype indent on
syntax on
set wildmenu
set so=3
set ignorecase
set incsearch
set mouse=""
set nowrap
set relativenumber
set nu
set tildeop

" Key Mappings

"Move a line up
nnoremap <Up> ddkP 
"Move a line down
nnoremap <Down> ddp
"Move a character left
nnoremap <Left> xhP
"Move a character right
nnoremap <Right> xp

" Allow easier navigation on broken lines
nnoremap j gj
nnoremap k gk

" Map ESC to redraw the screen
nnoremap <ESC> :noh<CR>

" Spell-check set to F6
nnoremap <F6> :setlocal spell! spelllang=en_us<CR>

" Terminal Mode Keybindings "
tnoremap <Esc> <C-\><C-n>
tnoremap <expr> <C-R> '<C-\><C-n>"'.nr2char(getchar()).'pi' " Simlulate CTRL-R

" Easier Window Navigation
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
tnoremap <C-w>t :tabnew<CR>
inoremap <A-h> <C-\><C-n><C-w>h
inoremap <A-j> <C-\><C-n><C-w>j
inoremap <A-k> <C-\><C-n><C-w>k
inoremap <A-l> <C-\><C-n><C-w>l
inoremap <C-w>t :tabnew<CR>
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
nnoremap <C-w>t :tabnew<CR>
nnoremap <C-w>s :split<CR>
nnoremap <C-w><A-s> :split<CR>
nnoremap <C-w>v :vsplit<CR>
nnoremap <C-w><A-v> :vsplit<CR>

" Completion settings
set complete=".,w,b,u,t"
set completeopt="menuone,preview,noinsert"

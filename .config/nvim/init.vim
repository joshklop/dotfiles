" Python 3 (setting this makes startup faster)
let g:python3_host_prog = '/bin/python3'

" Load plugins
source $HOME/.config/nvim/plugin.vim

""""""""""""""""""""
" General Settings "
""""""""""""""""""""

" Disable modelines (security vulneratibility)
set nomodeline

" Don't try to emulate vi, use all neovim features
set nocompatible

" Convert tabs to spaces
set expandtab

" Enable auto indent
set autoindent

" Enable filetype-specific indentation
filetype plugin indent on

" Enable syntax highlighting (should be specified after filetype plugin indent on)
syntax on

" Enhanced tab completion in command mode
set wildmenu

" Keeps cursor off the edges of the screen
set so=3

" Do not show mode changes in x-mode
set noshowmode

" Case insensitive searches
set ignorecase

" Disable mouse support
set mouse=""

set nowrap

set relativenumber
set number nu

""""""""""""""""
" Key Mappings "
""""""""""""""""

" Turn recording off
nnoremap q <Nop>

" Remap the arrow keys
"Move a line up
nnoremap <Up> ddkP
"Move a line down
nnoremap <Down> ddp
"Move a character left in normal mode
nnoremap <Left> xhP
"Move a character right in normal mode
nnoremap <Right> xp

" Allows easier navigation on broken lines
nnoremap j gj
nnoremap k gk

" Maps Ctrl-C to redraw the screen
nnoremap <C-c> :nohlsearch<CR>

" Spell-check set to F6
nnoremap <F6> :setlocal spell! spelllang=en_us<CR>

" Run pythontex
nnoremap <LocalLeader>p :!pythontex %<CR>

" Terminal Mode Keybindings "
tnoremap <Esc> <C-\><C-n>
tnoremap <expr> <C-R> '<C-\><C-n>"'.nr2char(getchar()).'pi' " Simlulate CTRL-R

" Easier Window Navigation
tnoremap <A-h> <C-\><C-n><C-w>h
tnoremap <A-j> <C-\><C-n><C-w>j
tnoremap <A-k> <C-\><C-n><C-w>k
tnoremap <A-l> <C-\><C-n><C-w>l
inoremap <A-h> <C-\><C-n><C-w>h
inoremap <A-j> <C-\><C-n><C-w>j
inoremap <A-k> <C-\><C-n><C-w>k
inoremap <A-l> <C-\><C-n><C-w>l
nnoremap <A-h> <C-w>h
nnoremap <A-j> <C-w>j
nnoremap <A-k> <C-w>k
nnoremap <A-l> <C-w>l
nnoremap <A-w>t :tabnew<CR>
nnoremap <A-w><A-t> :tabnew<CR>
nnoremap <A-w>s :split<CR>
nnoremap <A-w><A-s> :split<CR>
nnoremap <A-w>v :vsplit<CR>
nnoremap <A-w><A-v> :vsplit<CR>


" Python 3 (setting this makes startup faster)
let g:python3_host_prog = '/bin/python3'

" Add shortcut to nvim directory so we can access it quickly
let $NVIM='/home/josh/.config/nvim'

" Load plugins
source $NVIM/plugin.vim

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

let maplocalleader = ';' 

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

" Easier window navigation
nnoremap <C-h> <C-W><C-h>
nnoremap <C-j> <C-W><C-j>
nnoremap <C-k> <C-W><C-k>
nnoremap <C-l> <C-W><C-l>
nnoremap <C-q> <C-W><C-q>
nnoremap <C-w>t :tabnew<CR>
nnoremap <C-w><C-t> :tabnew<CR>
nnoremap <C-w>s :split<CR>
nnoremap <C-w><C-s> :split<CR>
nnoremap <C-w>v :vsplit<CR>
nnoremap <C-w><C-v> :vsplit<CR>

" Maps Ctrl-C to redraw the screen
nnoremap <C-c> :nohlsearch<CR>

" Spell-check set to F6
nnoremap <F6> :setlocal spell! spelllang=en_us<CR>

" Run pythontex
nnoremap <LocalLeader>p :!pythontex %<CR>

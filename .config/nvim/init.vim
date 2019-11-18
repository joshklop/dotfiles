" Python 3 (setting this makes startup faster)
let g:python3_host_prog = '/bin/python3'

" Load plugins
source /home/josh/.config/nvim/plugins/plugin.vim

""""""""""""""""""""
" General Settings "
""""""""""""""""""""

" Disable modelines (security vulneratibility)
set nomodeline

" Don't try to emulate vi, use all neovim features
set nocompatible

" Convert tabs to spaces
set expandtab

" Enable filetype-specific indentation
filetype plugin indent on

" Enable syntax highlighting (should be specified after filetype plugin indent on)
syntax on

" Enable auto indent
set autoindent

" Enhanced tab completion in command mode
set wildmenu

" Keeps cursor off the edges of the screen
set so=3

" Do not show mode changes in x-mode
set noshowmode

" Case insensitive searches
set ignorecase

" Use gruvbox8 colorscheme
set background=dark
colorscheme gruvbox8

" Disable mouse support
set mouse=""

" Do not wrap lines
set nowrap

set relativenumber

""""""""""""""""
" Key Mappings "
""""""""""""""""

" Remap localleader
let maplocalleader = ";" 

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
nnoremap <c-c> :nohlsearch<CR>

" Spell-check set to F6
nnoremap <F6> :setlocal spell! spelllang=en_us<CR>

" Inkscape shortcuts
inoremap <C-f> <Esc>: silent exec '.!inkscape-figures create "'.getline('.').'" "'.b:vimtex.root.'/figures/"'<CR><CR>:w<CR>
nnoremap <C-f> : silent exec '!inkscape-figures edit "'.b:vimtex.root.'/figures/" > /dev/null 2>&1 &'<CR><CR>:redraw!<CR>

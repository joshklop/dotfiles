" Add dein.vim to path so we can find it
set runtimepath+=~/.config/nvim/dein/repos/github.com/Shougo/dein.vim 

call dein#begin(expand('~/.config/nvim/dein'))

call dein#add('Shougo/dein.vim') " Keep dein.vim up to date

" Plugins
call dein#add('Shougo/deoplete.nvim') " Framework for autocompletion plugins

call dein#add('Shougo/echodoc.vim', 
        \{'on_ft': ['python', 'r', 'java']}) " Echodoc. Dispalys function signatures.

call dein#add('ahonn/vim-fileheader',
        \{'on_cmd': ['AddFileHeader', 'UpdateFileHeader']}) " Add/update file header

call dein#add('jalvesaq/nvim-r',
        \{'on_ft': ['r', 'Rmd']}) " R environment

call dein#add('tpope/vim-surround') " Surround.vim

call dein#add('sirver/UltiSnips',
        \{'on_ft': ['tex', 'python', 'java']}) " Snippet manager

call dein#add('junegunn/goyo.vim') " Distraction-free writing in Vim

call dein#add('chrisbra/csv.vim',
        \{'on_ft': ['csv']}) " Ease handling of csv files

call dein#add('lifepillar/vim-gruvbox8') " Gruvbox colorscheme variant 

call dein#add('lifepillar/vim-cheat40') " Vim cheat sheet

call dein#add('lervag/vimtex',
        \{'on_ft': ['tex', 'latex']}) " Amazing LaTex tool

call dein#add('ekiim/vim-mathpix',
        \{'on_ft': ['tex', 'latex']},
        \{'on_cmd': ['Img2Latex', 'Img2Text']}) " Take screenshot of pdf and paste the LateX code!

call dein#add('chaoren/vim-wordmotion') " Enhanced word objects

"""""""""""""""
" Considering "
"""""""""""""""
"call dein#add('iago-lito/intim',
"        \{'on_ft': 'python'}) " Interactively interface Vim with interpreters
" mbbill/undotree Shows the undos in a tree for you!
" Yilin-Yang/vim-markbar Tagbar for marks!
" neovimhaskell/haskell-vim
" liuchengxu/vista.vim Possible tagbar replacement

" Remove disabled plugins
call map(dein#check_clean(), "delete(v:val, 'rf')")

call dein#end()


""""""""""""""""""
" Plugin Options "
""""""""""""""""""


"""""""""""
" cheat40 "
"""""""""""
let g:cheat40_use_default = 0

""""""""
" dein "
""""""""
let g:dein#auto_recache = 1

""""""""""""
" deoplete "
""""""""""""
let g:deoplete#enable_at_startup = 1
let g:deoplete#enable_camel_case = 1
let g:deoplete#enable_smart_case = 1

"""""""""""""""
" echodoc.vim "
"""""""""""""""
let g:echodoc#enable_at_startup = 1

""""""""""""""
" Fileheader "
""""""""""""""
let g:fileheader_author = 'Josh Klopfenstein'
let g:fileheader_default_email = 'joshklop10@gmail.com'

""""""""""""
" gruvbox8 "
""""""""""""
let g:gruvbox_italics = 0
let g:gruvbox_italicize_strings = 0

"""""""""
" intim "
"""""""""
"let g:intim_terminal = "xfce4-terminal"

""""""""""
" Nvim-R "
""""""""""
let R_nvimpager = 'tab'
let R_assign = 2 
let rout_follow_colorscheme = 1
let Rout_more_colors = 1

"""""""""""""""
"  UltiSnips  "
"""""""""""""""
inoremap <silent><expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

""""""""""
" vimtex "
""""""""""
let g:vimtex_enabled = 1
let g:tex_flavor = 'latex'
let g:tex_conceal="abdmg"
let g:vimtex_view_general_viewer = 'okular'
set conceallevel=2
nnoremap <Leader>q :cclose<CR>

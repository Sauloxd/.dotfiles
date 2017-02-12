" Welcome to the Saulo's Script!
set number
set numberwidth=1

:let mapleader = "\<Space>"
:let maplocalleader = "\\"

" MAPPINGs

:noremap <leader>\ :NERDTreeToggle<CR>
:noremap <leader>j :wincmd j<cr>
:noremap <leader>h :wincmd h<cr>
:noremap <leader>k :wincmd k<cr>
:noremap <leader>l :wincmd l<cr>

" Normal Mappings

:nnoremap <leader>ev :vsplit $MYVIMRC<cr>
:nnoremap <leader>sv :source $MYVIMRC<cr>

"Abbreviations

:iabbrev @@    saulotoshi@gmail.com

" Colors Scheme
set background=dark
colorscheme quantum







"My Plugins

call plug#begin()

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'pangloss/vim-javascript'

call plug#end()

"NERDTree
"Copied from github

autocmd vimenter * NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

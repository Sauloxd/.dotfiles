" Welcome to the Saulo's Script!
set number
set numberwidth=1
set ruler
set wrap
set textwidth=79
set formatoptions=tcqrn1
set tabstop=2
set shiftwidth=2
set softtabstop=2
set expandtab
set noshiftround
set scrolloff=3
set ttyfast
set laststatus=2
set showmode
set showcmd
set listchars=tab:▸\ ,eol:¬
syntax on

let mapleader = "\<Space>"
let maplocalleader = "\\"

" MAPPINGs
noremap <F10> :NERDTreeToggle<cr>
noremap <leader>\ :NERDTreeFind<cr>
noremap <leader>j :wincmd j<cr>
noremap <leader>h :wincmd h<cr>
noremap <leader>k :wincmd k<cr>
noremap <leader>l :wincmd l<cr>
noremap <leader><s-j> gT
noremap <leader><s-k> gt
" Visual Mappings
vnoremap <F1> :set invfullscreen<CR>
" Normal Mappings
nnoremap j gj
nnoremap k gk
nnoremap <F1> :set invfullscreen<CR>
nnoremap <leader>ev :vsplit $MYVIMRC<cr>
nnoremap <leader>sv :source $MYVIMRC<cr>
" Inser Mappings
inoremap <F1> <ESC>:set invfullscreen<CR>a

"Abbreviations

iabbrev @@    saulotoshi@gmail.com

" Colors Scheme
set background=dark
colorscheme quantum






      
"My Plugins

call plug#begin()

Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'pangloss/vim-javascript'
Plug 'ervandew/screen'

call plug#end()

"NERDTree
"Copied from github

autocmd vimenter * NERDTree
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif

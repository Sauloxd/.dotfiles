""ch Vim-PLug core
"*****************************************************************************
"
"* Call Plug *"
call plug#begin()

call plug#end()

set backspace=indent,eol,start " Fix backspace indent
set encoding=UTF-8 " Encoding for vim devicons
let mapleader="\<Space>" " Map leader to ,
set hidden " Enable hidden buffers
set nobackup "" Directories for swp files
set fileformats=unix,dos,mac
set shell=/bin/zsh
set mouse=a " Enable Mouse on Nvim per Default

syntax on
syntax enable
filetype plugin indent on

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

"*****************************************************************************
"" Vanilla Configs
"*****************************************************************************
noremap Q @q

"" Window
noremap <Leader>ws :<C-u>split<CR> :wincmd w<cr>
noremap <Leader>wv :<C-u>vsplit<CR> :wincmd w<cr>

"" Search/Find
set hlsearch    " When CR
set incsearch   " As you type
set ignorecase  " Search ignores Case
set smartcase   " But if you Uppercase something, it will be case sensitive
nnoremap <silent> <leader>sf /<C-R><C-W><CR>N
nnoremap <silent> <leader>sp :Ag

vnoremap YY "+y<CR>
vnoremap XX "+x<CR>
if has('macunix')
" pbcopy for OSX copy/paste
  vnoremap <C-x> :!pbcopy<CR>
  vnoremap <C-c> :w !pbcopy<CR><CR>
endif

"" Vmap for maintain Visual Mode after shifting > and <
vnoremap < <gv
vnoremap > >gv
"" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" VIMRC
noremap <Leader>ev :vsplit ~/.dotfiles/vim/.vimrc<cr>
noremap <Leader>sv :so ~/.dotfiles/vim/.vimrc<cr>

" Move up/down editor lines
nnoremap j gj
nnoremap k gk

" Override All generated config above
set number
set relativenumber
set numberwidth=1
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
set listchars=tab:‚ñ∏\ ,eol:¬¨
set noswapfile
set textwidth=80
set wrapmargin=2

tnoremap <Esc> <C-\><C-n>

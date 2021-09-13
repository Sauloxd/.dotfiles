" Vim-PLug core
"*****************************************************************************
"
"* Call Plug *"
call plug#begin()
Plug 'w0rp/ale' " Async lint checker
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'albfan/nerdtree-git-plugin' " Show M/A/D for tracked files
Plug 'jistr/vim-nerdtree-tabs' " ?
Plug 'scrooloose/nerdtree' " Nerd Tree
Plug 'bronson/vim-trailing-whitespace' " Remove trailing whitespace on save
Plug 'mhinz/vim-startify' " Starting buffer with happy cow
Plug 'simeji/winresizer' " c-e for window resize
" Plug 'maralla/completor.vim' " Contextual completor
" Plug 'Valloric/YouCompleteMe', { 'do': './install.py --tern-completer' }
Plug 'ervandew/supertab' " magical tabj
" Plug 'marijnh/tern_for_vim'
Plug 'tpope/vim-commentary' " ?
Plug 'tpope/vim-fugitive' " Git power on vim
Plug 'tpope/vim-surround' " ysaw' y surround around word '
Plug 'christoomey/vim-tmux-navigator' " ?
Plug 'vim-airline/vim-airline' " bottom toolbar
Plug 'vim-airline/vim-airline-themes' " schemes
Plug 'hail2u/vim-css3-syntax'
Plug 'isRuslan/vim-es6'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
" Plug 'jelera/vim-javascript-syntax'
Plug 'sheerun/vim-polyglot'
Plug 'maksimr/vim-jsbeautify'
Plug 'leshill/vim-json'
Plug 'terryma/vim-multiple-cursors'
Plug 'Sauloxd/nerdtree-template-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
" Plug 'easymotion/vim-easymotion'
Plug 'crusoexia/vim-dracula'
call plug#end()


"*****************************************************************************
"" YCM from: https://medium.com/@rahul11061995/autocomplete-in-vim-for-js-developer-698c6275e341
"*****************************************************************************"
"" Start autocompletion after 4 chars
let g:ycm_min_num_of_chars_for_completion = 4
let g:ycm_min_num_identifier_candidate_chars = 4
let g:ycm_enable_diagnostic_highlighting = 0
" Don't show YCM's preview window [ I find it really annoying ]
set completeopt-=preview
let g:ycm_add_preview_to_completeopt = 0

" https://vi.stackexchange.com/questions/16156/neovim-youcompleteme-python-completion-not-working
let g:ycm_python_binary_path = 'python'

" Fuck neovim, to use YCM use this: https://gist.github.com/jottr/e32d976a5bc4f52a55f4d9f18a11d5cb
"*****************************************************************************
"" Basic Setup
"*****************************************************************************"
" Tern setup
let g:tern#command = ['/Users/sauloxd/.nvm/versions/node/v10.13.0/bin/node', '/Users/sauloxd/.config/nvim/plugged/tern_for_vim/node_modules/.bin/tern', '--no-port-file']

"" Fix backspace indent
set backspace=indent,eol,start

" Encoding for vim devicons
set encoding=UTF-8

"" Map leader to ,
let mapleader="\<Space>"

"" Enable hidden buffers
set hidden

"" Directories for swp files
set nobackup

set fileformats=unix,dos,mac
set shell=/bin/zsh

" Enable Mouse on Nvim per Default
set mouse=a

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

" colorscheme palenight
colorscheme dracula
let g:dracula_italic = 1
" set t_Co=256
" if (has("termguicolors"))
"   set termguicolors
"  endif
"
"*****************************************************************************
"" YCM - from: https://medium.com/@rahul11061995/autocomplete-in-vim-for-js-developer-698c6275e341
"*****************************************************************************
let g:ycm_min_num_of_chars_for_completion = 4
let g:ycm_min_num_identifier_candidate_chars = 4
let g:ycm_enable_diagnostic_highlighting = 0
" Don't show YCM's preview window [ I find it really annoying ]
set completeopt-=preview
let g:ycm_add_preview_to_completeopt = 0

"*****************************************************************************
"" Syntax
"*****************************************************************************

syntax on
syntax enable
augroup filetypedetect javascript syntax=javascript
let g:javascript_plugin_jsdoc = 1
filetype plugin indent on

let g:ale_linters = { 'javascript': ['eslint'], 'jsx': ['eslint'] }
" closeTag
" filenames like *.xml, *.html, *.xhtml, ...
let g:closetag_filenames = '*.html,*.xhtml,*.phtml'
" filenames like *.xml, *.xhtml, ...
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.ejs'

"" NERDTree configuration
let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeWinSize = 30
let g:NERDTreeShowHidden=1
let NERDTreeShowLineNumbers=1
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite,*/node_modules/*
nnoremap <silent> <F3> :NERDTreeFind<CR>
nnoremap <silent> <F4> :NERDTreeToggle<CR>
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

set autoread
set autowrite
set autowriteall

"*****************************************************************************
"" Mappings
"*****************************************************************************
"" HIDEKI
noremap Q @q

"" Split
noremap <Leader><S-d> :<C-u>split<CR> :wincmd w<cr>
noremap <Leader>d :<C-u>vsplit<CR> :wincmd w<cr>


"" Buffers
nnoremap <S-Tab> :bn<CR>
nnoremap <silent> <S-t> :vnew <CR>
nnoremap <leader>c :bp <BAR> bd #<CR>

" FZF
" CTRL-A CTRL-Q to select all and build quickfix list
"
function! s:build_quickfix_list(lines)
	call setqflist(map(copy(a:lines), '{ "filename": v:val }'))
	copen
	cc
endfunction

let g:fzf_action = {
			\ 'ctrl-q': function('s:build_quickfix_list'),
			\ 'ctrl-t': 'tab split',
			\ 'ctrl-x': 'split',
			\ 'ctrl-v': 'vsplit' }

let $FZF_DEFAULT_OPTS = '--bind ctrl-a:select-all'
noremap <leader>p :FZF<CR>
noremap <leader>b :Buffers<CR>

"*****************************************************************************
"" Search/Find
"*****************************************************************************

set hlsearch    " When CR
set incsearch   " As you type
set ignorecase  " Search ignores Case
set smartcase   " But if you Uppercase something, it will be case sensitive
nnoremap <silent> <leader>f /<C-R><C-W><CR>N
nnoremap <silent> <leader>g :Ag
nnoremap <silent> <leader><leader> :nohlsearch<cr>

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
noremap <Leader>ev :vsplit ~/.dotfiles/vim/init.vim<cr>
noremap <Leader>sv :so ~/.dotfiles/vim/init.vim<cr>

" Move up/down editor lines
nnoremap j gj
nnoremap k gk

" Strong Moves
nnoremap L $
nnoremap H 0

"*****************************************************************************
"" Custom configs
"*****************************************************************************

let g:airline#extensions#ale#enabled = 1

set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\

set t_Co=256
let g:airline_theme = 'powerlineish'
let g:airline#extensions#ale#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline_skip_empty_sections = 1
" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'

if !exists('g:airline_symbols')
let g:airline_symbols = {}
endif

let g:airline_powerline_fonts = 1

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
set listchars=tab:▸\ ,eol:¬
set noswapfile
set textwidth=80
set wrapmargin=2

au BufNewFile,BufRead *.ejs set filetype=html
let g:jsx_ext_required = 0

set completeopt=longest,menuone,preview

" For Templates plugin
let g:TEMPLATES_BASE_PATH = '~/.dotfiles/templates'

" Stop mf auto wrapping
set textwidth=0 wrapmargin=0

tnoremap <Esc> <C-\><C-n>

set guifont=Dank\ Mono:h14

" easymotion

nmap s <Plug>(easymotion-s)

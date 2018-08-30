"*****************************************************************************
"" Vim-PLug core
"*****************************************************************************

"* Call Plug *"
call plug#begin()
  function! BuildYCM(info)
    if a:info.status == 'installed' || a:info.force
      !./install.sh --tern-completer
    endif
  endfunction

  function! BuildTern(info)
    if a:info.status == 'installed' || a:info.force
      !npm install
    endif
  endfunction

Plug 'w0rp/ale' " Async lint checker

Plug 'kien/ctrlp.vim' " Fuzzy finder for files
Plug 'vim-scripts/grep.vim' " ?

Plug 'albfan/nerdtree-git-plugin' " Show M/A/D for tracked files
Plug 'jistr/vim-nerdtree-tabs' " ?
Plug 'scrooloose/nerdtree' " Nerd Tree

Plug 'bronson/vim-trailing-whitespace' " Remove trailing whitespace on save
Plug 'junegunn/vim-easy-align' "gaip=
Plug 'mhinz/vim-startify' " Starting buffer with happy cow
Plug 'simeji/winresizer' " c-e for window resize
Plug 'sjl/gundo.vim' " Undo your shit
Plug 'ternjs/tern_for_vim', { 'do': function('BuildTern') } " ?
Plug 'maralla/completor.vim' " Contextual completor
Plug 'ervandew/supertab' " magical tabj
Plug 'tpope/vim-commentary' " ?
Plug 'tpope/vim-fugitive' " Git power on vim
Plug 'tpope/vim-surround' " ysaw' y surround around word '
Plug 'christoomey/vim-tmux-navigator' " ?

" Airline
Plug 'vim-airline/vim-airline' " bottom toolbar
Plug 'vim-airline/vim-airline-themes' " schemes

" Color scheme
Plug 'morhetz/gruvbox'

" Syntax enhancer
Plug 'hail2u/vim-css3-syntax'
Plug 'jelera/vim-javascript-syntax'
Plug 'sheerun/vim-polyglot'
Plug 'maksimr/vim-jsbeautify'
Plug 'leshill/vim-json'
" Plug 'mxw/vim-jsx' " polyglot already usees this and pangloss
" Plug 'pangloss/vim-javascript'

" For easy snippets
Plug 'mattn/emmet-vim'
Plug 'MarcWeber/vim-addon-mw-utils'
Plug 'tomtom/tlib_vim'
Plug 'garbas/vim-snipmate'
Plug 'grvcoelho/vim-javascript-snippets'

Plug 'honza/vim-snippets'
call plug#end()

"*****************************************************************************
"" Basic Setup
"*****************************************************************************"
"" Fix backspace indent
set backspace=indent,eol,start

"" Map leader to ,
let mapleader="\<Space>"

"" Enable hidden buffers
set hidden

"" Searching
set hlsearch    " When CR
set incsearch   " As you type
set ignorecase  " Search ignores Case
set smartcase   " But if you Uppercase something, it will be case sensitive

"" Directories for swp files
set nobackup

set fileformats=unix,dos,mac
set shell=/bin/zsh

" session management
let g:session_directory = "~/.vim/session"
let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1

" Enable Mouse on Nvim per Default
set mouse=a

"*****************************************************************************
"" Visual Settings
"*****************************************************************************
colorscheme gruvbox
let g:gruvbox_termcolors = '256'
let $NVIM_TUI_ENABLE_TRUE_COLOR=1
set background=dark

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

"*****************************************************************************
"" Syntax
"*****************************************************************************

syntax on
syntax enable
let g:javascript_plugin_jsdoc = 1
filetype plugin indent on

let g:ale_linters = {'javascript': ['eslint']}
" closeTag
" filenames like *.xml, *.html, *.xhtml, ...
let g:closetag_filenames = '*.html,*.xhtml,*.phtml'
" filenames like *.xml, *.xhtml, ...
let g:closetag_xhtml_filenames = '*.xhtml,*.jsx,*.ejs'

"
"*****************************************************************************
"" Abbreviations
"*****************************************************************************
inoreabbrev jsdoc /**<cr>📄📄📄📄📄📄📄📄📄📄<cr>@param {object} param.name - param.description<cr>@param {object} param.name - param.description<cr>@return {number} return.description<cr><backspace>*/<cr>
inoremap \fn <C-R>=expand("%:t:r")<CR>

abbrev :W :w
abbrev :Q :q

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

" grep.vim
nnoremap <silent> <leader>f /<C-R><C-W><CR>N
nnoremap <silent> <leader><S-f> :Rgrep<CR>
let Grep_Default_Options = '-IR'
let Grep_Skip_Files = '*.log *.db'
let Grep_Skip_Dirs = '.git node_modules'

"*****************************************************************************
"" Autocmd Rules
"*****************************************************************************
"" The PC is fast enough, do syntax highlight syncing from start unless 200 lines
augroup vimrc-sync-fromstart
  autocmd!
  autocmd BufEnter * :syntax sync maxlines=200
augroup END

"" Remember cursor position
augroup vimrc-remember-cursor-position
  autocmd!
  autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
augroup END

set autoread
set autowrite
set autowriteall

"*****************************************************************************
"" Mappings
"*****************************************************************************
"" HIDEKI
noremap <leader>z :GundoToggle<cr>
inoremap jk <esc>
inoremap kj <esc>
noremap Q @q

"" Clear CTRLP cache
map <leader>C :CtrlPClearCache<cr>

"" Split
noremap <Leader><S-d> :<C-u>split<CR> :wincmd w<cr>
noremap <Leader>d :<C-u>vsplit<CR> :wincmd w<cr>

"" Git
noremap <Leader>ga :Gwrite<CR>
noremap <Leader>gc :Gcommit<CR>
noremap <Leader>gsh :Gpush<CR>
noremap <Leader>gll :Gpull<CR>
noremap <Leader>gs :Gstatus<CR>
noremap <Leader>gb :Gblame<CR>
noremap <Leader>gd :Gvdiff<CR>
noremap <Leader>gr :Gremove<CR>

" session management
nnoremap <leader>so :OpenSession<Space>
nnoremap <leader>ss :SaveSession<Space>
nnoremap <leader>sd :DeleteSession<CR>
nnoremap <leader>sc :Clo3eSessionder<CR>

"" Buffers
nnoremap <S-Tab> :bn<CR>
nnoremap <silent> <S-t> :vnew <CR>
nnoremap <leader>c :bp <BAR> bd #<CR>

"" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>

"" ctrlp.vim
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist|vendor|db|public)|(\.(swp|tox|ico|git|hg|svn))$'
let g:ctrlp_user_command = "find %s -type f | grep -Ev '"+ g:ctrlp_custom_ignore +"'"
let g:ctrlp_use_caching = 1

noremap <leader>b :CtrlPBuffer<CR>
noremap <leader><s-p> :CtrlP<CR>
noremap <leader>p :CtrlPCurWD<CR>
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'

noremap YY "+y<CR>
noremap XX "+x<CR>
if $TMUX == ''
  set clipboard+=unnamed
endif

if has('macunix')
" pbcopy for OSX copy/paste
vnoremap <C-x> :!pbcopy<CR>
vnoremap <C-c> :w !pbcopy<CR><CR>
endif

"" Buffer nav  @TODO Change to work with tabs
noremap <leader>w :tabnext<CR>
noremap <leader>q :tabprevious<CR>

"" Close buffer

"" Clean search (highlight)
nnoremap <silent> <leader><space> :nohlsearch<cr>

"" Vmap for maintain Visual Mode after shifting > and <
vnoremap < <gv
vnoremap > >gv
"" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

" VIMRC
noremap <Leader>ev :vsplit $MYVIMRC<cr>
noremap <Leader>sv :so $MYVIMRC<cr>

" Move up/down editor lines
nnoremap j gj
nnoremap k gk

" Strong Moves
nnoremap L $
nnoremap H 0
nnoremap K /<C-R><C-W><CR>N
" nnoremap K :call smooth_scroll#up(1, 0, 1)<CR>
" nnoremap J :call smooth_scroll#down(1, 0, 1)<CR>

"*****************************************************************************
"" Custom configs
"*****************************************************************************


" vim-airline
" vim: et ts=2 sts=2 sw=2

" let s:error_symbol = get(g:, 'airline#extensions#ale#error_symbol', 'E:')
" let s:warning_symbol = get(g:, 'airline#extensions#ale#warning_symbol', 'W:')
"
let g:airline#extensions#ale#enabled = 1

" function! s:airline_ale_count(cnt, symbol)
"   return a:cnt ? a:symbol. a:cnt : ''
" endfunction

" function! airline#extensions#ale#get(type)
"   if !exists(':ALELint')
"     return ''
"   endif

"   let is_err = a:type ==# 'error'
"   let symbol = is_err ? s:error_symbol : s:warning_symbol

"   let is_err = a:type ==# 'error'
"   let counts = ale#statusline#Count(bufnr(''))
"   let symbol = is_err ? s:error_symbol : s:warning_symbol

"   if type(counts) == type({}) && has_key(counts, 'error')
"     " Use the current Dictionary format.
"     let errors = counts.error + counts.style_error
"     let num = is_err ? errors : counts.total - errors
"   else
"     " Use the old List format.
"     let num = is_err ? counts[0] : counts[1]
"   endif

"   return s:airline_ale_count(num, symbol)
" endfunction

" function! airline#extensions#ale#get_warning()
"   return airline#extensions#ale#get('warning')
" endfunction

" function! airline#extensions#ale#get_error()
"   return airline#extensions#ale#get('error')
" endfunction

" function! airline#extensions#ale#init(ext)
"   call airline#parts#define_function('ale_error_count', 'airline#extensions#ale#get_error')
"   call airline#parts#define_function('ale_warning_count', 'airline#extensions#ale#get_warning')
" endfunction

" let g:ale_sign_error = 'E'
" let g:ale_sign_warning = 'W'
" let g:ale_lint_delay = 500

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

if !exists('g:airline_powerline_fonts')
let g:airline#extensions#tabline#left_sep = ' '
let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_left_sep          = '▶'
let g:airline_left_alt_sep      = '»'
let g:airline_right_sep         = '◀'
let g:airline_right_alt_sep     = '«'
let g:airline#extensions#branch#prefix     = '⤴' "➔, ➥, ⎇
let g:airline#extensions#readonly#symbol   = '⊘'
let g:airline#extensions#linecolumn#prefix = '¶'
let g:airline#extensions#paste#symbol      = 'ρ'
let g:airline_symbols.linenr    = '␊'
let g:airline_symbols.branch    = '⎇'
let g:airline_symbols.paste     = 'ρ'
let g:airline_symbols.paste     = 'Þ'
let g:airline_symbols.paste     = '∥'
let g:airline_symbols.whitespace = 'Ξ'
else
let g:airline#extensions#tabline#left_sep = ''
let g:airline#extensions#tabline#left_alt_sep = ''

" powerline symbols
let g:airline_left_sep = ''
let g:airline_ltft_alt_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = ''
endif


" Override All generated config above
set number
" set relativenumber
set numberwidth=1
set ruler
set textwidth=200
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
set noswapfile
set textwidth=80
set wrapmargin=2

"removes trailing spaces

" noremap <Leader>p :CtrlP<CR>

au BufNewFile,BufRead *.ejs set filetype=html
let g:jsx_ext_required = 0

set completeopt=longest,menuone,preview

" Completor
" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> pumvisible() ? "\<C-y>\<cr>" : "\<cr>"
let g:completor_auto_trigger = 0
" inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<C-x>\<C-u>\<C-p>"
let g:completor_node_binary = '/usr/local/bin/node'

augroup vim-enter
  autocmd!
  autocmd VimEnter *
              \   if !argc()
              \ |   Startify
              \ |   NERDTree
              \ |   wincmd w
              \ | endif


" QR maps
inoreabbrev ictrl import controller from './0';<esc>F0xi<C-R>=expand("%:t:r")<CR>.ctrl.js
inoreabbrev itmpl import templateUrl from './0';<esc>F0xi<C-R>=expand("%:t:r")<CR>.slim
inoreabbrev inj 'ngInject';

nnoremap <space>ls /__\=\.<cr>
nnoremap <space>ll /__\=\.<cr>elywggO<esc>p``
nnoremap <space>li 0iimport <esc>lywea from 'lodash/<esc>pa';<esc>j
nnoremap <space>di 0iimport <esc>lv$y$a from '<esc>i./<esc>pa';<esc>j

" Create component
let g:componentFormula="import templateUrl from \'\';"

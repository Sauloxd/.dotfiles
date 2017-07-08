"*****************************************************************************
"
"" Vim-PLug core
"*****************************************************************************

if has('vim_starting')
  set nocompatible               " Be iMproved
endif

let vimplug_exists=expand('~/.config/nvim/autoload/plug.vim')

let g:make = 'gmake'
if exists('make')
  let g:make = 'make'
endif

"* Call Plug *"
call plug#begin(expand('~/.config/nvim/plugged'))
" ---- NerdTree ----
Plug 'scrooloose/nerdtree'
Plug 'albfan/nerdtree-git-plugin'
" ---- Nerdtree tab is same in all tab ----
Plug 'jistr/vim-nerdtree-tabs'
" ---- gc -> comment shit
Plug 'tpope/vim-commentary'
" ---- Git blame ----
Plug 'tpope/vim-fugitive'
" ---- CTRL P ----
Plug 'ctrlpvim/ctrlp.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" ---- GREP
Plug 'vim-scripts/grep.vim'
Plug 'bronson/vim-trailing-whitespace'
Plug 'Raimondi/delimitMate'
" should make this work
Plug 'majutsushi/tagbar'
" ---- Thin Line
" Plug 'Yggdroot/indentLine'
" language pack
Plug 'sheerun/vim-polyglot'
Plug 'simeji/winresizer'
" ---- Delete
Plug 'tpope/vim-surround'
Plug 'jelera/vim-javascript-syntax'
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
Plug 'nathanaelkane/vim-indent-guides'
Plug 'digitaltoad/vim-pug'
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'ervandew/supertab'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'ternjs/tern_for_vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'carlitux/deoplete-ternjs', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'othree/jspc.vim', { 'for': ['javascript', 'javascript.jsx'] }
Plug 'Shougo/vimproc.vim', {'do': g:make}
Plug 'xolox/vim-misc'
Plug 'xolox/vim-session'
Plug 'honza/vim-snippets'
Plug 'hail2u/vim-css3-syntax'
Plug 'gorodinskiy/vim-coloresque'
Plug 'tpope/vim-haml'
Plug 'mattn/emmet-vim'
Plug 'jelera/vim-javascript-syntax'
Plug 'maksimr/vim-jsbeautify'
Plug 'heavenshell/vim-jsdoc'
Plug 'mhinz/vim-startify'
Plug 'dracula/vim'
Plug 'junegunn/vim-easy-align'
Plug 'w0rp/ale'

call plug#end()

"*****************************************************************************
"" Enable dots as empty Spaces
"*****************************************************************************"
let g:indent_guides_enable_on_vim_startup = 1

filetype plugin indent on
"*****************************************************************************
"" Basic Setup
"*****************************************************************************"
"" Encoding
set encoding=utf-8
set fileencoding=utf-8
set fileencodings=utf-8
set bomb
set binary


"" Fix backspace indent
set backspace=indent,eol,start

"" Map leader to ,
let mapleader="\<Space>"

"" Enable hidden buffers
set hidden

"" Searching
set hlsearch
set incsearch
set ignorecase
set smartcase

"" Directories for swp files
set nobackup

set fileformats=unix,dos,mac
set shell=/bin/sh

" session management
let g:session_directory = "~/.config/nvim/session"
let g:session_autoload = "no"
let g:session_autosave = "no"
let g:session_command_aliases = 1

"*****************************************************************************
"" Visual Settings
"*****************************************************************************
syntax on
colorscheme dracula
set mousemodel=popup
set t_Co=256
set guioptions=egmrti
set gfn=Monospace\ 10

"" Disable the blinking cursor.
set gcr=a:blinkon0
set scrolloff=3

"" Status bar

"" Use modeline overrides
set modeline
set modelines=10

set title
set titleold="Terminal"
set titlestring=%F

set statusline=%F%m%r%h%w%=(%{&ff}/%Y)\ (line\ %l\/%L,\ col\ %c)\

" Search mappings: These will make it so that going to the next one in a
" search will center on the line it's found in.
nnoremap n nzzzv
nnoremap N Nzzzv

if exists("*fugitive#statusline")
  set statusline+=%{fugitive#statusline()}
endif

" vim-airline
let g:airline_theme = 'powerlineish'
let g:airline#extensions#ale#enabled = 1
" let g:airline#extensions#syntastic#enabled = 1
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
let g:airline_skip_empty_sections = 1

"*****************************************************************************
"" Abbreviations
"*****************************************************************************
"" no one is really happy until you have this shortcuts
cnoreabbrev W! w!
cnoreabbrev Q! q!
cnoreabbrev Qall! qall!
cnoreabbrev Wq wq
cnoreabbrev Wa wa
cnoreabbrev wQ wq
cnoreabbrev WQ wq
cnoreabbrev W w
cnoreabbrev Q q
cnoreabbrev Qall qall

"For Inser mode

"" NERDTree configuration
let g:NERDTreeChDirMode=2
let g:NERDTreeIgnore=['\.rbc$', '\~$', '\.pyc$', '\.db$', '\.sqlite$', '__pycache__']
let g:NERDTreeSortOrder=['^__\.py$', '\/$', '*', '\.swp$', '\.bak$', '\~$']
let g:NERDTreeShowBookmarks=1
let g:nerdtree_tabs_focus_on_files=1
let g:NERDTreeMapOpenInTabSilent = '<RightMouse>'
let g:NERDTreeWinSize = 30
set wildignore+=*/tmp/*,*.so,*.swp,*.zip,*.pyc,*.db,*.sqlite,*/node_modules/*
nnoremap <silent> <F3> :NERDTreeFind<CR>

" grep.vim
nnoremap <silent> <leader>f :Rgrep<CR>
let Grep_Default_Options = '-IR'
let Grep_Skip_Files = '*.log *.db'
let Grep_Skip_Dirs = '.git node_modules'

"*****************************************************************************
"" Functions
"*****************************************************************************
" if !exists('*s:setupWrapping')
"   function s:setupWrapping()
"     set wrap
"     set wm=2
"     set textwidth=79
"   endfunction
" endif

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

"" txt
" augroup vimrc-wrapping
"   autocmd!
"   autocmd BufRead,BufNewFile *.txt call s:setupWrapping()
" augroup END

"" make/cmake
augroup vimrc-make-cmake
  autocmd!
  autocmd FileType make setlocal noexpandtab
  autocmd BufNewFile,BufRead CMakeLists.txt setlocal filetype=cmake
augroup END

set autoread

"*****************************************************************************
"" Mappings
"*****************************************************************************
nnoremap <Leader>sv :source $MYVIMRC<cr>

"" Navigating in panes
noremap <F1> :wincmd w<cr>
inoremap <F1> <Esc>:wincmd w<cr>
noremap <F2> <Esc>:wincmd W<cr>
inoremap <F2> <Esc>:wincmd W<cr>

tnoremap <F1> <C-\><C-n>:wincmd w<cr>
tnoremap <F2> <C-\><C-n>:wincmd W<cr>

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

"" Tabs
nnoremap <Tab> :bn<CR>
nnoremap <S-Tab> :bp<CR>
nnoremap <silent> <S-t> :tabnew<CR>

"" Set working directory
nnoremap <leader>. :lcd %:p:h<CR>

"" ctrlp.vim
set wildmode=list:longest,list:full
set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
let g:ctrlp_custom_ignore = '\v[\/](node_modules|target|dist)|(\.(swp|tox|ico|git|hg|svn))$'
let g:ctrlp_user_command = "find %s -type f | grep -Ev '"+ g:ctrlp_custom_ignore +"'"
let g:ctrlp_use_caching = 1

" The Silver Searcher
if executable('ag')
set grepprg=ag\ --nogroup\ --nocolor
let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'
let g:ctrlp_use_caching = 0
endif

" bind \ (backward slash) to grep shortcut
command -nargs=+ -complete=file -bar Ag silent! grep! <args>|cwindow|redraw!
nnoremap \ :Ag<SPACE>

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" bind ] to grep word under cursor
nnoremap <leader>k /<C-R><C-W><CR>

cnoremap <C-P> <C-R>=expand("%:p:h") . "/" <CR>
noremap <leader>b :CtrlPBuffer<CR>
let g:ctrlp_map = '<leader>e'
let g:ctrlp_open_new_file = 'r'
let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'

" snippets
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<c-b>"
let g:UltiSnipsEditSplit="vertical"

" " syntastic
" let g:syntastic_always_populate_loc_list=1
" let g:syntastic_error_symbol='✗'
" let g:syntastic_warning_symbol='⚠'
" let g:syntastic_style_error_symbol = '✗'
" let g:syntastic_style_warning_symbol = '⚠'
" let g:syntastic_auto_loc_list=1
" let g:syntastic_aggregate_errors = 1
" nnoremap <F12> :SyntasticToggleMode<CR>
" Tagbar
nmap <silent> <F4> :TagbarToggle<CR>
let g:tagbar_autofocus = 1

" Disable visualbell
set noerrorbells visualbell t_vb=
if has('autocmd')
autocmd GUIEnter * set visualbell t_vb=
endif

"" Copy/Paste/Cut
if has('unnamedplus')
set clipboard=unnamed,unnamedplus
endif

noremap YY "+y<CR>
noremap <leader>v "+gP<CR>
noremap XX "+x<CR>

if has('macunix')
" pbcopy for OSX copy/paste
vmap <C-x> :!pbcopy<CR>
vmap <C-c> :w !pbcopy<CR><CR>
endif

"" Buffer nav
noremap <leader>z :bp<CR>
noremap <leader>q :bp<CR>
noremap <leader>x :bn<CR>
noremap <leader>w :bn<CR>

"" Close buffer
noremap <leader>c :bp\|bd # <CR>

"" Clean search (highlight)
nnoremap <silent> <leader><space> :noh<cr>

"" Vmap for maintain Visual Mode after shifting > and <
vmap < <gv
vmap > >gv

"" Move visual block
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

"" Open current line on GitHub
nnoremap <Leader>o :.Gbrowse<CR>

"*****************************************************************************
"" Custom configs
"*****************************************************************************

" html
" for html files, 2 spaces
autocmd Filetype html setlocal ts=2 sw=2 expandtab


" javascript
let g:javascript_enable_domhtmlcss = 1

" vim-javascript

"autocmd vimenter * NERDTree
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | endif
let NERDTreeShowHidden=1


"*****************************************************************************
"*****************************************************************************

"" Include user's local vim config
if filereadable(expand("~/.config/nvim/local_init.vim"))
source ~/.config/nvim/local_init.vim
endif

"*****************************************************************************
"" Convenience variables
"*****************************************************************************

" vim-airline
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
set numberwidth=1
set ruler
" set wrap
" set textwidth=79
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
syntax on

"removes trailing spaces
if !exists("*TrimWhiteSpace")
function TrimWhiteSpace()
%s/\s*$//
%s/\//
''
endfunction
endif

noremap <Leader>p :CtrlP<CR>
map <F7> :call TrimWhiteSpace()<CR>
map! <F7> :call TrimWhiteSpace()<CR>

au BufNewFile,BufRead *.ejs set filetype=html

let g:ctrlp_buffer_func = { 'enter': 'MyCtrlPMappings' }

func! MyCtrlPMappings()
nnoremap <buffer> <silent> <c-@> :call <sid>DeleteBuffer()<cr>
endfunc

func! s:DeleteBuffer()
let line = getline('.')
let bufid = line =~ '\[\d\+\*No Name\]$' ? str2nr(matchstr(line, '\d\+'))
		\ : fnamemodify(line[2:], ':p')
exec "bd" bufid
exec "norm \<F5>"
endfunc

let &colorcolumn=join(range(81,81),",")
highlight ColorColumn ctermbg=235 guibg=#2c2d27

map 890 :e $MYVIMRC <cr>
map 098 :so $MYVIMRC <cr>
"JSX on JS files
let g:jsx_ext_required = 0

" Move up/down editor lines
nnoremap j gj
nnoremap k gk

let g:fixmyjs_rc_path = '~/.eslintrc.js'
set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_loc_list_height = 5
" let g:syntastic_auto_loc_list = 0
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 1
" let g:syntastic_javascript_checkers = ['eslint']
"let g:syntastic_error_symbol = '<U+e74C>'
"let g:syntastic_style_error_symbol = '⁉️'
"let g:syntastic_warning_symbol = '⚠️'
"let g:syntastic_style_warning_symbol = '<U+1F4A9>'
" highlight link SyntasticErrorSign SignColumn
" highlight link SyntasticWarningSign SignColumn
" highlight link SyntasticStyleErrorSign SignColumn
" highlight link SyntasticStyleWarningSign SignColumn

let g:deoplete#enable_at_startup = 1

let g:deoplete#omni#functions = {}
let g:deoplete#omni#functions.javascript = [
\ 'tern#Complete',
\ 'jspc#omni'
\]

set completeopt=longest,menuone,preview
let g:deoplete#sources = {}
let g:deoplete#sources['javascript.jsx'] = ['file', 'ultisnips', 'ternjs']
let g:tern#command = ['tern']
let g:tern#arguments = ['--persistent']

set foldmethod=syntax
set foldnestmax=1
set foldlevel=1

noremap <Leader>r :TernDef<CR>
set completeopt-=preview
vnoremap // y/<C-R>"<CR>

noremap <leader>t :<C-u>split<CR> :wincmd w<cr> :terminal <cr>

autocmd VimEnter *
            \   if !argc()
            \ |   Startify
            \ |   NERDTree
            \ |   wincmd w
            \ | endif

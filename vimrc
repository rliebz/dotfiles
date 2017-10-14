" Set utf-8 as standard encoding and en_US as the standard language
set encoding=utf-8
scriptencoding utf-8

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Sets how many lines of history VIM has to remember
set history=500

" Include plugins
call plug#begin('~/.vim/plugged')

" General purpose plugins
Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/BufOnly.vim'
Plug 'w0rp/ale'
Plug 'wellle/targets.vim'
Plug 'Yggdroot/indentLine'

" Language-specific plugins
Plug 'elzr/vim-json', { 'for': 'json' }
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'hashivim/vim-terraform'
Plug 'hdima/python-syntax', { 'for': 'python' }
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'leafgarland/typescript-vim', { 'for': 'typescript' }
Plug 'Quramy/tsuquyomi', { 'for': 'typescript' }
Plug 'cespare/vim-toml', { 'for': 'toml' }

call plug#end()

" Set to auto read when a file is changed from the outside
set autoread

" Reduce updatetime from default 4 seconds
set updatetime=250

" With a map leader it's possible to do extra key combinations
" like <leader>w saves the current file
let g:mapleader = ','

" Fast reload vimrc
nmap <leader>v :source ~/.vimrc<cr>

" Fast saving
nmap <leader>w :w!<cr>

" :W sudo saves the file
command! W w !sudo tee % > /dev/null

" Autocomplete
set completeopt=menuone
inoremap <C-Space> <C-x><C-o>
imap <C-@> <C-Space>
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<C-g>u\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<C-g>u\<S-Tab>"
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ale
let g:ale_sign_error = '>>'
let g:ale_sign_warning = '>>'

" ale: Status-line options
let g:ale_echo_msg_format = '[%linter%]: %s'

" ale: Language-specific options
let g:ale_linters = {
      \'go': ['gometalinter'],
      \'typescript': ['prettier', 'tslint', 'tsserver'],
      \}
let g:ale_go_metalinter_options = '--fast'

" ctrlp
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlP'
let g:ctrlp_user_command = [
      \'.git/',
      \'git --git-dir=%s/.git ls-files -oc --exclude-standard',
      \]

" indentLine: Enable leading spaces
let g:indentLine_enabled = 0
let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_leadingSpaceChar = '·'
let g:indentLine_color_term = 8

" lightline
let g:lightline = { 'colorscheme': 'dots' }

" python-syntax: Highlight python commands
let g:python_highlight_all = 1

" gitgutter: Always show sign column
set signcolumn=yes

" tsuquyomi: Let ale do the linting
let g:tsuquyomi_disable_quickfix = 1

" vim-commentary: Custom mappings
map <leader>c gc

" vim-go: Avoid conflicts with syntastic
let g:go_fmt_fail_silently = 1
let g:go_list_type = 'quickfix'
let g:go_fmt_command = 'goimports'

" vim-json
let g:vim_json_syntax_conceal = 0


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Language-specific settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:markdown_fenced_languages = [
      \'html', 'python', 'go', 'javascript', 'bash=sh', 'yaml',
      \]


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

" Set number of lines to the cursor - when moving vertically using j/k
set scrolloff=5

" Avoid garbled characters in Chinese language windows OS
let $LANG='en'
set langmenu=en
source $VIMRUNTIME/delmenu.vim
source $VIMRUNTIME/menu.vim

" Don't open preview window
set completeopt-=preview

" Turn on the WiLd menu
set wildmenu

" Ignore compiled files
set wildignore=*.o,*~,*.pyc
if has('win16') || has('win32')
    set wildignore+=*/.git/*,*/.hg/*,*/.svn/*,*/.DS_Store
else
    set wildignore+=.git\*,.hg\*,.svn\*
endif

"Always show current position
set ruler

" Height of the command bar
set cmdheight=2

" A buffer becomes hidden when it is abandoned
set hidden

" Configure backspace so it acts as it should act
set backspace=eol,start,indent
set whichwrap+=<,>,h,l

" Ignore case when searching
set ignorecase

" When searching try to be smart about cases
set smartcase

" Don't highlight search results
set nohlsearch

" Perform searches after each character press
set incsearch

" Don't redraw while executing macros (good performance config)
set lazyredraw

" For regular expressions turn magic on
set magic

" Show matching brackets when text indicator is over them
set showmatch

" How many tenths of a second to blink when matching brackets
set matchtime=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set timeoutlen=500

" Show line numbers in left margin
set number

" Show right margin
set colorcolumn=80


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Colors and Fonts
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Enable syntax highlighting
if !exists('g:syntax_on')
  syntax enable
endif

try
    colorscheme dots
catch
endtry

set background=dark
highlight Normal ctermfg=none ctermbg=none

" Use Unix as the standard file type
set fileformats=unix,dos,mac

" Show whitespace
set list
set listchars=tab:»\ ,trail:·,nbsp:·


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git et.c anyway...
set nobackup
set nowritebackup
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Use spaces instead of tabs
set expandtab

" Be smart when using tabs
set smarttab

" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

augroup filetypedetect
    au BufRead,BufNewFile Jenkinsfile set filetype=groovy
augroup END

" Linebreak on 500 characters
set linebreak
set textwidth=500

set autoindent
set smartindent
set wrap


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Visual mode related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Visual mode pressing * or # searches for the current selection
vnoremap <silent> * :call VisualSelection('f', '')<CR>
vnoremap <silent> # :call VisualSelection('b', '')<CR>


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Netrw
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Easy way to open file explorer
map <leader>e :Explore<cr>

let g:netrw_banner = 0
let g:netrw_list_hide = '\.DS_Store,\.git,\.gitmodules'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Treat long lines as break lines
map j gj
map k gk

" Disable highlight when <leader><cr> is pressed
map <silent> <leader><cr> :noh<cr>

" Smart way to move between windows
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l

" Buffer navigation
map <leader>bf :bfirst<cr>
map <leader>bn :bnext<cr>
map <leader>bp :bprevious<cr>
map <leader>bd :bdelete<cr>
map <leader>bo :BufOnly<cr>
map <leader>ba :bufdo bdelete<cr>

" Tab navigation
map <leader>te :tabedit<cr>
map <leader>to :tabonly<cr>
map <leader>tc :tabclose<cr>
map <leader>tn :tabnext<cr>
map <leader>tp :tabprevious<cr>
map <leader>tm :tabmove

" Opens a new tab with the current buffer's path
map <leader>te :tabedit <c-r>=expand("%:p:h")<cr>/

" Switch CWD to the directory of the open buffer
map <leader>cd :cd %:p:h<cr>:pwd<cr>

" Specify the behavior when switching between buffers
set switchbuf=useopen,usetab,vsplit
set showtabline=1

" Close preview window
map <leader>pc :pclose<cr>

" Return to last edit position when opening files (You want this!)
augroup lastedit
  autocmd BufReadPost *
        \ if &filetype != "gitcommit" && line("'\"") > 0
        \     && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
augroup END
" Remember info about open buffers on close
set viminfo^=%


""""""""""""""""""""""""""""""
" => Status line
""""""""""""""""""""""""""""""
" Always show the status line
set laststatus=2

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Editing mappings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remap VIM 0 to first non-blank character
map 0 ^

" Move a line of text using ALT+[jk] or Comamnd+[jk] on mac
nmap <M-j> mz:m+<cr>`z
nmap <M-k> mz:m-2<cr>`z
vmap <M-j> :m'>+<cr>`<my`>mzgv`yo`z
vmap <M-k> :m'<-2<cr>`>my`<mzgv`yo`z

if has('mac') || has('macunix')
  nmap <D-j> <M-j>
  nmap <D-k> <M-k>
  vmap <D-j> <M-j>
  vmap <D-k> <M-k>
endif


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Remove the Windows ^M - when the encodings gets messed up
noremap <Leader>m mmHmt:%s/<C-V><cr>//ge<cr>'tzt'm

" Toggle paste mode
map <leader>pp :setlocal paste!<cr>

" Toggle spell checking
map <leader>ss :setlocal spell!<cr>

" Local config
if filereadable($HOME . '/.vimrc.local')
  source ~/.vimrc.local
endif

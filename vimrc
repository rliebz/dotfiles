set encoding=utf-8

" Temporary python3.7 fix: https://github.com/vim/vim/issues/3117
if has('python3')
  silent! python3 1
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Include plugins
call plug#begin('~/.vim/plugged')

" General purpose plugins
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'airblade/vim-gitgutter'
Plug 'itchyny/lightline.vim'
Plug 'janko-m/vim-test'
Plug 'sgur/vim-editorconfig'
Plug 'Shougo/denite.nvim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/BufOnly.vim'
Plug 'w0rp/ale'
Plug 'wellle/targets.vim'
Plug 'Yggdroot/indentLine'

" Language-specific plugins
Plug 'ekalinin/Dockerfile.vim'
Plug 'pangloss/vim-javascript', { 'for': 'javascript' }
Plug 'elzr/vim-json'
Plug 'fatih/vim-go', { 'for': 'go' }
Plug 'tpope/vim-markdown', { 'for': 'markdown' }
Plug 'hdima/python-syntax', { 'for': 'python' }
Plug 'rust-lang/rust.vim', { 'for': 'rust' }
Plug 'hashivim/vim-terraform'
Plug 'leafgarland/typescript-vim', { 'for': ['typescript', 'markdown'] }
Plug 'cespare/vim-toml', { 'for': 'toml' }

call plug#end()

" How many lines of history to remember
set history=200

" Set to auto read when a file is changed from the outside
set autoread

" Reduce updatetime from default 4 seconds
set updatetime=250

" Set leader as space
map <space> <nop>
let g:mapleader = ' '

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

" Variables
let s:gutter_info_char = '●'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" ale
let g:ale_fix_on_save = 1
nmap <silent> <leader>an :ALENext<CR>
nmap <silent> <leader>ap :ALEPrevious<CR>
nmap <silent> <leader>ad :ALEDetail<CR>

" ale: Style
let g:ale_sign_error = s:gutter_info_char
let g:ale_sign_warning = s:gutter_info_char
let g:ale_echo_msg_format = '[%linter%%: code%] %s'

" ale: Language-specific options
let g:ale_linter_aliases = {
      \'docker-compose': ['yaml'],
      \}
let g:ale_linters = {
      \'go': ['gometalinter'],
      \'typescript': ['prettier', 'tslint', 'tsserver'],
      \}
let g:ale_fixers = {
      \'typescript': ['prettier'],
      \}
let g:ale_go_metalinter_options = '--fast'

" denite
call denite#custom#var('file/rec', 'command',
      \ ['rg', '--hidden', '--files', '--glob', '!.git'])
call denite#custom#var('grep', 'command', ['rg'])
call denite#custom#var('grep', 'default_opts',
      \ ['--hidden', '--vimgrep', '--no-heading', '-S'])
call denite#custom#var('grep', 'recursive_opts', [])
call denite#custom#var('grep', 'pattern_opt', ['--regexp'])
call denite#custom#var('grep', 'separator', ['--'])
call denite#custom#var('grep', 'final_opts', [])
call denite#custom#map(
      \ 'insert',
      \ '<C-j>',
      \ '<denite:move_to_next_line>',
      \ 'noremap'
      \)
call denite#custom#map(
      \ 'insert',
      \ '<C-k>',
      \ '<denite:move_to_previous_line>',
      \ 'noremap'
      \)
nnoremap <C-p> :<C-u>Denite file/rec<CR>
nnoremap <C-f> :<C-u>Denite grep:. -mode=normal<CR>

" gitgutter
nmap <silent> <leader>gn :GitGutterNextHunk<CR>
nmap <silent> <leader>gp :GitGutterPrevHunk<CR>

" indentLine: Enable leading spaces
let g:indentLine_enabled = 0
let g:indentLine_leadingSpaceEnabled = 1
let g:indentLine_leadingSpaceChar = '·'
let g:indentLine_color_term = 8

" lightline
let g:lightline = {
    \ 'colorscheme': 'dots',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'readonly', 'relativepath', 'modified' ] ]
    \ }
    \ }

" python-syntax: Highlight python commands
let g:python_highlight_all = 1

" gitgutter: Always show sign column
if exists('&signcolumn')
  set signcolumn=yes
else
  let g:gitgutter_sign_column_always = 1
endif

" test
nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ts :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>

" vim-commentary: Custom mappings
map <leader>c gc

" vim-commentary: Language settings
augroup vim_commentary_settings
  autocmd!
  autocmd FileType markdown setlocal commentstring=<!--%s-->
augroup END

" vim-go: Avoid conflicts with syntastic
let g:go_fmt_fail_silently = 1

" vim-go: Various settings
let g:go_list_type = 'quickfix'
let g:go_fmt_command = 'goimports'

augroup VimGo
  autocmd!
  autocmd FileType go nmap <silent> <buffer> <F2> <Plug>(go-rename)
augroup END

" vim-json
let g:vim_json_syntax_conceal = 0

" LanguageClient-neovim
let g:LanguageClient_serverCommands = {
      \ 'sh': ['bash-language-server', 'start'],
      \ 'css': ['css-languageserver', '--stdio'],
      \ 'less': ['css-languageserver', '--stdio'],
      \ 'scss': ['css-languageserver', '--stdio'],
      \ 'javascript': ['javascript-typescript-stdio'],
      \ 'typescript': ['javascript-typescript-stdio'],
      \ 'python': ['pyls'],
      \ 'rust': ['rustup', 'run', 'stable', 'rls'],
      \ }

augroup LanguageClient
  autocmd!

  autocmd FileType sh,css,less,scss,javascript,typescript,rust call s:ConfigureLanguageClientBuffer()
  function! s:ConfigureLanguageClientBuffer()
    nnoremap <silent> <buffer> K :call LanguageClient#textDocument_hover()<CR>
    nnoremap <silent> <buffer> <C-]> :call LanguageClient#textDocument_definition()<CR>
    nnoremap <silent> <buffer> <F2> :call LanguageClient#textDocument_rename()<CR>
  endfunction

augroup END


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Language-specific settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:markdown_syntax_conceal = 0
let g:markdown_fenced_languages = [
      \'html', 'python', 'go', 'javascript', 'bash=sh', 'typescript', 'yaml',
      \]


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => VIM user interface
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Fix backspace behavior
set backspace=indent,eol,start

" Always show the status line
set laststatus=2

" Set number of lines to the cursor - when moving vertically using j/k
set scrolloff=5

" Turn on the WiLd menu
set wildmenu

" When searching try to be smart about cases
set ignorecase
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
" Turn backup off, since most stuff is in git anyway
set nobackup
set nowritebackup
set noswapfile


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Text, tab and indent related
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 1 tab == 4 spaces
set shiftwidth=4
set tabstop=4

augroup file_type_detect
  autocmd!
  autocmd BufRead,BufNewFile Jenkinsfile set filetype=groovy
augroup END

set textwidth=80

set autoindent
set smartindent
set wrap


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

" Buffer navigation
map <leader>bf :bfirst<cr>
map <leader>bn :bnext<cr>
map <leader>bp :bprevious<cr>
map <leader>bd :bdelete<cr>
map <leader>bo :BufOnly<cr>
map <leader>ba :bufdo bdelete<cr>

" Specify the behavior when switching between buffers
set hidden
set switchbuf=useopen,vsplit
set showtabline=1

" Close help window
map <leader>hc :helpclose<cr>

" Close preview window
map <leader>pc :pclose<cr>

" Close quickfix window
map <leader>qc :cclose<cr>

" Return to last edit position when opening files
augroup last_edit
  autocmd!
  autocmd BufReadPost *
        \ if &filetype != "gitcommit" && line("'\"") > 0
        \     && line("'\"") <= line("$") |
        \   exe "normal! g`\"" |
        \ endif
augroup END
" Remember info about open buffers on close
set viminfo^=%


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Toggle paste mode
map <leader>pp :setlocal paste!<cr>

" Toggle spell checking
map <leader>ss :setlocal spell!<cr>

" Local config
if filereadable($HOME . '/.vimrc.local')
  source ~/.vimrc.local
endif

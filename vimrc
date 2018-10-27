set encoding=utf-8

" python3.7 fix: https://github.com/vim/vim/issues/3117
if has('python3') && !has('patch-8.1.201')
  silent! python3 1
endif

" Leader
map <space> <nop>
let g:mapleader = ' '

" Multi-Purpose Variables
let s:gutter_info_char = '●'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Include plugins
call plug#begin('~/.vim/plugged')

" General purpose plugins
Plug 'airblade/vim-gitgutter'
Plug 'dyng/ctrlsf.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'itchyny/lightline.vim'
Plug 'janko-m/vim-test'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'markonm/traces.vim'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'vim-scripts/BufOnly.vim'
Plug 'w0rp/ale'
Plug 'wellle/targets.vim'
Plug 'Yggdroot/indentLine'

" Language-specific plugins
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-markdown'
Plug 'fatih/vim-go', { 'for': 'go' }

call plug#end()

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
      \'go': ['golangci-lint'],
      \'javascript': ['eslint'],
      \'markdown': ['mdl', 'prettier'],
      \'rust': ['rls'],
      \'typescript': ['prettier', 'tslint', 'tsserver'],
      \}
let g:ale_fixers = {
      \'markdown': ['prettier'],
      \'rust': ['rustfmt'],
      \'typescript': ['prettier'],
      \}
let g:ale_go_golangci_lint_options = ''
let g:ale_go_golangci_lint_package = 1
let g:ale_rust_rls_toolchain = 'stable'

" ctrlsf
if executable('rg')
  let g:ctrlsf_ackprg = 'rg'
endif
let g:ctrlsf_extra_backend_args = {
      \ 'rg': '
      \   --hidden
      \   --glob !.git/*
      \   --glob !*.min.js
      \   --glob !*.js.map
      \ ',
      \ }
let g:ctrlsf_auto_focus = { 'at': 'start' }
let g:ctrlsf_confirm_save = 0
nnoremap <C-F> <nop>
nmap     <C-F>f <Plug>CtrlSFPrompt
nnoremap <C-F>o :CtrlSFOpen<CR>
nnoremap <C-F>t :CtrlSFToggle<CR>

" fzf
nnoremap <C-P> :FZF<CR>
let g:fzf_layout = { 'down': 15 }
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
endif

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
let g:go_highlight_operators = 1
let g:go_list_type = 'quickfix'
let g:go_fmt_command = 'goimports'

augroup VimGo
  autocmd!
  autocmd FileType go nmap <silent> <buffer> <F2> <Plug>(go-rename)
augroup END

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
let g:LanguageClient_diagnosticsEnable = 0

augroup LanguageClient
  autocmd!
  autocmd FileType sh,css,less,scss,javascript,typescript,rust call s:ConfigureLanguageClientBuffer()
  function! s:ConfigureLanguageClientBuffer()
    nnoremap <silent> <buffer> K :call LanguageClient#textDocument_hover()<CR>
    nnoremap <silent> <buffer> <C-]> :call LanguageClient#textDocument_definition()<CR>
    nnoremap <silent> <buffer> <F2> :call LanguageClient#textDocument_rename()<CR>
  endfunction
augroup END

" vim-markdown
let g:polyglot_disabled = ['markdown']
let g:markdown_syntax_conceal = 0
let g:markdown_fenced_languages = [
      \'bash=sh', 'sh',
      \'html',
      \'javascript', 'js=javascript',
      \'typescript', 'ts=typescript',
      \'go',
      \'python',
      \'json', 'toml', 'yaml',
      \]


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set autoread
set colorcolumn=80
set cursorline
set history=1000
set laststatus=2
set lazyredraw
set magic
set number
set scrolloff=5
set wildmenu
set wrap

" Better timeouts
set timeoutlen=500  " From 1000
set updatetime=250  " From 4000

" Indentation
set autoindent
set smartindent

" Fix backspace behavior
set backspace=indent,eol,start

" Delete comment character when joining commented lines
if v:version > 703 || v:version == 703 && has("patch541")
  set formatoptions+=j
endif

" Search options
set ignorecase
set smartcase
set nohlsearch
set incsearch

" Show matching brackets when text indicator is over them
set showmatch
set matchtime=2

" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=

" Turn backup off
set nobackup
set nowritebackup
set noswapfile

" Autocomplete
set completeopt=menuone
inoremap <C-Space> <C-x><C-o>
imap <C-@> <C-Space>
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<C-g>u\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<C-g>u\<S-Tab>"
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"


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
" => Netrw
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Easy way to open file explorer
map <leader>e :Explore<cr>

let g:netrw_banner = 0
let g:netrw_list_hide = '\.DS_Store,\.git/,\.gitmodules'


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

" Window-closing shortcuts
map <leader>hc :helpclose<cr>
map <leader>pc :pclose<cr>
map <leader>qc :cclose<cr>

" Return to last edit position when opening files
augroup lastEdit
  autocmd!
  autocmd BufReadPost *
        \ if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit'
        \ |   exe "normal! g`\""
        \ | endif
augroup END


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Misc
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Reload vimrc
nmap <leader>v :source ~/.vimrc<cr>

" Fast writes
nmap <leader>w :w!<cr>

" Write with `sudo`
command! W w !sudo tee % > /dev/null

" Toggle paste mode
map <leader>pp :setlocal paste!<cr>

" Toggle spell checking
map <leader>ss :setlocal spell!<cr>

" Local config
if filereadable($HOME . '/.vimrc.local')
  source ~/.vimrc.local
endif

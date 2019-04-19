scriptencoding utf-8

" Leader
map <space> <nop>
let g:mapleader = ' '

" Multi-Purpose Variables
let s:gutter_info_char = '●'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Plugins
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/plugged')

" General purpose plugins
Plug 'airblade/vim-gitgutter'
Plug 'AndrewRadev/splitjoin.vim'
Plug 'dyng/ctrlsf.vim'
Plug 'editorconfig/editorconfig-vim'
Plug 'itchyny/lightline.vim'
Plug 'janko-m/vim-test'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'markonm/traces.vim'
Plug 'romainl/vim-cool'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'
  Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'w0rp/ale'
Plug 'wellle/targets.vim'

Plug 'ncm2/ncm2' | Plug 'roxma/nvim-yarp'

" Language-specific plugins
Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }
Plug 'fatih/vim-go'
Plug 'jvirtanen/vim-hcl'
Plug 'hashivim/vim-hashicorp-tools'
" polyglot can cause issues if not plugged last
Plug 'sheerun/vim-polyglot'
let g:polyglot_disabled = ['go', 'markdown']
let g:jsx_ext_required = 1

call plug#end()

" Prefer existing indentation over editorconfig
let g:sleuth_automatic = 0
call editorconfig#AddNewHook({->execute(':Sleuth')})

" ale
let g:ale_fix_on_save = 1
nmap <silent> [a <Plug>(ale_previous)
nmap <silent> ]a <Plug>(ale_next)
nmap <silent> <leader>ad <Plug>(ale_detail)

" ale: Style
let g:ale_sign_error = s:gutter_info_char
let g:ale_sign_warning = s:gutter_info_char
let g:ale_echo_msg_format = '[%linter%%: code%] %s'

" ale: Language-specific options
let g:ale_linter_aliases = {
      \'docker-compose': ['yaml'],
      \}
let g:ale_linters = {
      \'sh': ['shellcheck'],
      \'go': ['golangci-lint'],
      \'javascript': ['eslint'],
      \'rust': ['rls'],
      \'typescript': ['prettier', 'tslint', 'tsserver'],
      \}
let g:ale_fixers = {
      \'rust': ['rustfmt'],
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
      \   --glob "!.git/*"
      \   --glob "!*.min.js"
      \   --glob "!*.js.map"
      \ ',
      \ }
let g:ctrlsf_auto_focus = { 'at': 'start' }
let g:ctrlsf_confirm_save = 0
nmap <C-F> <Plug>CtrlSFPrompt

" fzf
nnoremap <C-P> :FZF<CR>
let g:fzf_layout = { 'down': 15 }
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git/*"'
endif

" lightline
let g:lightline = {
    \ 'colorscheme': 'dots',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'readonly', 'relativepath', 'modified' ] ]
    \ }
    \ }

" test
nmap <silent> <leader>tn :TestNearest<CR>
nmap <silent> <leader>tf :TestFile<CR>
nmap <silent> <leader>ts :TestSuite<CR>
nmap <silent> <leader>tl :TestLast<CR>

" vim-go
let g:go_fmt_fail_silently = 1
let g:go_highlight_operators = 1
let g:go_fmt_command = 'goimports'

augroup VimGo
  autocmd!
  autocmd FileType go call s:ConfigureVimGo()
  function! s:ConfigureVimGo()
    nmap <leader>cu :GoCoverage<CR>
    nmap <leader>cd :GoCoverageClear<CR>
  endfunction
augroup END

" LanguageClient-neovim
let g:LanguageClient_rootMarkers = {
      \ 'go': ['git', 'go.mod'],
      \ }
let g:LanguageClient_serverCommands = {
      \ 'go': ['gopls'],
      \ 'sh': ['bash-language-server', 'start'],
      \ 'css': ['css-languageserver', '--stdio'],
      \ 'less': ['css-languageserver', '--stdio'],
      \ 'scss': ['css-languageserver', '--stdio'],
      \ 'javascript': ['javascript-typescript-stdio'],
      \ 'javascript.jsx': ['javascript-typescript-stdio'],
      \ 'typescript': ['javascript-typescript-stdio'],
      \ 'python': ['pyls'],
      \ 'rust': ['rustup', 'run', 'stable', 'rls'],
      \ }
let g:LanguageClient_diagnosticsEnable = 0

augroup LanguageClient
  autocmd!
  autocmd FileType * call s:ConfigureLanguageClientBuffer()
  function! s:ConfigureLanguageClientBuffer()
    if !has_key(g:LanguageClient_serverCommands, &filetype)
      return
    endif

    call ncm2#enable_for_buffer()

    nnoremap <silent> <buffer> K :call LanguageClient#textDocument_hover()<CR>
    nnoremap <silent> <buffer> <C-]> :call LanguageClient#textDocument_definition()<CR>
    nnoremap <silent> <buffer> <F2> :call LanguageClient#textDocument_rename()<CR>
  endfunction
augroup END

" vim-markdown
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
colorscheme dots

set colorcolumn=80
set formatoptions+=j
set lazyredraw
set magic
set nojoinspaces
set noshowmode
set noswapfile
set number
set scrolloff=5
set signcolumn=yes
set smartindent
set updatetime=100
set wrap

set shortmess+=c

if &t_Co >= 16
  set cursorline
endif

" Search options
set ignorecase
set smartcase

" Show matching brackets when text indicator is over them
set showmatch
set matchtime=2

" Autocomplete
set completeopt=menuone,noselect
inoremap <C-Space> <C-x><C-o>
imap <C-@> <C-Space>
inoremap <silent> <expr> <Tab> pumvisible() ? "\<C-n>" : "\<C-g>u\<Tab>"
inoremap <silent> <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<C-g>u\<S-Tab>"
inoremap <silent> <expr> <CR> pumvisible() ? "\<C-y>\<CR>" : "\<C-g>u\<CR>"

" Use Unix as the standard file type
set fileformats=unix,dos,mac

" Show whitespace
set list
set listchars=eol:¬,tab:»\ ,space:·,trail:·,nbsp:␣

" Allow italics
let &t_ZH="\e[3m"
let &t_ZR="\e[23m"


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

" Specify the behavior when switching between buffers
set hidden
set switchbuf=useopen,vsplit

" Window-closing shortcuts
map <silent> <leader>qq :cclose <bar> pclose <bar> helpclose<cr>

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
nmap <leader>v :source $MYVIMRC<cr>

" Fast writes
nmap <leader>w :w!<cr>

" Copy to system clipboard
noremap <leader>y "+y

" Toggle paste mode
map <leader>pp :setlocal paste!<cr>

" Toggle spell checking
map <leader>ss :setlocal spell!<cr>

" Local config
if filereadable($HOME . '/.vimrc.local')
  source ~/.vimrc.local
endif

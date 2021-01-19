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
Plug 'b4winckler/vim-angry'
Plug 'editorconfig/editorconfig-vim'
Plug 'itchyny/lightline.vim'
Plug 'janko-m/vim-test'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'romainl/vim-cool'
Plug 'tpope/vim-abolish'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'
  Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sleuth'
Plug 'tpope/vim-surround'
Plug 'voldikss/vim-floaterm'
Plug 'w0rp/ale'
Plug 'wellle/targets.vim'

" Language-specific plugins
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'fatih/vim-go'
Plug 'jvirtanen/vim-hcl'
Plug 'hashivim/vim-hashicorp-tools'
" polyglot can cause issues if not plugged last
Plug 'sheerun/vim-polyglot'
let g:polyglot_disabled = ['go']
let g:jsx_ext_required = 1

call plug#end()

" Prefer existing indentation over editorconfig
let g:sleuth_automatic = 0
call editorconfig#AddNewHook({->execute(':Sleuth')})

let g:floaterm_keymap_toggle = '<C-t>'
let g:floaterm_position = 'center'
let g:floaterm_width=0.9
let g:floaterm_height=0.8

" ale
let g:ale_disable_lsp = 1
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

" vim-easy-align
nmap ga <Plug>(EasyAlign)
xmap ga <Plug>(EasyAlign)

" fzf
let s:rg_ignore_opts = '--hidden -g "!.git/*" -g "!*.min.js" -g "!*.js.map"'
if executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --follow ' . s:rg_ignore_opts
endif

let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6, 'highlight': 'FloatBorder' } }
function! RipgrepFzf(args)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case '
        \ . s:rg_ignore_opts . ' %s %s || true'
  let initial_command = printf(command_fmt, a:args, '""')
  let reload_command = printf(command_fmt, a:args, '{q}')
  let spec = {'options': [
        \ '--reverse',
        \ '--phony',
        \ '--bind', 'change:reload:'.reload_command,
        \ ]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec))
endfunction
command! -nargs=* RG call RipgrepFzf(<q-args>)
nnoremap <C-P> :FZF --reverse<CR>
nnoremap <C-F> :RG<CR>

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

" coc-nvim
augroup CocLanguages
  autocmd!
  autocmd FileType * call s:ConfigureCoCBuffer()
  function! s:ConfigureCoCBuffer()
    if (index(['vim','help'], &filetype) >= 0)
      return
    endif
    nnoremap <buffer> <silent> K :call CocAction('doHover')<CR>
    nmap <buffer> <silent> <C-]> <Plug>(coc-definition)
    nmap <buffer> <silent> gr <Plug>(coc-references)
    nmap <buffer> <silent> gi <Plug>(coc-implementation)
    nmap <buffer> <silent> <leader>rn <Plug>(coc-rename)
    nmap <buffer> <silent> <leader>ca <Plug>(coc-codeaction)
  endfunction
augroup END

" coc-nvim: Completion
inoremap <silent> <expr> <C-Space> coc#refresh()
inoremap <silent> <expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
inoremap <silent> <expr> <S-Tab>
      \ pumvisible() ? "\<C-p>" :
      \ "\<C-g>u\<S-Tab>"
inoremap <silent> <expr> <cr>
      \ complete_info()["selected"] != "-1" ? "\<C-y>" :
      \ "\<C-g>u\<CR>"
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" vim-go
let g:go_def_mapping_enabled = 0
let g:go_fmt_fail_silently = 1
let g:go_fmt_command = 'goimports'

augroup VimGo
  autocmd!
  autocmd FileType go call s:ConfigureVimGo()
  function! s:ConfigureVimGo()
    nmap <leader>cu :GoCoverage<CR>
    nmap <leader>cd :GoCoverageClear<CR>
  endfunction
augroup END

" vim-markdown
let g:vim_markdown_fenced_languages = [
      \'bash=sh', 'sh',
      \'html',
      \'javascript', 'js=javascript',
      \'typescript', 'ts=typescript',
      \'go',
      \'python',
      \'json', 'toml', 'yaml',
      \'sql',
      \]


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => General Settings
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if $COLORTERM ==# 'truecolor'
  set termguicolors
endif
colorscheme dots

set colorcolumn=80
set cinwords=""
set diffopt+=vertical
set formatoptions+=j
set hidden
set inccommand=nosplit
set lazyredraw
set magic
set nojoinspaces
set noshowmode
set noswapfile
set number
set signcolumn=yes
set smartindent
set updatetime=100
set wrap

set shortmess+=c

let s:scrolloff = 5
augroup ScrollOff
  autocmd!
  autocmd TermEnter * setlocal scrolloff=0
  autocmd TermLeave * setlocal scrolloff=5
augroup END

if &t_Co >= 16
  set cursorline
endif

" Search options
set ignorecase
set smartcase

" Show matching brackets when text indicator is over them
set showmatch
set matchtime=2

" Use Unix as the standard file type
set fileformats=unix,dos,mac

" Show whitespace
set list
set listchars=tab:»\ ,space:·,trail:·,nbsp:␣

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Netrw
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Easy way to open file explorer
map <leader>e :Explore<cr>

let g:netrw_banner = 0
let g:netrw_list_hide = '\.DS_Store,\.git/,\.gitmodules/,\.vscode/,__pycache__/,\.log,\.pid'


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Moving around, tabs, windows and buffers
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Treat long lines as break lines
map j gj
map k gk

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

" Toggle spell checking
map <leader>ss :setlocal spell!<cr>

" Local config
if filereadable($HOME . '/.vimrc.local')
  source ~/.vimrc.local
endif

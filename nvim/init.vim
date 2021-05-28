scriptencoding utf-8

" Leader
map <space> <nop>
let g:mapleader = ' '

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

set completeopt=menuone,noselect
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

" Easy way to open file explorer
map <leader>e :Explore<cr>

let g:netrw_banner = 0
let g:netrw_list_hide = '\.DS_Store,\.git/,\.gitmodules/,\.vscode/,__pycache__/,\.log,\.pid'

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

" Reload vimrc
nmap <leader>v :source $MYVIMRC<cr>

" Fast writes
nmap <leader>w :w!<cr>

" Copy to system clipboard
noremap <leader>y "+y

" Toggle spell checking
map <leader>ss :setlocal spell!<cr>

lua require('cfg.reload')
lua reload()

" Configure plugins
command! Pack lua require('cfg.plugins').sync()
augroup packer_compile
  autocmd!
  autocmd BufWritePost */cfg/plugins.lua,*/cfg/plugin/*.lua
        \ lua reload(); require('cfg.plugins').compile()
augroup END

" Source local config last
if filereadable($HOME . '/.vimrc.local')
  source ~/.vimrc.local
endif

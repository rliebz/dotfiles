if filereadable($HOME . '/.vimrc.local')
  source ~/.vimrc.local
endif

if filereadable($HOME . '/.vimrc-local.lua')
  source ~/.vimrc-local.lua
endif

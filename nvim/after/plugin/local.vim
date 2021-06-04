if filereadable($HOME . '/.vimrc.local')
  source ~/.vimrc.local
endif

if filereadable($HOME . '/.vimrc-local.lua')
  luafile ~/.vimrc-local.lua
endif

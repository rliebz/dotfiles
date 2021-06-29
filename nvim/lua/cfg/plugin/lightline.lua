vim.g.lightline = {
  colorscheme = 'dots',
  active = {
    left = {
      {'mode', 'paste'},
      {'readonly', 'relativepath', 'modified'},
    },
  },
}

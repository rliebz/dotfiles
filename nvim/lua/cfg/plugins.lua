local install_path = vim.fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.cmd [[packadd packer.nvim]]

local packer = require'packer'
packer.startup({function()
  use { 'wbthomason/packer.nvim', opt = true }

  use 'airblade/vim-gitgutter'
  use 'AndrewRadev/splitjoin.vim'
  use 'b4winckler/vim-angry'
  use { 'editorconfig/editorconfig-vim', config = [[require'plugin.editorconfig']] }
  use { 'itchyny/lightline.vim', config = [[require'plugin.lightline']] }
  use { 'janko-m/vim-test', config = [[require'plugin.test']] }
  use { 'junegunn/vim-easy-align', config = [[require'plugin.easy-align']] }
  use {
    'junegunn/fzf',
    run = function() vim.fn['fzf#install']() end,
    config = [[require'plugin.fzf']],
  }
  use 'junegunn/fzf.vim'
  use 'romainl/vim-cool'
  use 'tpope/vim-abolish'
  use 'tpope/vim-commentary'
  use {
    'tpope/vim-fugitive',
    requires = {'tpope/vim-rhubarb', 'shumphrey/fugitive-gitlab.vim'},
  }
  use 'tpope/vim-repeat'
  use 'tpope/vim-sleuth'
  use 'tpope/vim-surround'
  use { 'voldikss/vim-floaterm', config = [[require'plugin.floaterm']] }
  use { 'w0rp/ale', config = [[require'plugin.ale']] }
  use 'wellle/targets.vim'

  -- Language Server Protocol
  use 'nathunsmitty/nvim-ale-diagnostic'
  use { 'neovim/nvim-lspconfig', config = [[require'plugin.lspconfig']] }
  use { 'hrsh7th/nvim-compe', config = [[require'plugin.compe']] }
  use 'hrsh7th/vim-vsnip'

  -- Language-specific plugins
  use { 'fatih/vim-go', config = [[require'plugin.go']] }
  use 'jvirtanen/vim-hcl'

  -- polyglot can cause issues if not sourced last
  use { 'sheerun/vim-polyglot', config = [[require'plugin.polyglot']] }

end, config = {
  disable_commands = true,
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'single' })
    end
  }
}})

packer.sync()

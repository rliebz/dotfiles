local install_path = vim.fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.cmd[[packadd packer.nvim]]

packer = require('packer')

packer.init({
  disable_commands = true,
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'single' })
    end
  },
})

packer.reset()

local use = packer.use

-- Manage packer with packer
use { 'wbthomason/packer.nvim', opt = true }

-- General Purpose Plugins
use 'airblade/vim-gitgutter'
use 'AndrewRadev/splitjoin.vim'
use 'b4winckler/vim-angry'
use { 'editorconfig/editorconfig-vim', config = [[require('cfg.plugin.editorconfig')]] }
use { 'itchyny/lightline.vim', config = [[require('cfg.plugin.lightline')]] }
use { 'janko-m/vim-test', config = [[require('cfg.plugin.test')]] }
use { 'junegunn/vim-easy-align', config = [[require('cfg.plugin.easy-align')]] }
use {
  'junegunn/fzf',
  run = function() vim.fn['fzf#install']() end,
  config = [[require('cfg.plugin.fzf')]],
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
use { 'voldikss/vim-floaterm', config = [[require('cfg.plugin.floaterm')]] }
use { 'w0rp/ale', config = [[require('cfg.plugin.ale')]] }
use 'wellle/targets.vim'

-- Language Server Protocol
use 'nathunsmitty/nvim-ale-diagnostic'
use { 'neovim/nvim-lspconfig', config = [[require('cfg.plugin.lspconfig')]] }
use { 'hrsh7th/nvim-compe', config = [[require('cfg.plugin.compe')]] }
use 'hrsh7th/vim-vsnip'

-- Language-specific plugins
use 'blankname/vim-fish'
use 'cespare/vim-toml'
use { 'fatih/vim-go', config = [[require('cfg.plugin.go')]] }
use 'jvirtanen/vim-hcl'
use 'MaxMEllon/vim-jsx-pretty'
use { 'tpope/vim-markdown', config = [[require('cfg.plugin.markdown')]] }
use 'tbastos/vim-lua'

return packer

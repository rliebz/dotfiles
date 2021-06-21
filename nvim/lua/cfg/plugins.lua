local install_path = vim.fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
end

vim.cmd[[packadd packer.nvim]]

local packer = require('packer')

packer.init({
  disable_commands = true,
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'single' })
    end
  },
})

packer.reset()

local function cfg(filename)
  return string.format([[require('cfg.plugin.%s')]], filename)
end

local use = packer.use

-- Manage packer with packer
use { 'wbthomason/packer.nvim', opt = true }

-- General Purpose Plugins
use 'airblade/vim-gitgutter'
use 'AndrewRadev/splitjoin.vim'
use 'b4winckler/vim-angry'
use { 'editorconfig/editorconfig-vim', config = cfg('editorconfig') }
use { 'itchyny/lightline.vim', config = cfg('lightline') }
use { 'janko-m/vim-test', config = cfg('test') }
use { 'junegunn/vim-easy-align', config = cfg('easy-align') }
use {
  'junegunn/fzf',
  run = function() vim.fn['fzf#install']() end,
  config = cfg('fzf'),
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
use { 'voldikss/vim-floaterm', config = cfg('floaterm') }
use { 'w0rp/ale', config = cfg('ale') }
use 'wellle/targets.vim'

-- Language Server Protocol
use { 'neovim/nvim-lspconfig', config = cfg('lspconfig') }
use {
  'nathunsmitty/nvim-ale-diagnostic',
  requires = {'neovim/nvim-lspconfig'},
  config = cfg('ale-diagnostic'),
}
use {
  'kabouzeid/nvim-lspinstall',
  requires = {'neovim/nvim-lspconfig'},
  config = cfg('lspinstall'),
}
use { 'hrsh7th/nvim-compe', config = cfg('compe') }
use 'hrsh7th/vim-vsnip'

-- Language-specific plugins
use 'blankname/vim-fish'
use 'cespare/vim-toml'
use { 'fatih/vim-go', config = cfg('go') }
use 'jvirtanen/vim-hcl'
use 'MaxMEllon/vim-jsx-pretty'
use { 'tpope/vim-markdown', config = cfg('markdown') }
use 'tbastos/vim-lua'

return packer

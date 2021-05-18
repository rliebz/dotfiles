local sync_required = false

local install_path = vim.fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.system({'git', 'clone', 'https://github.com/wbthomason/packer.nvim', install_path})
  sync_required = true
end

local packer = require'packer'
packer.startup({function()
  use 'wbthomason/packer.nvim'

  use 'airblade/vim-gitgutter'
  use 'AndrewRadev/splitjoin.vim'
  use 'b4winckler/vim-angry'
  use 'editorconfig/editorconfig-vim'
  use 'itchyny/lightline.vim'
  use 'janko-m/vim-test'
  use 'junegunn/vim-easy-align'
  use {
    'junegunn/fzf',
    run = function() vim.fn['fzf#install']() end,
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
  use 'voldikss/vim-floaterm'
  use 'w0rp/ale'
  use 'wellle/targets.vim'

  -- Language Server Protocol
  use 'nathunsmitty/nvim-ale-diagnostic'
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/nvim-compe'
  use 'hrsh7th/vim-vsnip'

  -- Language-specific plugins
  use 'fatih/vim-go'
  use 'jvirtanen/vim-hcl'

  -- polyglot can cause issues if not sourced last
  use 'sheerun/vim-polyglot'

end, config = {
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'single' })
    end
  }
}})

function load_plugin_settings()
  for _, f in ipairs(vim.api.nvim_get_runtime_file('lua/plugin/**/*.lua', true)) do
    local ok, msg = pcall(loadfile(f))

    if not ok then
      print('Error loading', f)
      print('  ', msg)
    end
  end
end

if sync_required then
  packer.sync()
  vim.cmd([[autocmd User PackerComplete lua load_plugin_settings()]])
else
  load_plugin_settings()
end

local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	vim.fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })
end

vim.cmd([[packadd packer.nvim]])

local packer = require("packer")

packer.init({
	disable_commands = true,
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "single" })
		end,
	},
})

packer.reset()

local use = packer.use

-- Manage packer with packer
use({ "wbthomason/packer.nvim", opt = true })

-- General Purpose Plugins
use("AndrewRadev/splitjoin.vim")
use("b4winckler/vim-angry")
use("editorconfig/editorconfig-vim")
use("itchyny/lightline.vim")
use("janko-m/vim-test")
use("junegunn/vim-easy-align")
use({
	"junegunn/fzf",
	run = function()
		vim.fn["fzf#install"]()
	end,
})
use("junegunn/fzf.vim")
use({
	"lewis6991/gitsigns.nvim",
	requires = { "nvim-lua/plenary.nvim" },
})
use("romainl/vim-cool")
use("tpope/vim-abolish")
use("tpope/vim-commentary")
use({
	"tpope/vim-fugitive",
	requires = { "tpope/vim-rhubarb", "shumphrey/fugitive-gitlab.vim" },
})
use("tpope/vim-repeat")
use("tpope/vim-sleuth")
use("tpope/vim-surround")
use("voldikss/vim-floaterm")
use("w0rp/ale")
use("wellle/targets.vim")

use({
	"nvim-treesitter/nvim-treesitter",
	requires = { "nvim-treesitter/playground" },
	run = ":TSUpdate",
})

-- Language Server Protocol
use({
	"neovim/nvim-lspconfig",
	requires = { "nathunsmitty/nvim-ale-diagnostic", "kabouzeid/nvim-lspinstall" },
})
use("hrsh7th/nvim-compe")
use("hrsh7th/vim-vsnip")

-- Language-specific plugins
use("blankname/vim-fish")
use("cespare/vim-toml")
use("fatih/vim-go")
use("jvirtanen/vim-hcl")
use("MaxMEllon/vim-jsx-pretty")
use("tpope/vim-markdown")
use("tbastos/vim-lua")

return packer

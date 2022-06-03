local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) == 1 then
	vim.fn.system({ "git", "clone", "https://github.com/wbthomason/packer.nvim", install_path })
end

vim.cmd([[packadd packer.nvim]])

local packer = require("packer")

packer.init({
	disable_commands = true,
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
	autoremove = true,
})

packer.reset()

local use = packer.use

-- Manage packer with packer
use({ "wbthomason/packer.nvim", opt = true })

-- General Purpose Plugins
use("AndrewRadev/splitjoin.vim")
use("b4winckler/vim-angry")
use("itchyny/lightline.vim")
use("vim-test/vim-test")
use("junegunn/vim-easy-align")
use({
	"junegunn/fzf",
	run = function()
		vim.fn["fzf#install"]()
	end,
})
use("junegunn/fzf.vim")
use("justinmk/vim-dirvish")
use({
	"lewis6991/gitsigns.nvim",
	requires = { "nvim-lua/plenary.nvim" },
})
use("numToStr/FTerm.nvim")
use("ntpeters/vim-better-whitespace")
use("rliebz/vim-clover")
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
use("tyru/open-browser.vim")
use("wellle/targets.vim")

use({
	"nvim-treesitter/nvim-treesitter",
	requires = { "nvim-treesitter/playground" },
	run = ":TSUpdate",
})

use({
	"nvim-telescope/telescope.nvim",
	requires = {
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-telescope/telescope-live-grep-raw.nvim" },
		{ "nvim-telescope/telescope-fzf-native.nvim", run = "make" },
	},
})

-- Language Server Protocol
use({
	"jose-elias-alvarez/null-ls.nvim",
	requires = { "nvim-lua/plenary.nvim" },
})
use({
	"neovim/nvim-lspconfig",
	requires = {
		"williamboman/nvim-lsp-installer",
		"b0o/schemastore.nvim",
	},
})
use({
	"hrsh7th/nvim-cmp",
	requires = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/vim-vsnip",
	},
})

-- Language-specific plugins
use("chrisbra/csv.vim")

return packer

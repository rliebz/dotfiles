return {
	"nvim-treesitter/nvim-treesitter",
	dependencies = { "nvim-treesitter/playground" },
	build = ":TSUpdate",
	config = function()
		require("nvim-treesitter.configs").setup({
			ensure_installed = "all",
			ignore_install = { "phpdoc" },
			highlight = {
				enable = true,
				disable = {
					"sql",
					"yaml",
				},
			},
		})

		vim.keymap.set("n", "<leader>hi", vim.cmd.TSHighlightCapturesUnderCursor, {})
	end,
}

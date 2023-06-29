return {
	"stevearc/oil.nvim",
	init = function()
		vim.g.loaded_netrw = 1
		vim.g.loaded_netrwPlugin = 1
		vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })
	end,
	opts = {
		win_options = {
			concealcursor = "nvic",
			number = false,
			signcolumn = "yes",
		},
		view_options = {
			show_hidden = true,
		},
		skip_confirm_for_simple_edits = true,
		keymaps = {
			["g."] = false,
			["<C-t>"] = false,
			["<C-p>"] = false,
			["<C-c>"] = false,
			["<C-h>"] = false,
			["<C-s>"] = false,
		},
	},
}

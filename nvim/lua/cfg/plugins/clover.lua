return {
	"rliebz/nvim-clover",
	event = "VeryLazy",
	keys = {
		{ "<leader>cu", vim.cmd.CloverUp },
		{ "<leader>cd", vim.cmd.CloverDown },
		{ "<leader>ct", vim.cmd.CloverToggle },
	},
}

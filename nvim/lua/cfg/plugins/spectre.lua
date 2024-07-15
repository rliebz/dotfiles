return {
	"nvim-pack/nvim-spectre",
	event = "VeryLazy",
	dependencies = {
		"nvim-lua/plenary.nvim",
	},
	opts = {
		highlight = {
			search = "DiffDeleteInline",
			replace = "DiffAddInline",
		},
	},
	keys = {
		{
			"<leader>S",
			function()
				require("spectre").open()
			end,
		},
	},
}

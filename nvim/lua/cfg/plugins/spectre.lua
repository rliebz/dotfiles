return {
	"nvim-pack/nvim-spectre",
	dependencies = {
		"nvim-lua/plenary.nvim",
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

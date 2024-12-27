return {
	"folke/snacks.nvim",
	keys = {
		{ "<c-/>", function() require("snacks").terminal() end, desc = "Toggle Terminal", mode = { "n", "t" } },
	},
	opts = {
		terminal = {
			win = {
				border = "rounded",
				position = "float",
			},
		},
	},
}

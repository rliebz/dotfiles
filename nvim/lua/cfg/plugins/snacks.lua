return {
	"folke/snacks.nvim",
	priority = 1000,
	lazy = false,
	keys = {
		{
			"<c-/>",
			function() require("snacks").terminal() end,
			desc = "Toggle Terminal",
			mode = { "n", "t" },
		},
	},
	opts = {
		bigfile = {
			notify = false,
		},
		terminal = {
			win = {
				border = "rounded",
				position = "float",
				row = 0.03,
			},
		},
	},
}

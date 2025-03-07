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
		input = {
			enabled = true,
			win = {
				width = 50,
				relative = "cursor",
				row = -3,
				title_pos = "left",
			},
		},
		picker = {
			icons = {
				files = {
					enabled = false,
				},
			},
			layouts = {
				default = {
					layout = {
						box = "horizontal",
						width = 0.9,
						height = 0.9,
					},
				},
			},
			ui_select = true,
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

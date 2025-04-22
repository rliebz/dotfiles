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
		{
			"<leader>sh",
			function() Snacks.picker.help() end,
			desc = "[S]earch [H]elp",
		},
		{
			"<leader>sf",
			function() Snacks.picker.files() end,
			desc = "[S]earch [F]iles",
		},
		{
			"<leader>sg",
			function() Snacks.picker.grep() end,
			desc = "[S]each by [G]rep",
		},
		{
			"<leader>sr",
			function() Snacks.picker.resume() end,
			desc = "[S]earch [R]esume",
		},
		{
			"<leader>sp",
			function() Snacks.picker() end,
			desc = "[S]earch [P]ickers",
		},
	},
	opts = {
		bigfile = {
			notify = false,
		},
		image = {
			enabled = false,
			filetype = {}, -- ?
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
			main = {
				file = false,
			},
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
			sources = {
				files = {
					hidden = true,
				},
				grep = {
					hidden = true,
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

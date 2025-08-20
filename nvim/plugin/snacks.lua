vim.pack.add({ "https://github.com/folke/snacks.nvim" }, { confirm = false })

require("snacks").setup({
	bigfile = {
		notify = false,
	},
	image = {
		enabled = false,
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
})

vim.keymap.set(
	{ "n", "t" },
	"<c-/>",
	function() Snacks.terminal() end,
	{ desc = "Toggle Terminal" }
)

vim.keymap.set("n", "<leader>sh", function() Snacks.picker.help() end, { desc = "[S]earch [H]elp" })
vim.keymap.set(
	"n",
	"<leader>sf",
	function() Snacks.picker.files() end,
	{ desc = "[S]earch [F]iles" }
)
vim.keymap.set(
	"n",
	"<leader>sg",
	function() Snacks.picker.grep() end,
	{ desc = "[S]each by [G]rep" }
)
vim.keymap.set(
	"n",
	"<leader>sr",
	function() Snacks.picker.resume() end,
	{ desc = "[S]earch [R]esume" }
)
vim.keymap.set("n", "<leader>sp", function() Snacks.picker() end, { desc = "[S]earch [P]ickers" })

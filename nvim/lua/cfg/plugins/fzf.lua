return {
	"ibhagwan/fzf-lua",
	event = "VeryLazy",
	keys = {
		{ "<leader>sh", "<cmd>FzfLua help_tags<cr>", desc = "[S]earch [H]elp" },
		{ "<leader>sf", "<cmd>FzfLua files<cr>", desc = "[S]earch [F]iles" },
		{ "<leader>sg", "<cmd>FzfLua live_grep<cr>", desc = "[S]each by [G]rep" },
		{ "<leader>sG", "<cmd>FzfLua live_grep_glob<cr>", desc = "[S]earch by Grep [G]lob" },
		{ "<leader>sr", "<cmd>FzfLua resume<cr>", desc = "[S]earch [R]esume" },
	},
	opts = {
		keymap = {
			fzf = {
				["ctrl-q"] = "select-all+accept",
				["ctrl-u"] = "half-page-up",
				["ctrl-d"] = "half-page-down",
				["ctrl-a"] = "beginning-of-line",
				["ctrl-e"] = "end-of-line",
			},
		},
		winopts = {
			preview = {
				horizontal = "right:45%",
			},
		},
		defaults = {
			git_icons = false,
			no_header = true,
		},
	},
}

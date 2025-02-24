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
			},
		},
		winopts = {
			preview = {
				horizontal = "right:45%",
			},
		},
		defaults = {
			no_header = true,
		},
		grep = {
			hidden = true,
			rg_opts = vim.iter({
				-- Extra flags
				"-g",
				"!.git",
				-- Default flags
				"--column",
				"--line-number",
				"--no-heading",
				"--color=always",
				"--smart-case",
				"--max-columns=4096",
				"-e",
			}):join(" "),
		},
	},
}

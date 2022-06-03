local telescope = require("telescope")

local actions = require("telescope.actions")
telescope.setup({
	defaults = {
		hidden = true,
		sorting_strategy = "ascending",
		layout_strategy = "horizontal",
		layout_config = {
			prompt_position = "top",
		},
		mappings = {
			i = {
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
			},
		},
		vimgrep_arguments = {
			"rg",
			-- Defaults
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
			-- Overrides
			"--hidden",
			"-g",
			"!.git/*",
			"-g",
			"!*.min.js",
			"-g",
			"!*.js.map",
		},
	},
	pickers = {
		find_files = {
			hidden = true,
			find_command = {
				"rg",
				"--files",
				-- Overrides
				"--hidden",
				"-g",
				"!.git/*",
				"-g",
				"!*.min.js",
				"-g",
				"!*.js.map",
			},
		},
	},
})
telescope.load_extension("fzf")
telescope.load_extension("live_grep_raw")

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<C-p>", builtin.find_files, {})
vim.keymap.set("n", "<C-f>", builtin.live_grep, {})

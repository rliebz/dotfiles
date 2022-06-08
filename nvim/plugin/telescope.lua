local telescope = require("telescope")

local function rg(args)
	local command = {
		"rg",
		"--hidden",
		"-g",
		"!.git/*",
		"-g",
		"!*.min.js",
		"-g",
		"!*.js.map",
	}
	for _, arg in ipairs(args) do
		table.insert(command, arg)
	end
	return command
end

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
		vimgrep_arguments = rg({
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
		}),
	},
	pickers = {
		find_files = {
			hidden = true,
			find_command = rg({
				"--files",
			}),
		},
	},
})
telescope.load_extension("fzf")
telescope.load_extension("live_grep_args")

local builtin = require("telescope.builtin")
vim.keymap.set("n", "<C-p>", builtin.find_files, {})
vim.keymap.set("n", "<C-f>", builtin.live_grep, {})

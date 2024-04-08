return {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-telescope/telescope-live-grep-args.nvim" },
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	keys = {
		{
			"<C-p>",
			function()
				vim.cmd.Telescope("find_files")
			end,
		},
		{
			"<C-f>",
			function()
				vim.cmd.Telescope("live_grep")
			end,
		},
	},
	config = function()
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
				"-g",
				"!*.sql.go",
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
	end,
}

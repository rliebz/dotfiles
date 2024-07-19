return {
	"nvim-telescope/telescope.nvim",
	event = "VeryLazy",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-telescope/telescope-live-grep-args.nvim" },
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	keys = {
		{ "<leader>sh", function() vim.cmd.Telescope("help_tags") end, desc = "[S]earch [H]elp" },
		{ "<leader>sf", function() vim.cmd.Telescope("find_files") end, desc = "[S]earch [F]iles" },
		{ "<leader>sg", function() vim.cmd.Telescope("live_grep") end, desc = "[S]each by [G]rep" },
		{ "<leader>sa", function() vim.cmd.Telescope("live_grep_args") end, desc = "[S]earch by Grep [A]rgs" },
		{ "<leader>sr", function() vim.cmd.Telescope("resume") end, desc = "[S]earch [R]esume" },
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
		local action_set = require("telescope.actions.set")
		local page_down = function(prompt_bufnr) action_set.shift_selection(prompt_bufnr, 25) end
		local page_up = function(prompt_bufnr) action_set.shift_selection(prompt_bufnr, -25) end

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
						["<C-d>"] = page_down,
						["<C-u>"] = page_up,
					},
					n = {
						["<C-d>"] = page_down,
						["<C-u>"] = page_up,
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

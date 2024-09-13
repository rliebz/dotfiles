return {
	"folke/noice.nvim",
	event = "VeryLazy",
	dependencies = {
		"MunifTanjim/nui.nvim",
	},
	opts = {
		presets = {
			lsp_doc_border = true,
		},
		cmdline = {
			enabled = false,
			format = {
				filter = { pattern = "^:%s*!", icon = "%", lang = "fish" },
			},
		},
		messages = { enabled = false },
		notify = { enabled = false },
		lsp = {
			override = {
				["vim.lsp.util.convert_input_to_markdown_lines"] = true,
				["vim.lsp.util.stylize_markdown"] = true,
				["cmp.entry.get_documentation"] = true,
			},
		},
		views = {
			mini = {
				position = {
					-- Make room for cmdheight=1
					row = -2,
				},
				timeout = 5000,
			},
		},
	},
	config = function(_, opts)
		-- This seems to cause flickering on search, but the hack is irrelevant if
		-- we're not using the command palette.
		---@diagnostic disable: duplicate-set-field
		require("noice.util.hacks").fix_redraw = function() end

		require("noice").setup(opts)
	end,
}

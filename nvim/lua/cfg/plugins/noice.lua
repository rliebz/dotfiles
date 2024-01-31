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
		cmdline = { enabled = false },
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
		-- This doesn't appear to be a problem with all the disabled settings, so
		-- skip the hack to avoid having conceal disabled while searching.
		---@diagnostic disable: duplicate-set-field
		require("noice.util.hacks").fix_incsearch = function() end

		require("noice").setup(opts)
	end,
}

return {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		"folke/noice.nvim",
	},
	opts = {
		options = {
			component_separators = { left = "|", right = "|" },
			refresh = {
				statusline = 100,
				tabline = 100,
				winbar = 100,
			},
		},
		sections = {
			lualine_a = {
				"mode",
			},
			lualine_b = {
				"branch",
				"diff",
				"diagnostics",
			},
			lualine_c = {
				"filename",
			},
			lualine_x = {
				{
					function()
						---@diagnostic disable-next-line: undefined-field
						return require("noice").api.status.mode.get()
					end,
					cond = function()
						---@diagnostic disable-next-line: undefined-field
						return require("noice").api.status.mode.has()
					end,
				},
			},
			lualine_y = {
				"filetype",
			},
			lualine_z = {
				"progress",
				{ "location", padding = { left = 0, right = 1 } },
			},
		},
	},
}

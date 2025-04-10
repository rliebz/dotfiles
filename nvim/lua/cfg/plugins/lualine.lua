return {
	"nvim-lualine/lualine.nvim",
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
				{
					function()
						local dir = require("oil").get_current_dir()
						if not dir then
							dir = vim.fn.expand("%"):gsub("^oil://", "")
						end

						return vim.fn.fnamemodify(dir, ":~:.")
					end,
					cond = function() return vim.o.filetype == "oil" end,
				},
				{
					"filename",
					cond = function() return vim.o.filetype ~= "oil" end,
					path = 1,
				},
			},
			lualine_x = {},
			lualine_y = {
				"filetype",
			},
			lualine_z = {
				"progress",
				"location",
			},
		},
	},
}

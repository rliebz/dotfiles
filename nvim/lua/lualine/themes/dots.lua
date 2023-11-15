local colors = require("cfg.colors")

local function defaults_with(opts)
	local out = {
		a = { fg = colors.black, bg = colors.white, gui = "bold" },
		b = { fg = colors.cyan, bg = colors.bright_black },
		c = { fg = colors.black, bg = colors.dark_cyan },
		x = { fg = colors.green, bg = colors.dark_cyan },
		y = { fg = colors.black, bg = colors.cyan },
		z = { fg = colors.black, bg = colors.white },
	}

	for k, v in pairs(opts) do
		out[k] = v
	end

	return out
end

return {
	insert = defaults_with({
		c = { fg = colors.black, bg = colors.dark_cyan },
		a = { fg = colors.black, bg = colors.yellow, gui = "bold" },
	}),
	replace = defaults_with({
		a = { fg = colors.black, bg = colors.magenta, gui = "bold" },
	}),
	normal = defaults_with({
		a = { fg = colors.black, bg = colors.blue, gui = "bold" },
	}),
	visual = defaults_with({
		a = { fg = colors.black, bg = colors.green, gui = "bold" },
	}),
	inactive = {
		a = { fg = colors.dark_cyan, bg = colors.bright_black, gui = "bold" },
		b = { fg = colors.dark_cyan, bg = colors.bright_black },
		c = { fg = colors.dark_cyan, bg = colors.bright_black },
	},
}

local colors = require("cfg.colors")

local black = { colors.black, 0 }
local bright_black = { colors.bright_black, 8 }

local red = { colors.red, 1 }
local dark_red = { colors.dark_red, 9 }

local green = { colors.green, 2 }
local dark_green = { colors.dark_green, 10 }

local yellow = { colors.yellow, 3 }
local dark_yellow = { colors.dark_yellow, 11 }

local blue = { colors.blue, 4 }
local dark_blue = { colors.dark_blue, 12 }

local magenta = { colors.magenta, 5 }
local dark_magenta = { colors.dark_magenta, 13 }

local cyan = { colors.cyan, 6 }
local dark_cyan = { colors.dark_cyan, 14 }

local white = { colors.white, 7 }
local dark_white = { colors.dark_white, 15 }

local p = {
	normal = {
		left = { { black, blue }, { black, cyan } },
		middle = { { black, dark_cyan } },
		right = { { black, white }, { black, cyan } },

		error = { { white, red } },
		warning = { { black, yellow } },
	},
	inactive = {
		left = { { dark_cyan, bright_black }, { dark_cyan, bright_black } },
		middle = { { dark_cyan, bright_black } },
		right = { { dark_cyan, bright_black }, { dark_cyan, bright_black } },
	},
	insert = {
		left = { { black, yellow }, { black, cyan } },
	},
	replace = {
		left = { { black, magenta }, { black, cyan } },
	},
	visual = {
		left = { { black, green }, { black, cyan } },
	},
	tabline = {
		left = { { black, dark_cyan } },
		middle = { { black, bright_black } },
		right = { { black, dark_cyan } },
		tabsel = { { black, cyan } },
	},
}

vim.g["lightline#colorscheme#dots#palette"] = vim.fn["lightline#colorscheme#flatten"](p)

vim.g.lightline = {
	colorscheme = "dots",
	active = {
		left = {
			{ "mode", "paste" },
			{ "readonly", "relativepath", "modified" },
		},
	},
}

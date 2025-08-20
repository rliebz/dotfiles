vim.pack.add({ "https://github.com/luukvbaal/statuscol.nvim" }, { confirm = false })

local builtin = require("statuscol.builtin")
require("statuscol").setup({
	segments = {
		{
			sign = {
				name = { ".*" },
				namespace = { "diagnostic.signs" },
			},
			click = "v:lua.ScSa",
		},
		{
			text = { builtin.lnumfunc },
			click = "v:lua.ScLa",
		},
		{
			sign = {
				namespace = { "gitsigns" },
				colwidth = 1,
				wrap = true,
			},
			click = "v:lua.ScSa",
		},
		{
			text = { builtin.foldfunc },
			click = "v:lua.ScFa",
		},
		{ text = { " " } },
	},
})

local fterm = require("FTerm")
fterm.setup({
	dimensions = {
		height = 0.9,
		width = 0.9,
	},
})

vim.keymap.set({ "n", "t" }, "<C-t>", fterm.toggle, { silent = true })

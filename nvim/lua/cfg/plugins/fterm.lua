return {
	"numToStr/FTerm.nvim",
	keys = {
		{
			"<C-t>",
			function()
				require("FTerm").toggle()
			end,
			mode = { "n", "t" },
			silent = true,
		},
	},
	opts = {
		border = "rounded",
		dimensions = {
			height = 0.9,
			width = 0.9,
		},
	},
}

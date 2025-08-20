vim.pack.add({ "https://github.com/catgoose/nvim-colorizer.lua" }, { confirm = false })

require("colorizer").setup({
	options = {
		parsers = {
			names = {
				enable = false,
			},
			hex = {
				rrggbb = true,
			},
		},
	},
})

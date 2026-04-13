vim.pack.add({ "https://github.com/catgoose/nvim-colorizer.lua" })

require("colorizer").setup({
	options = {
		parsers = {
			names = {
				enable = false,
			},
			hex = {
				default = false,
				rrggbb = true,
			},
		},
	},
})

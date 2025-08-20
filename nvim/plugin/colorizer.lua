vim.pack.add({ "https://github.com/catgoose/nvim-colorizer.lua" }, { confirm = false })

require("colorizer").setup({
	user_default_options = {
		RGB = false,
		RGBA = false,
		names = false,
	},
})

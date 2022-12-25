return {
	"itchyny/lightline.vim",
	config = function()
		vim.g.lightline = {
			colorscheme = "dots",
			active = {
				left = {
					{ "mode", "paste" },
					{ "readonly", "relativepath", "modified" },
				},
			},
		}
	end,
}

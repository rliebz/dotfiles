return {
	"tyru/open-browser.vim",
	keys = {
		{ "gx", "<Plug>(openbrowser-smart-search)", mode = { "n", "v" } },
	},
	init = function()
		vim.g.netrw_nogx = true
	end,
}

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = {
		"openapi.json",
		"openapi.yaml",
		"swagger.json",
		"swagger.yaml",
	},
	callback = function()
		vim.opt.filetype:append(".openapi")
	end,
})

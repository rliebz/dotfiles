vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = {
		".eslintrc",
		".validaterc",
	},
	callback = function() vim.bo.filetype = "json" end,
})

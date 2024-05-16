vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = {
		"*.nomad",
		"*.nomad.hcl",
	},
	callback = function()
		vim.bo.filetype = "nomad"
	end,
})

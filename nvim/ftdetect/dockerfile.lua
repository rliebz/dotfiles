vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "Dockerfile.*",
	callback = function()
		vim.opt.filetype = "dockerfile"
	end,
})
-- vi:ft=lua

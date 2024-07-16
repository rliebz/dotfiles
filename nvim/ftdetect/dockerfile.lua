vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "Dockerfile.*",
	callback = function() vim.bo.filetype = "dockerfile" end,
})
-- vi:ft=lua

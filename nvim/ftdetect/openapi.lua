vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = {
		"openapi.json",
		"openapi.yaml",
		"swagger.json",
		"swagger.yaml",
	},
	callback = function()
		if not vim.bo.filetype:find("openapi") then
			vim.bo.filetype = vim.bo.filetype .. ".openapi"
		end
	end,
})

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<leader>d", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
vim.api.nvim_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
vim.api.nvim_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)

vim.diagnostic.config({
	float = {
		border = "single",
		format = function(diagnostic)
			if diagnostic.code then
				return string.format("[%s: %s] %s", diagnostic.source, diagnostic.code, diagnostic.message)
			end

			return string.format("[%s] %s", diagnostic.source, diagnostic.message)
		end,
	},
})

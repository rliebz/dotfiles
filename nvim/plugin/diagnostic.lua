local opts = { silent = true }
vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, opts)
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

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

vim.pack.add({ "https://github.com/johmsalas/text-case.nvim" }, { confirm = false })

require("textcase").setup({
	substitude_command_name = "S",
})

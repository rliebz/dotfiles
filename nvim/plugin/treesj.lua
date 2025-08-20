vim.pack.add({ "https://github.com/Wansmer/treesj" }, { confirm = false })

require("treesj").setup({
	notify = false,
	use_default_keymaps = false,
})

vim.keymap.set("n", "gS", "<Cmd>TSJSplit<CR>")
vim.keymap.set("n", "gJ", "<Cmd>TSJJoin<CR>")

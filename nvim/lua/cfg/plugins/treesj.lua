return {
	"Wansmer/treesj",
	config = function()
		require("treesj").setup({
			use_default_keymaps = false,
		})

		vim.keymap.set("n", "gS", "<Cmd>TSJSplit<CR>")
		vim.keymap.set("n", "gJ", "<Cmd>TSJJoin<CR>")
	end,
}

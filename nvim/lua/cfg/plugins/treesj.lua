return {
	"Wansmer/treesj",
	dependencies = { "nvim-treesitter/nvim-treesitter" },
	event = "VeryLazy",
	keys = {
		{ "gS", "<Cmd>TSJSplit<CR>" },
		{ "gJ", "<Cmd>TSJJoin<CR>" },
	},
	opts = {
		notify = false,
		use_default_keymaps = false,
	},
}

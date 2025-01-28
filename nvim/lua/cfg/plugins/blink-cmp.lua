return {
	"saghen/blink.cmp",
	version = "v0.*",
	---@module 'blink.cmp'
	---@type blink.cmp.Config
	opts = {
		keymap = {
			preset = "enter",
			["<Tab>"] = { "select_next", "snippet_forward", "fallback" },
			["<S-Tab>"] = { "select_prev", "snippet_backward", "fallback" },
			["<Up>"] = { function(cmp) cmp.cancel() end, "fallback" },
			["<Down>"] = { function(cmp) cmp.cancel() end, "fallback" },
		},
		sources = {
			default = {
				"lsp",
				"path",
			},
		},
		completion = {
			accept = {
				auto_brackets = {
					enabled = true,
				},
			},
			menu = {
				border = "rounded",
				draw = {
					treesitter = { "lsp" },
				},
			},
			documentation = {
				auto_show = true,
				window = {
					border = "rounded",
				},
			},
			list = {
				selection = {
					auto_insert = false,
					preselect = false,
				},
			},
		},
		signature = {
			enabled = true,
			window = {
				border = "rounded",
			},
		},
	},
}

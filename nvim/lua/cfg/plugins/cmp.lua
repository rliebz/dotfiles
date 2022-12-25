return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		"hrsh7th/vim-vsnip",
	},
	config = function()
		local cmp = require("cmp")
		cmp.setup({
			preselect = cmp.PreselectMode.None,

			snippet = {
				expand = function(args)
					vim.fn["vsnip#anonymous"](args.body)
				end,
			},

			mapping = {
				["<S-Tab>"] = cmp.mapping.select_prev_item(),
				["<Tab>"] = cmp.mapping.select_next_item(),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm(),
			},

			sources = {
				{ name = "nvim_lsp" },
			},

			window = {
				completion = cmp.config.window.bordered({ winhighlight = "" }),
				documentation = cmp.config.window.bordered({ winhighlight = "" }),
			},
		})
	end,
}

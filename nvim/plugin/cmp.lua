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

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require("cmp_nvim_lsp").update_capabilities(capabilities)

local lspconfig = require("lspconfig")
lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
	capabilities = capabilities,
})

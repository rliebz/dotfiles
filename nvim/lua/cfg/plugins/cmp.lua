return {
	"hrsh7th/nvim-cmp",
	dependencies = {
		"hrsh7th/cmp-nvim-lsp",
		{ 'L3MON4D3/LuaSnip', opts = {} },
	},
	config = function()
		local cmp = require("cmp")
		local luasnip = require('luasnip')
		cmp.setup({
			preselect = cmp.PreselectMode.None,

			snippet = {
				expand = function(args)
					luasnip.lsp_expand(args.body)
				end,
			},

			mapping = {
				['<Tab>'] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_next_item()
					elseif luasnip.expand_or_locally_jumpable() then
						luasnip.expand_or_jump()
					else
						fallback()
					end
				end, { 'i', 's' }),
				['<S-Tab>'] = cmp.mapping(function(fallback)
					if cmp.visible() then
						cmp.select_prev_item()
					elseif luasnip.locally_jumpable(-1) then
						luasnip.jump(-1)
					else
						fallback()
					end
				end, { 'i', 's' }),
				["<C-Space>"] = cmp.mapping.complete(),
				["<C-e>"] = cmp.mapping.abort(),
				["<CR>"] = cmp.mapping.confirm(),
			},

			sorting = {
				comparators = {
					cmp.config.compare.offset,
					cmp.config.compare.exact,
					cmp.config.compare.score,
					cmp.config.compare.sort_text,
					---@diagnostic disable-next-line: assign-type-mismatch
					cmp.config.compare.recently_used,
					---@diagnostic disable-next-line: assign-type-mismatch
					cmp.config.compare.locality,
					cmp.config.compare.kind,
					cmp.config.compare.length,
					cmp.config.compare.order,
				},
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

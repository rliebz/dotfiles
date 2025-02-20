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
					enabled = false,
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
	init = function()
		if vim.fn.has("nvim-0.11") == 1 then
			-- Ensure that forced and not configurable `<Tab>` and `<S-Tab>`
			-- buffer-local mappings don't override already present ones
			local expand_orig = vim.snippet.expand
			---@diagnostic disable-next-line: duplicate-set-field
			vim.snippet.expand = function(...)
				local tab_map = vim.fn.maparg("<Tab>", "i", false, true)
				local stab_map = vim.fn.maparg("<S-Tab>", "i", false, true)
				expand_orig(...)
				vim.schedule(function()
					tab_map.buffer, stab_map.buffer = 1, 1
					-- Override temporarily forced buffer-local mappings
					vim.fn.mapset("i", false, tab_map)
					vim.fn.mapset("i", false, stab_map)
				end)
			end
		end
	end,
}

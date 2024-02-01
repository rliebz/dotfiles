return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	dependencies = {
		"williamboman/mason.nvim",
		"stevearc/conform.nvim",
		"mfussenegger/nvim-lint",
	},
	config = function()
		local extract = function(mapping)
			return vim.tbl_flatten(vim.tbl_values(mapping))
		end

		local tools = {}
		vim.list_extend(tools, extract(require("lint").linters_by_ft))
		vim.list_extend(tools, extract(require("conform").formatters_by_ft))

		local registry = require("mason-registry")
		tools = vim.tbl_filter(function(tool)
			return registry.has_package(tool)
		end, tools)

		table.sort(tools)
		require("mason-tool-installer").setup({
			ensure_installed = vim.fn.uniq(tools),
		})
	end,
}

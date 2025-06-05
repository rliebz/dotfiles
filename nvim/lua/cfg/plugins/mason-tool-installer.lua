return {
	"WhoIsSethDaniel/mason-tool-installer.nvim",
	dependencies = {
		"mason-org/mason.nvim",
		"stevearc/conform.nvim",
		"mfussenegger/nvim-lint",
	},
	config = function()
		local tools = {
			"shellcheck", -- optional dependency of bash-language-server
		}

		---@param mapping table<string, string[]|conform.FiletypeFormatter>
		---@return string[]
		local extract_tools_by_ft = function(mapping)
			local out = {}
			for _, cfg in pairs(mapping) do
				if type(cfg) == "table" then
					for _, tool in ipairs(cfg) do
						table.insert(out, tool)
					end
				end
			end
			return out
		end

		vim.list_extend(tools, extract_tools_by_ft(require("lint").linters_by_ft))
		vim.list_extend(tools, extract_tools_by_ft(require("conform").formatters_by_ft))

		local registry = require("mason-registry")

		local lspconfig_to_mason = {}
		for _, spec in ipairs(registry.get_all_package_specs()) do
			if spec.neovim and spec.neovim.lspconfig then
				lspconfig_to_mason[spec.neovim.lspconfig] = spec.name
			end
		end

		local servers = require("cfg.lsp").servers
		for _, server in ipairs(servers) do
			table.insert(tools, lspconfig_to_mason[server] or server)
		end

		tools = vim.tbl_filter(
			---@param tool string
			function(tool) return registry.has_package(tool) end,
			tools
		)

		table.sort(tools)
		require("mason-tool-installer").setup({
			ensure_installed = vim.fn.uniq(tools),
		})
	end,
}

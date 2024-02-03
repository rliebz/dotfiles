return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		"williamboman/mason-lspconfig.nvim",
		"b0o/schemastore.nvim",
		"hrsh7th/cmp-nvim-lsp",
		"folke/neodev.nvim",
	},
	config = function()
		require("mason-lspconfig").setup({ automatic_installation = true })
		require("neodev").setup()

		local lspconfig = require("lspconfig")
		local lsp = require("cfg.lsp")

		require("lspconfig.ui.windows").default_options.border = "rounded"

		lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
			on_attach = function(client, bufnr)
				lsp.bind_keys(bufnr)
				lsp.organize_imports_on_save(client, bufnr)
			end,
		})

		local server_configs = {
			bashls = {},
			cssls = {},
			eslint = {},
			golangci_lint_ls = {},
			gopls = {
				settings = {
					gopls = {
						linksInHover = false,
						buildFlags = {
							-- Enable common build flags used for test files
							"-tags=blackbox,e2e,integration,integrity,loadtest,qualtrics_integration",
						},
						gofumpt = true,
					},
				},
				before_init = function(_, config)
					local module = vim.fn.trim(vim.fn.system("go list -m"))
					if vim.v.shell_error ~= 0 or module == nil then
						return
					end
					module = module:gsub("\n", ",")
					config.settings.gopls["formatting.local"] = module
				end,
			},
			intelephense = {},
			jsonls = {
				settings = {
					json = {
						schemas = require("schemastore").json.schemas(),
						validate = { enable = true },
					},
				},
			},
			lua_ls = {
				settings = {
					Lua = {
						completion = {
							showWord = "Disable",
						},
						workspace = {
							checkThirdParty = false,
						},
						telemetry = {
							enable = false,
						},
					},
				},
			},
			omnisharp = {},
			pylsp = {},
			rust_analyzer = {},
			solargraph = {},
			tsserver = {},
			typst_lsp = {},
			yamlls = {},
		}

		local lsp_server_names = {}
		for server_name in pairs(server_configs) do
			table.insert(lsp_server_names, server_name)
		end

		lspconfig.util.default_config = vim.tbl_deep_extend("force", lspconfig.util.default_config, {
			capabilities = require("cmp_nvim_lsp").default_capabilities(),
		})

		for server, config in pairs(server_configs) do
			lspconfig[server].setup(config)
		end
	end,
}

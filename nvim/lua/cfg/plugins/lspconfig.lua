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
				lsp.format_on_save(client, bufnr)
				lsp.organize_imports_on_save(client, bufnr)
			end,
		})

		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
			border = "rounded",
		})

		vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
			border = "rounded",
		})

		local on_publish_diagnostics = vim.lsp.handlers["textDocument/publishDiagnostics"]
		local server_configs = {
			bashls = {},
			cssls = {},
			eslint = {},
			golangci_lint_ls = {
				handlers = {
					-- https://github.com/nametake/golangci-lint-langserver/pull/34
					["textDocument/publishDiagnostics"] = function(_, result, ctx, config)
						for i, diagnostic in ipairs(result.diagnostics) do
							for position, value in pairs(diagnostic.range) do
								if value.character == -1 then
									result.diagnostics[i].range[position].character = 0
								end
							end
						end

						return on_publish_diagnostics(_, result, ctx, config)
					end,
				},
			},
			gopls = {
				settings = {
					gopls = {
						linksInHover = false,
						buildFlags = {
							-- Enable common build flags used for test files
							"-tags=e2e,integration,integrity,loadtest",
						},
						gofumpt = true,
					},
				},
			},
			intelephense = {},
			jsonls = {
				-- Skip formatting in favor of prettier
				on_attach = function(client, bufnr)
					lsp.bind_keys(bufnr)
				end,
				settings = {
					json = {
						schemas = require("schemastore").json.schemas(),
					},
				},
			},
			lua_ls = {
				settings = {
					Lua = {
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
			tsserver = {
				-- Skip formatting in favor of prettier
				on_attach = function(client, bufnr)
					lsp.bind_keys(bufnr)
					-- TODO: This seems like it doesn't work
					lsp.organize_imports_on_save(client, bufnr)
				end,
			},
		}

		local lsp_server_names = {}
		for server_name in pairs(server_configs) do
			table.insert(lsp_server_names, server_name)
		end

		local capabilities = require("cmp_nvim_lsp").default_capabilities()
		lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
			capabilities = capabilities,
		})

		for server, config in pairs(server_configs) do
			lspconfig[server].setup(config)
		end
	end,
}

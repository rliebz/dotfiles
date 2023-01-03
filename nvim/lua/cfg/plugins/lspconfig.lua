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
				lsp.bind_keys()
				lsp.format_on_save(client, bufnr)
				lsp.organize_imports_on_save(client, bufnr)
			end,
		})

		vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
			border = "single",
		})

		vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
			border = "single",
		})

		local gomodcache = nil
		local gomodcache_loaded = false
		local gopls_root_dir = nil

		local server_configs = {
			bashls = {},
			cssls = {},
			gopls = {
				root_dir = function(fname)
					local fullpath = vim.fn.expand(fname .. ":p")

					if gopls_root_dir ~= nil then
						if not gomodcache_loaded then
							gomodcache_loaded = true

							local path = vim.fn.trim(vim.fn.system("go env GOMODCACHE"))
							if vim.v.shell_error == 0 then
								gomodcache = path
							end
						end

						if gomodcache ~= nil and string.find(fullpath, gomodcache) then
							return gopls_root_dir
						end
					end

					gopls_root_dir = lspconfig.util.root_pattern("go.mod", ".git")(fname)

					return gopls_root_dir
				end,
				settings = {
					gopls = {
						linksInHover = false,
						buildFlags = {
							-- Enable common build flags used for test files
							"-tags=e2e,integration,integrity",
						},
						gofumpt = true,
					},
				},
			},
			intelephense = {},
			jsonls = {
				settings = {
					json = {
						schemas = require("schemastore").json.schemas(),
					},
				},
			},
			omnisharp = {},
			pylsp = {},
			rust_analyzer = {},
			solargraph = {},
			sumneko_lua = {
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
			tsserver = {
				-- Skip formatting in favor of prettier
				on_attach = function(client, bufnr)
					lsp.bind_keys()
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
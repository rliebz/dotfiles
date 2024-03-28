return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"williamboman/mason.nvim",
		{ "williamboman/mason-lspconfig.nvim", opts = { automatic_installation = true } },
		{ "folke/neodev.nvim", opts = {} },
		"hrsh7th/cmp-nvim-lsp",
		"b0o/schemastore.nvim",
	},
	config = function()
		local lspconfig = require("lspconfig")
		require("lspconfig.ui.windows").default_options.border = "rounded"

		local function code_action_sync(client, bufnr, kind)
			local params = vim.lsp.util.make_range_params()
			params.context = { only = { kind } }

			local timeout_ms = 1000
			local resp, err = client.request_sync("textDocument/codeAction", params, timeout_ms, bufnr)
			if err or not resp or resp.err or not resp.result or not resp.result[1] then
				return
			end

			local result = resp.result[1]
			if result.kind and result.kind ~= kind then
				return
			end

			if result.edit or type(result.command) == "table" then
				if result.edit then
					vim.lsp.util.apply_workspace_edit(result.edit, client.offset_encoding)
				end
				if type(result.command) == "table" then
					vim.lsp.buf.execute_command(result.command)
				end
			else
				vim.lsp.buf.execute_command(result)
			end
		end

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("lsp_attach", {}),
			callback = function(args)
				local client = vim.lsp.get_client_by_id(args.data.client_id)
				if not client then
					return
				end

				local opts = { buffer = args.buf, silent = true }
				vim.keymap.set("n", "<c-]>", vim.lsp.buf.definition, opts)
				vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
				vim.keymap.set({ "i", "n" }, "<c-k>", vim.lsp.buf.signature_help, opts)
				vim.keymap.set("n", "gr", "<Cmd>Telescope lsp_references<CR>", opts)
				vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
				vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
				vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
				vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
				vim.keymap.set("n", "<leader>cA", function()
					vim.lsp.buf.code_action({
						context = {
							only = { "source" },
							diagnostics = {},
						},
					})
				end, opts)

				local augroup = vim.api.nvim_create_augroup("lsp_organize_imports_%d" .. client.name, { clear = false })
				vim.api.nvim_clear_autocmds({ group = augroup, buffer = args.buf })
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup,
					buffer = args.buf,
					callback = function()
						if client.supports_method("textDocument/codeAction") then
							code_action_sync(client, args.buf, "source.organizeImports")
						end
					end,
				})
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
			pylsp = {
				settings = {
					pylsp = {
						plugins = {
							-- Black recommended settings
							pycodestyle = {
								ignore = { "E203", "E701" },
								maxLineLength = 88,
							},
						},
					},
				},
			},
			rust_analyzer = {},
			solargraph = {},
			tsserver = {
				on_attach = function(client)
					client.server_capabilities.documentFormattingProvider = false
					client.server_capabilities.documentRangeFormattingProvider = false
				end,
			},
			typst_lsp = {},
			yamlls = {
				settings = {
					yaml = {
						schemaStore = {
							enable = false,
							url = "",
						},
						schemas = require("schemastore").yaml.schemas({
							ignore = { "gitlab-ci" },
						}),
						customTags = {
							"!reference sequence",
						},
					},
				},
			},
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

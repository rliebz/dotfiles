return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"saghen/blink.cmp",
		"folke/snacks.nvim",
		"williamboman/mason.nvim",
		{ "williamboman/mason-lspconfig.nvim", opts = { automatic_installation = true } },
		{ "icholy/lsplinks.nvim", opts = {} },
		"b0o/schemastore.nvim",
	},
	config = function()
		local lspconfig = require("lspconfig")
		require("lspconfig.ui.windows").default_options.border = "rounded"

		local Methods = vim.lsp.protocol.Methods

		---@param kind lsp.CodeActionKind
		---@param only lsp.CodeActionKind[]?
		local function matchesOnly(kind, only)
			if not only then
				return true
			end

			for _, pattern in ipairs(only) do
				if kind == pattern or vim.startswith(kind, pattern .. ".") then
					return true
				end
			end

			return false
		end

		---@param client vim.lsp.Client
		---@param bufnr integer
		---@param only lsp.CodeActionKind[]?
		---@param action lsp.CodeAction | lsp.Command
		---@param timeout_ms integer
		local function handle_edit_sync(client, bufnr, only, action, timeout_ms)
			if action.kind and not matchesOnly(action.kind, only) then
				return
			end

			if not action.edit and not action.command then
				local resp, err =
					client:request_sync(Methods.codeAction_resolve, action, timeout_ms, bufnr)
				if err or not resp or resp.err or not resp.result then
					return
				end

				action = resp.result
			end

			if action.edit or type(action.command) == "table" then
				---@cast action lsp.CodeAction
				if action.edit then
					vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
				end
				if action.command ~= nil then
					client:exec_cmd(action.command)
				end
			elseif type(action.command) == "string" then
				---@cast action lsp.Command
				client:exec_cmd(action)
			end
		end

		---@param client vim.lsp.Client
		---@param bufnr integer
		---@param only lsp.CodeActionKind[]?
		local function code_action_sync(client, bufnr, only)
			local params = vim.lsp.util.make_range_params(0, client.offset_encoding)
			---@cast params lsp.CodeActionParams
			params.context = {
				only = only,
				diagnostics = {},
			}

			local timeout_ms = 1000
			local resp, err =
				client:request_sync(Methods.textDocument_codeAction, params, timeout_ms, bufnr)
			if err or not resp or resp.err or not resp.result or not resp.result[1] then
				return
			end

			for _, action in ipairs(resp.result) do
				---@cast action lsp.CodeAction | lsp.Command
				handle_edit_sync(client, bufnr, only, action, timeout_ms)
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
				vim.keymap.set("n", "<c-]>", Snacks.picker.lsp_definitions, opts)
				vim.keymap.set("n", "grn", vim.lsp.buf.rename, opts)
				vim.keymap.set("n", "grr", Snacks.picker.lsp_references, opts)
				vim.keymap.set("n", "gri", Snacks.picker.lsp_implementations, opts)
				vim.keymap.set("n", "grt", Snacks.picker.lsp_type_definitions, opts)
				vim.keymap.set({ "i", "s" }, "<c-s>", vim.lsp.buf.signature_help, opts)
				vim.keymap.set({ "n", "v" }, "<leader>cc", vim.lsp.codelens.run, opts)
				vim.keymap.set({ "n" }, "<leader>cC", vim.lsp.codelens.refresh, opts)
				vim.keymap.set({ "n", "v" }, "gra", vim.lsp.buf.code_action, opts)
				vim.keymap.set(
					"n",
					"grA",
					function()
						vim.lsp.buf.code_action({
							context = {
								only = { "source" },
								diagnostics = {},
							},
						})
					end,
					opts
				)
				vim.keymap.set({ "n", "v" }, "gx", require("lsplinks").gx)

				if client:supports_method("textDocument/codeLens") then
					vim.lsp.codelens.refresh()
					vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "InsertLeave" }, {
						buffer = args.buf,
						callback = vim.lsp.codelens.refresh,
					})
				end

				local augroup = vim.api.nvim_create_augroup(
					"code_action_format_%d" .. client.name,
					{ clear = false }
				)
				vim.api.nvim_clear_autocmds({ group = augroup, buffer = args.buf })
				vim.api.nvim_create_autocmd("BufWritePre", {
					group = augroup,
					buffer = args.buf,
					callback = function()
						if client:supports_method(Methods.textDocument_codeAction) then
							if client.name == "vtsls" then
								return
							end

							code_action_sync(client, args.buf, {
								"source.organizeImports",
								"source.fixAll",
							})
						end
					end,
				})
			end,
		})

		local server_configs = {
			bashls = {},
			biome = {},
			cssls = {},
			eslint = {},
			gdscript = {},
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
				on_attach = function(client)
					client.server_capabilities.documentFormattingProvider = false
					client.server_capabilities.documentRangeFormattingProvider = false
				end,
				settings = {
					json = {
						schemas = require("schemastore").json.schemas(),
						validate = { enable = true },
					},
				},
			},
			lua_ls = {
				on_attach = function(client)
					client.server_capabilities.documentFormattingProvider = false
					client.server_capabilities.documentRangeFormattingProvider = false
				end,
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
			pyright = {},
			ruff = {},
			rust_analyzer = {},
			solargraph = {},
			tinymist = {},
			vtsls = {
				on_attach = function(client)
					client.server_capabilities.documentFormattingProvider = false
					client.server_capabilities.documentRangeFormattingProvider = false
				end,
				settings = {
					vtsls = {
						enableMoveToFileCodeAction = true,
						autoUseWorkspaceTsdk = true,
						tsserver = {
							globalPlugins = {
								{
									-- npm -g install @styled/typescript-styled-plugin
									name = "@styled/typescript-styled-plugin",
									location = vim.fn.expand(
										"$HOME/.local/share/mise/installs/node/lts/lib/node_modules"
									),
									enableForWorkspaceTypeScriptVersions = true,
								},
							},
						},
						experimental = {
							completion = {
								enableServerSideFuzzyMatch = true,
							},
						},
					},
					typescript = {
						updateImportsOnFileMove = { enabled = "always" },
						suggest = {
							completeFunctionCalls = true,
						},
					},
				},
			},
			yamlls = {
				settings = {
					yaml = {
						schemaStore = {
							enable = false,
							url = "",
						},
						schemas = require("schemastore").yaml.schemas({
							ignore = {
								"gitlab-ci",
								"openapi.json",
							},
						}),
						customTags = {
							"!reference sequence",
						},
					},
				},
			},
		}

		for server, config in pairs(server_configs) do
			config.capabilities = require("blink.cmp").get_lsp_capabilities(config.capabilities)
			lspconfig[server].setup(config)
		end
	end,
}

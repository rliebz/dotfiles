return {
	"neovim/nvim-lspconfig",
	dependencies = {
		"saghen/blink.cmp",
		"folke/snacks.nvim",
		"williamboman/mason.nvim",
		{ "williamboman/mason-lspconfig.nvim", opts = { automatic_installation = true } },
		{ "icholy/lsplinks.nvim", opts = {} },
	},
	config = function()
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
				vim.keymap.set("n", "K", function() vim.lsp.buf.hover({ max_width = 80 }) end, opts)
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

		vim.lsp.enable({
			"bashls",
			"biome",
			"cssls",
			"eslint",
			"gdscript",
			"golangci_lint_ls",
			"gopls",
			"intelephense",
			"jsonls",
			"lua_ls",
			"omnisharp",
			"pyright",
			"ruff",
			"rust_analyzer",
			"solargraph",
			"tinymist",
			"vtsls",
			"yamlls",
		})
	end,
}

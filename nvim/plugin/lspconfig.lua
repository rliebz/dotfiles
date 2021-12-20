local lspconfig = require("lspconfig")

function lsp_organize_imports()
	local params = vim.lsp.util.make_range_params()
	params.context = { only = { "source.organizeImports" } }

	local timeout_ms = 1000
	local resp = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
	if not resp then
		return
	end

	-- Assume we have at most one LSP that can organize imports.
	-- If not, just do the first one and ignore the rest.
	local _, result = next(resp)
	if not result or not result.result or not result.result[1] then
		return
	end

	local action = result.result[1]
	if action.kind and action.kind ~= "source.organizeImports" then
		return
	end

	if action.edit or type(action.command) == "table" then
		if action.edit then
			vim.lsp.util.apply_workspace_edit(action.edit)
		end
		if type(action.command) == "table" then
			vim.lsp.buf.execute_command(action.command)
		end
	else
		vim.lsp.buf.execute_command(action)
	end
end

local function on_attach(client, bufnr)
	local function noremap(mode, key, value)
		vim.api.nvim_buf_set_keymap(bufnr, mode, key, value, { noremap = true, silent = true })
	end

	noremap("n", "<c-]>", "<cmd>lua vim.lsp.buf.definition()<CR>")
	noremap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>")
	noremap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>")
	noremap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>")
	noremap("n", "gt", "<cmd>lua vim.lsp.buf.type_definition()<CR>")
	noremap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>")
	noremap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>")
	noremap("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")
	noremap("i", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>")

	if client.name == "tsserver" then
		return
	end

	if client.resolved_capabilities.document_formatting then
		vim.cmd([[
		augroup lsp_format
			autocmd! * <buffer>
			autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
		augroup END
		]])
	end

	if client.name == "null-ls" then
		return
	end

	if client.resolved_capabilities.code_action then
		vim.cmd([[
		augroup lsp_organize_imports
			autocmd! * <buffer>
			autocmd BufWritePre <buffer> lua lsp_organize_imports()
		augroup END
		]])
	end
end

lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
	on_attach = on_attach,
})

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	border = "single",
})

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
	border = "single",
})

local runtime_path = vim.split(package.path, ";")
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local gomodcache = nil
local gomodcache_loaded = false
local gopls_root_dir = nil

local language_configs = {
	gopls = {
		root_dir = function(fname)
			local fullpath = vim.fn.expand(fname, ":p")

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
	sumneko_lua = {
		settings = {
			Lua = {
				runtime = {
					version = "LuaJIT",
					path = runtime_path,
				},
				diagnostics = {
					globals = { "vim" },
					disable = { "lowercase-global" },
				},
				workspace = {
					library = vim.api.nvim_get_runtime_file("", true),
					preloadFileSize = 1000,
				},
				telemetry = {
					enable = false,
				},
			},
		},
	},
	tsserver = {
		on_attach = function(client, bufnr)
			-- Disable in favor of prettier
			client.resolved_capabilities.document_formatting = false
			client.resolved_capabilities.document_formatting_range = false

			return on_attach(client, bufnr)
		end,
	},
}

local lsp_installer = require("nvim-lsp-installer")

lsp_installer.on_server_ready(function(server)
	server:setup(language_configs[server.name] or {})
	vim.cmd([[ do User LspAttachBuffers ]])
end)

local null_ls = require("null-ls")

null_ls.setup({
	on_attach = on_attach,
	sources = {
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.prettier,
		null_ls.builtins.formatting.rustfmt,
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.diagnostics.eslint,
		null_ls.builtins.diagnostics.flake8,
		null_ls.builtins.diagnostics.golangci_lint,
		null_ls.builtins.diagnostics.hadolint,
		null_ls.builtins.diagnostics.shellcheck,
		null_ls.builtins.diagnostics.vint,
	},
})

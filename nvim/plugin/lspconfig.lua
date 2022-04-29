local lspconfig = require("lspconfig")
local lsp = require("cfg.lsp")

lspconfig.util.default_config = vim.tbl_extend("force", lspconfig.util.default_config, {
	on_attach = lsp.on_attach,
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

local server_configs = {
	bashls = {},
	cssls = {},
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
	jsonls = {
		settings = {
			json = {
				schemas = require("schemastore").json.schemas(),
			},
		},
	},
	pylsp = {},
	rust_analyzer = {},
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

			return lsp.on_attach(client, bufnr)
		end,
	},
}

local ensure_installed = {}
for server in pairs(server_configs) do
	table.insert(ensure_installed, server)
end

require("nvim-lsp-installer").setup({
	ensure_installed = ensure_installed,
})

for server, config in pairs(server_configs) do
	lspconfig[server].setup(config)
end

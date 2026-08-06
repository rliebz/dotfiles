return {
	servers = {
		"bashls",
		"biome",
		"cssls",
		"docker_language_server",
		"gdscript",
		"eslint",
		"gopls",
		"intelephense",
		"jsonls",
		"lua_ls",
		"omnisharp",
		"pyright",
		"ruff",
		"rust_analyzer",
		"tinymist",
		"vtsls",
		"yamlls",
	},
	---@type table<string, lsp.CodeActionKind[]>
	-- defaults to { "source.fixAll", "source.organizeImports" }
	actions_on_save = {
		vtsls = {},
	},
	---@type table<string, string[]>
	disable_methods = {
		biome = { "textDocument/definition" },
		cssls = { "textDocument/formatting", "textDocument/rangeFormatting" },
		jsonls = { "textDocument/formatting", "textDocument/rangeFormatting" },
		lua_ls = { "textDocument/formatting", "textDocument/rangeFormatting" },
		vtsls = { "textDocument/formatting", "textDocument/rangeFormatting" },
	},
}

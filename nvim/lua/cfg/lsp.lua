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
		"solargraph",
		"tinymist",
		"vtsls",
		"yamlls",
	},
	---@type table<string, lsp.CodeActionKind[]>
	-- defaults to { "source.fixAll", "source.organizeImports" }
	actions_on_save = {
		vtsls = {},
	},
}

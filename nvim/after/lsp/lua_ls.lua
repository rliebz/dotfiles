local library = {
	"$VIMRUNTIME/lua",
	"${3rd}/luv/library", -- Remove after nvim 0.12
}

if vim.fn.getcwd() == vim.fn.expand("~/.dotfiles") then
	table.insert(library, "./nvim/lua")

	local lazy_data_dir = "~/.local/share/nvim/lazy/"
	for name, type in vim.fs.dir(lazy_data_dir) do
		if type == "directory" then
			table.insert(library, vim.fs.joinpath(lazy_data_dir, name, "lua"))
		end
	end
end

---@type vim.lsp.Config
return {
	on_attach = function(client)
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
		client.server_capabilities.semanticTokensProvider = nil
	end,
	settings = {
		Lua = {
			runtime = {
				version = "LuaJIT",
				pathStrict = true,
			},
			workspace = {
				library = library,
				ignore_dir = { "/lua" },
				checkThirdParty = false,
			},
			completion = {
				showWord = "Disable",
			},
			telemetry = {
				enable = false,
			},
		},
	},
}

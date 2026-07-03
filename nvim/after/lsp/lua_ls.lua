local library = {
	"$VIMRUNTIME/lua",
}

if vim.fn.getcwd() == vim.fn.expand("~/.dotfiles") then
	table.insert(library, "./nvim/lua")

	local pack_data_dir = vim.fs.joinpath(vim.fn.stdpath("data"), "/site/pack/core/opt/")
	for name, type in vim.fs.dir(pack_data_dir) do
		if type == "directory" then
			table.insert(library, vim.fs.joinpath(pack_data_dir, name, "lua"))
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

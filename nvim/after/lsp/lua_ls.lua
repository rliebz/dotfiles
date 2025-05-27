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
			},
			workspace = {
				library = {
					"$VIMRUNTIME",
					"${3rd}/luv/library", -- Remove after nvim 0.12
				},
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

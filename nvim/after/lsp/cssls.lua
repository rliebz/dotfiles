return {
	on_attach = function(client)
		-- Disable in favor of biome/prettier
		client.server_capabilities.documentFormattingProvider = false
		client.server_capabilities.documentRangeFormattingProvider = false
	end,
}

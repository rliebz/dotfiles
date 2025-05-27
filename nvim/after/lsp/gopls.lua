---@type vim.lsp.Config
return {
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
}

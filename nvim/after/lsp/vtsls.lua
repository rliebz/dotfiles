---@type vim.lsp.Config
return {
	settings = {
		vtsls = {
			enableMoveToFileCodeAction = true,
			autoUseWorkspaceTsdk = true,
			tsserver = {
				globalPlugins = {
					{
						-- npm -g install @styled/typescript-styled-plugin
						name = "@styled/typescript-styled-plugin",
						location = vim.fn.expand(
							"$HOME/.local/share/mise/installs/node/lts/lib/node_modules"
						),
						enableForWorkspaceTypeScriptVersions = true,
					},
				},
			},
			experimental = {
				completion = {
					enableServerSideFuzzyMatch = true,
				},
			},
		},
		typescript = {
			updateImportsOnFileMove = { enabled = "always" },
			suggest = {
				completeFunctionCalls = true,
			},
		},
	},
}

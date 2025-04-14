return {
	"b0o/schemastore.nvim",
	init = function()
		vim.lsp.config("jsonls", {
			settings = {
				json = {
					schemas = require("schemastore").json.schemas(),
					validate = { enable = true },
				},
			},
		})
		vim.lsp.config("yamlls", {
			settings = {
				schemaStore = {
					enable = false,
					url = "",
				},
				schemas = require("schemastore").yaml.schemas({
					ignore = {
						"gitlab-ci",
						"openapi.json",
					},
				}),
			},
		})
	end,
}

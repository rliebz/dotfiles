return {
	"stevearc/conform.nvim",
	opts = {
		formatters = {
			prettierd = {
				condition = function()
					return require("cfg.filepath").cwd_has_glob({
						".prettierrc*",
						"prettier.config.*",
						"node_modules/prettier/",
					})
				end,
			},
		},
		formatters_by_ft = {
			css = { "prettierd" },
			fish = { "fish_indent" },
			html = { "prettierd" },
			javascript = { "prettierd" },
			javascriptreact = { "prettierd" },
			json = { "prettierd" },
			jsonc = { "prettierd" },
			less = { "prettierd" },
			lua = { "stylua" },
			markdown = { "prettierd" },
			["markdown.mdx"] = { "prettierd" },
			python = { "black" },
			rust = { "rustfmt" },
			scss = { "prettierd" },
			terraform = { "terraform_fmt" },
			typescriptreact = { "prettierd" },
			yaml = { "prettierd" },
		},
		format_on_save = {
			timeout_ms = 500,
			lsp_fallback = true,
			quiet = true,
		},
	},
}

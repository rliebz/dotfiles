return {
	"stevearc/conform.nvim",
	opts = {
		formatters = {
			prettierd = {
				---@diagnostic disable-next-line: unused-local
				condition = function(self, ctx)
					return next(vim.fs.find({
						".prettierrc",
						".prettierrc.json",
						".prettierrc.yml",
						".prettierrc.yaml",
						".prettierrc.json5",
						".prettierrc.js",
						".prettier.config.js",
						".prettierrc.mjs",
						".prettier.config.mjs",
						".prettierrc.cjs",
						".prettier.config.cjs",
						".prettierrc.toml",
						"node_modules/prettier",
					}, {
						upward = true,
						path = ctx.dirname,
						stop = vim.uv.os_homedir(),
					}))
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

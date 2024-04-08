return {
	"stevearc/conform.nvim",
	opts = {
		formatters = {
			nomad_fmt = {
				command = "nomad",
				args = { "fmt", "-" },
			},
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
			hcl = { "nomad_fmt", "trim_newlines" },
			html = { "prettierd" },
			javascript = { "prettierd" },
			javascriptreact = { "prettierd" },
			json = { "prettierd" },
			jsonc = { "prettierd" },
			less = { "prettierd" },
			lua = { "stylua" },
			markdown = { "prettierd" },
			["markdown.mdx"] = { "prettierd" },
			nomad = { "nomad_fmt", "trim_newlines" },
			python = { "black" },
			scss = { "prettierd" },
			terraform = { "terraform_fmt" },
			typescript = { "prettierd" },
			typescriptreact = { "prettierd" },
			yaml = { "prettierd" },
		},
		format_on_save = {
			timeout_ms = 1000,
			lsp_fallback = "always",
			quiet = true,
		},
	},
}

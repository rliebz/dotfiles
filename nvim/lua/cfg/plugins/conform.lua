return {
	"stevearc/conform.nvim",
	---@module "conform"
	---@type conform.setupOpts
	opts = {
		formatters = {
			nomad_fmt = {
				command = "nomad",
				args = { "fmt", "-" },
			},
			prettierd = {
				condition = function(self, ctx)
					-- Only enable in directories where explicitly configured
					return require("conform.formatters.prettierd").cwd(self, ctx) --[[@as boolean]]
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
			scss = { "prettierd" },
			terraform = { "terraform_fmt" },
			typescript = { "prettierd" },
			typescriptreact = { "prettierd" },
			yaml = { "prettierd" },
		},
		format_on_save = {
			timeout_ms = 1000,
			lsp_format = "last",
			quiet = true,
		},
	},
}

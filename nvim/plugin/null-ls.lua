local null_ls = require("null-ls")
local lsp = require("cfg.lsp")

null_ls.setup({
	on_attach = lsp.on_attach,
	sources = {
		null_ls.builtins.formatting.black,
		null_ls.builtins.formatting.prettier.with({
			condition = function(utils)
				return utils.root_has_file({
					".prettierrc",
					".prettierrc.json",
					".prettierrc.yml",
					".prettierrc.yaml",
					".prettierrc.json5",
					".prettierrc.js",
					".prettierrc.cjs",
					".prettierrc.config.js",
					".prettierrc.config.cjs",
					".prettierrc.toml",
					"node_modules/prettier",
				})
			end,
		}),
		null_ls.builtins.formatting.rustfmt,
		null_ls.builtins.formatting.stylua,
		null_ls.builtins.diagnostics.eslint,
		null_ls.builtins.diagnostics.flake8,
		null_ls.builtins.diagnostics.golangci_lint,
		null_ls.builtins.diagnostics.hadolint,
		null_ls.builtins.diagnostics.shellcheck,
		null_ls.builtins.diagnostics.vint,
	},
})

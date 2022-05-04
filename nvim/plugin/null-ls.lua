local null_ls = require("null-ls")
local helpers = require("null-ls.helpers")
local lsp = require("cfg.lsp")

local ibm_openapi_validator = {
	name = "openapi-validator",
	method = null_ls.methods.DIAGNOSTICS,
	filetypes = {
		"openapi",
		"yaml.openapi", -- hack because null-ls doesn't support multi ft
	},
	generator = helpers.generator_factory({
		command = "lint-openapi",
		args = { "--json", "$FILENAME" },
		format = "json_raw",
		check_exit_code = function(code, stderr)
			return code <= 1
		end,
		on_output = function(params)
			local diagnostics = {}

			if params.err then
				-- If we have an output, it's more informative than a JSON parse error.
				-- If not, show what we have.
				table.insert(diagnostics, { message = params.output or params.err })
			end

			if type(params.output) == "table" then
				local severities = {
					{
						source = params.output.errors,
						level = helpers.diagnostics.severities["error"],
					},
					{
						source = params.output.warnings,
						level = helpers.diagnostics.severities["warning"],
					},
					{
						source = params.output.infos,
						level = helpers.diagnostics.severities["information"],
					},
					{
						source = params.output.hints,
						level = helpers.diagnostics.severities["hint"],
					},
				}

				for _, severity in ipairs(severities) do
					if type(severity.source) == "table" then
						for _, e in ipairs(severity.source) do
							table.insert(diagnostics, {
								source = "openapi-validator",
								row = e.line,
								message = e.message,
								code = e.rule,
								severity = severity.level,
							})
						end
					end
				end
			end

			return diagnostics
		end,
	}),
}
null_ls.register({ ibm_openapi_validator })

null_ls.setup({
	on_attach = function(client, bufnr)
		lsp.bind_keys(client)
		lsp.format_on_save(client, bufnr)
	end,
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
		null_ls.builtins.diagnostics.golangci_lint.with({
			-- Drop --fast, we're fast enough and want all diagnostics
			args = {
				"run",
				"--fix=false",
				"--out-format=json",
				"$DIRNAME",
				"--path-prefix",
				"$ROOT",
			},
		}),
		null_ls.builtins.diagnostics.hadolint,
		null_ls.builtins.diagnostics.shellcheck,
		null_ls.builtins.diagnostics.vint,
	},
})

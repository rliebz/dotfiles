return {
	"mfussenegger/nvim-lint",
	config = function()
		vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
			group = vim.api.nvim_create_augroup("nvim_lint", {}),
			callback = function()
				require("lint").try_lint()
			end,
		})
		require("lint").linters_by_ft = {
			bash = { "shellcheck" },
			css = { "stylelint" },
			dockerfile = { "hadolint" },
			less = { "stylelint" },
			markdown = { "markdownlint" },
			python = { "flake8" },
			sass = { "stylelint" },
			scss = { "stylelint" },
			sh = { "shellcheck" },
			yaml = { "yamllint" },
		}
	end,
}

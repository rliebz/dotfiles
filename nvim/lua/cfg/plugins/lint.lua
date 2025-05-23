return {
	"mfussenegger/nvim-lint",
	config = function()
		vim.api.nvim_create_autocmd({ "BufWritePost", "BufReadPost", "InsertLeave" }, {
			group = vim.api.nvim_create_augroup("nvim_lint", {}),
			callback = function() require("lint").try_lint() end,
		})
		require("lint").linters_by_ft = {
			css = { "stylelint" },
			dockerfile = { "hadolint" },
			fish = { "fish" },
			go = { "golangcilint" },
			less = { "stylelint" },
			markdown = { "markdownlint" },
			sass = { "stylelint" },
			scss = { "stylelint" },
			yaml = { "yamllint" },
		}
	end,
}

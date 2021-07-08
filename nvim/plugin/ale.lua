vim.api.nvim_set_keymap("n", "[a", "<Plug>(ale_previous)", {})
vim.api.nvim_set_keymap("n", "]a", "<Plug>(ale_next)", {})
vim.api.nvim_set_keymap("n", "<leader>ad", "<Plug>(ale_detail)", {})

vim.g.ale_disable_lsp = 1
vim.g.ale_fix_on_save = 1

local gutter_info_char = "●"
vim.g.ale_sign_error = gutter_info_char
vim.g.ale_sign_warning = gutter_info_char
vim.g.ale_echo_msg_format = "[%linter%%: code%] %s"

vim.g.ale_linters = {
	sh = { "shellcheck" },
	go = { "golangci-lint" },
	javascript = { "eslint" },
	rust = { "rls" },
	typescript = { "prettier", "tslint", "tsserver" },
}

vim.g.ale_fixers = {
	lua = { "stylua" },
	rust = { "rustfmt" },
}

vim.g.ale_go_golangci_lint_options = ""
vim.g.ale_go_golangci_lint_package = 1
vim.g.ale_rust_rls_toolchain = "stable"

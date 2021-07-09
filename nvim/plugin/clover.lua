function configure_clover()
	vim.api.nvim_buf_set_keymap(0, "n", "<leader>cu", ":CloverUp<CR>", { noremap = true })
	vim.api.nvim_buf_set_keymap(0, "n", "<leader>cd", ":CloverDown<CR>", { noremap = true })
end

vim.cmd([[
augroup vim_go
	autocmd!
	autocmd FileType go lua configure_clover()
augroup END
]])

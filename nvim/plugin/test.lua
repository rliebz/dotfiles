vim.api.nvim_set_keymap("n", "<leader>tn", ":TestNearest<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>tf", ":TestFile<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>ts", ":TestSuite<CR>", { noremap = true })
vim.api.nvim_set_keymap("n", "<leader>tl", ":TestLast<CR>", { noremap = true })

vim.g["test#strategy"] = "floaterm"
vim.g["test#go#gotest#options"] = "-tags integration -count=1"

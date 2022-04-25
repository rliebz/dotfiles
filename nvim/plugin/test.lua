vim.keymap.set("n", "<leader>tn", ":TestNearest<CR>")
vim.keymap.set("n", "<leader>tf", ":TestFile<CR>")
vim.keymap.set("n", "<leader>ts", ":TestSuite<CR>")
vim.keymap.set("n", "<leader>tl", ":TestLast<CR>")

vim.g["test#go#gotest#options"] = {
	all = "-count 1",
	nearest = "-tags integration,e2e",
	file = "-tags integration",
	suite = "-tags integration",
}

vim.pack.add({ "https://github.com/vim-test/vim-test" })

vim.g["test#go#gotest#options"] = {
	all = "-count 1",
	nearest = "-tags blackbox,e2e,integration,integrity,loadtest,qualitrics_integration",
	file = "-tags integration",
	suite = "-tags integration",
}
vim.g["test#javascript#vitest#options"] = "--no-coverage"

vim.keymap.set("n", "<leader>tn", vim.cmd.TestNearest)
vim.keymap.set("n", "<leader>tf", vim.cmd.TestFile)
vim.keymap.set("n", "<leader>ts", vim.cmd.TestSuite)
vim.keymap.set("n", "<leader>tl", vim.cmd.TestLast)

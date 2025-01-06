return {
	"vim-test/vim-test",
	event = "VeryLazy",
	keys = {
		{ "<leader>tn", vim.cmd.TestNearest },
		{ "<leader>tf", vim.cmd.TestFile },
		{ "<leader>ts", vim.cmd.TestSuite },
		{ "<leader>tl", vim.cmd.TestLast },
	},
	init = function()
		vim.g["test#go#gotest#options"] = {
			all = "-count 1",
			nearest = "-tags blackbox,e2e,integration,integrity,loadtest,qualitrics_integration",
			file = "-tags integration",
			suite = "-tags integration",
		}
		vim.g["test#javascript#vitest#options"] = "--no-coverage"
	end,
}

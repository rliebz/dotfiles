return {
	"vim-test/vim-test",
	config = function()
		vim.g["test#go#gotest#options"] = {
			all = "-count 1",
			nearest = "-tags blackbox,e2e,integration,integrity,loadtest,qualitrics_integration",
			file = "-tags integration",
			suite = "-tags integration",
		}
	end,
}

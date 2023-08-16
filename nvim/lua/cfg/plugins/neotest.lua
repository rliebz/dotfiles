return {
	"nvim-neotest/neotest",
	dependencies = {
		"nvim-neotest/nvim-nio",
		"nvim-lua/plenary.nvim",
		"nvim-treesitter/nvim-treesitter",
		"antoinemadec/FixCursorHold.nvim",
		-- Adapters
		"nvim-neotest/neotest-go",
	},
	event = "VeryLazy",
	config = function()
		local neotest_ns = vim.api.nvim_create_namespace("neotest")
		vim.diagnostic.config({
			virtual_text = {
				format = function(diagnostic)
					-- Replace newline and tab characters with space for more compact diagnostics
					local message = diagnostic.message:gsub("\n", " "):gsub("\t", " "):gsub("%s+", " "):gsub("^%s+", "")
					return message
				end,
			},
		}, neotest_ns)

		require("neotest").setup({
			adapters = {
				require("neotest-go")({
					args = {
						"-count=1",
						"-tags integration",
					},
				}),
			},
		})
	end,
	keys = {
		{
			"<leader>tf",
			function() require("neotest").run.run(vim.fn.expand("%")) end,
			desc = "Test File",
		},
		{
			"<leader>ta",
			function() require("neotest").run.run(vim.loop.cwd()) end,
			desc = "Test All Files",
		},
		{
			"<leader>tn",
			function() require("neotest").run.run() end,
			desc = "Test Nearest",
		},
		{
			"<leader>ts",
			function() require("neotest").summary.toggle() end,
			desc = "Toggle Test Summary",
		},
		{
			"<leader>to",
			function() require("neotest").output.open() end,
			desc = "Show Test Output",
		},
		{
			"<leader>tO",
			function() require("neotest").output_panel.toggle() end,
			desc = "Toggle Test Output Panel",
		},
		{
			"<leader>tS",
			function() require("neotest").run.stop() end,
			desc = "Stop Test",
		},
	},
}

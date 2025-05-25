return {
	"nvim-treesitter/nvim-treesitter-textobjects",
	branch = "main",
	opts = {
		select = {
			lookahead = true,
		},
		move = {
			set_jumps = true,
		},
	},
	keys = {
		{
			"<leader>a",
			function() require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner") end,
		},
		{
			"<leader>A",
			function()
				require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.inner")
			end,
		},
		{
			"af",
			function()
				require("nvim-treesitter-textobjects.select").select_textobject(
					"@function.outer",
					"textobjects"
				)
			end,
			mode = { "x", "o" },
		},
		{
			"if",
			function()
				require("nvim-treesitter-textobjects.select").select_textobject(
					"@function.inner",
					"textobjects"
				)
			end,
			mode = { "x", "o" },
		},
		{
			"ac",
			function()
				require("nvim-treesitter-textobjects.select").select_textobject(
					"@class.outer",
					"textobjects"
				)
			end,
			mode = { "x", "o" },
		},
		{
			"ic",
			function()
				require("nvim-treesitter-textobjects.select").select_textobject(
					"@class.inner",
					"textobjects"
				)
			end,
			mode = { "x", "o" },
		},
		{
			"]m",
			function()
				require("nvim-treesitter-textobjects.move").goto_next_start(
					"@function.outer",
					"textobjects"
				)
			end,
			mode = { "n", "x", "o" },
		},
		{
			"]M",
			function()
				require("nvim-treesitter-textobjects.move").goto_next_end(
					"@function.outer",
					"textobjects"
				)
			end,
			mode = { "n", "x", "o" },
		},
		{
			"[m",
			function()
				require("nvim-treesitter-textobjects.move").goto_previous_start(
					"@function.outer",
					"textobjects"
				)
			end,
			mode = { "n", "x", "o" },
		},
		{
			"[M",
			function()
				require("nvim-treesitter-textobjects.move").goto_previous_end(
					"@function.outer",
					"textobjects"
				)
			end,
			mode = { "n", "x", "o" },
		},
		{
			"]]",
			function()
				require("nvim-treesitter-textobjects.move").goto_next_start(
					"@class.outer",
					"textobjects"
				)
			end,
			mode = { "n", "x", "o" },
		},
		{
			"][",
			function()
				require("nvim-treesitter-textobjects.move").goto_next_end(
					"@class.outer",
					"textobjects"
				)
			end,
			mode = { "n", "x", "o" },
		},
		{
			"[[",
			function()
				require("nvim-treesitter-textobjects.move").goto_previous_start(
					"@class.outer",
					"textobjects"
				)
			end,
			mode = { "n", "x", "o" },
		},
		{
			"[]",
			function()
				require("nvim-treesitter-textobjects.move").goto_previous_end(
					"@class.outer",
					"textobjects"
				)
			end,
			mode = { "n", "x", "o" },
		},
	},
}

vim.pack.add(
	{ { src = "https://github.com/nvim-treesitter/nvim-treesitter-textobjects", version = "main" } },
	{ confirm = false }
)

require("nvim-treesitter-textobjects").setup({
	select = {
		lookahead = true,
	},
	move = {
		set_jumps = true,
	},
})

vim.keymap.set(
	"n",
	"<leader>a",
	function() require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner") end
)

vim.keymap.set(
	"n",
	"<leader>A",
	function() require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.inner") end
)
vim.keymap.set(
	{ "x", "o" },
	"af",
	function()
		require("nvim-treesitter-textobjects.select").select_textobject(
			"@function.outer",
			"textobjects"
		)
	end
)
vim.keymap.set(
	{ "x", "o" },
	"if",
	function()
		require("nvim-treesitter-textobjects.select").select_textobject(
			"@function.inner",
			"textobjects"
		)
	end
)
vim.keymap.set(
	{ "x", "o" },
	"ac",
	function()
		require("nvim-treesitter-textobjects.select").select_textobject(
			"@class.outer",
			"textobjects"
		)
	end
)
vim.keymap.set(
	{ "x", "o" },
	"ic",
	function()
		require("nvim-treesitter-textobjects.select").select_textobject(
			"@class.inner",
			"textobjects"
		)
	end
)
vim.keymap.set(
	{ "n", "x", "o" },
	"]m",
	function()
		require("nvim-treesitter-textobjects.move").goto_next_start(
			"@function.outer",
			"textobjects"
		)
	end
)
vim.keymap.set(
	{ "n", "x", "o" },
	"]M",
	function()
		require("nvim-treesitter-textobjects.move").goto_next_end("@function.outer", "textobjects")
	end
)
vim.keymap.set(
	{ "n", "x", "o" },
	"[m",
	function()
		require("nvim-treesitter-textobjects.move").goto_previous_start(
			"@function.outer",
			"textobjects"
		)
	end
)
vim.keymap.set(
	{ "n", "x", "o" },
	"[M",
	function()
		require("nvim-treesitter-textobjects.move").goto_previous_end(
			"@function.outer",
			"textobjects"
		)
	end
)
vim.keymap.set(
	{ "n", "x", "o" },
	"]]",
	function()
		require("nvim-treesitter-textobjects.move").goto_next_start("@class.outer", "textobjects")
	end
)
vim.keymap.set(
	{ "n", "x", "o" },
	"][",
	function()
		require("nvim-treesitter-textobjects.move").goto_next_end("@class.outer", "textobjects")
	end
)
vim.keymap.set(
	{ "n", "x", "o" },
	"[[",
	function()
		require("nvim-treesitter-textobjects.move").goto_previous_start(
			"@class.outer",
			"textobjects"
		)
	end
)
vim.keymap.set(
	{ "n", "x", "o" },
	"[]",
	function()
		require("nvim-treesitter-textobjects.move").goto_previous_end("@class.outer", "textobjects")
	end
)

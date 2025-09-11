return {
	"nvim-mini/mini.ai",
	opts = function()
		local ai = require("mini.ai")
		return {
			n_lines = 500,
			custom_textobjects = {
				-- Argument with better whitespace handling
				a = ai.gen_spec.argument({ separator = "%s*,%s*" }),
				-- Class
				c = ai.gen_spec.treesitter({ a = "@class.outer", i = "@class.inner" }, {}),
				-- Digits
				d = { "%f[%d]%d+" },
				-- Function
				f = ai.gen_spec.treesitter({ a = "@function.outer", i = "@function.inner" }, {}),
				-- Whole buffer (gg -> G)
				g = function()
					return {
						from = { line = 1, col = 1 },
						to = {
							line = vim.fn.line("$"),
							col = math.max(vim.fn.getline("$"):len(), 1),
						},
					}
				end,
			},
		}
	end,
}

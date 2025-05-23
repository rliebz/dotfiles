local ignored_file_patterns = {
	"^__pycache__$",
	"^%.DS_Store$",
	"^%.git$",
	"^%.gitmodules$",
	"^%.pytest_cache$",
	"^%.vscode$",
	"%.bak$",
	"%.log$",
	"%.pid$",
	"%.pyc$",
}

return {
	"stevearc/oil.nvim",
	init = function()
		vim.keymap.set("n", "-", require("oil").open, { desc = "Open parent directory" })
	end,
	opts = {
		columns = {
			{ "icon", add_padding = false },
		},
		win_options = {
			concealcursor = "nvic",
			number = false,
			signcolumn = "yes",
		},
		view_options = {
			is_hidden_file = function(name)
				for _, pattern in ipairs(ignored_file_patterns) do
					if string.match(name, pattern) then
						return true
					end
				end
				return false
			end,
		},
		delete_to_trash = true,
		skip_confirm_for_simple_edits = true,
		keymaps = {
			["g."] = false,
			["<C-t>"] = false,
			["<C-p>"] = false,
			["<C-c>"] = false,
			["<C-h>"] = false,
			["<C-s>"] = false,
		},
	},
}

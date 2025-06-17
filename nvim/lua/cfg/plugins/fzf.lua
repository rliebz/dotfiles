local colors = require("cfg.colors")

---Convert a colorscheme color into an rg-compatible format.
---@param color string The color in #rrggbb format
---@return string
local function rg_color(color)
	local r, g, b = color:match("#(..)(..)(..)")
	if not r or not g or not b then
		error("Invalid color format. Expected '#rrggbb'.")
	end

	return string.format("0x%s,0x%s,0x%s", r, g, b)
end

return {
	"ibhagwan/fzf-lua",
	event = "VeryLazy",
	keys = {
		{ "<leader>sh", "<cmd>FzfLua help_tags<cr>", desc = "[S]earch [H]elp" },
		{ "<leader>sf", "<cmd>FzfLua files<cr>", desc = "[S]earch [F]iles" },
		{ "<leader>sg", "<cmd>FzfLua live_grep<cr>", desc = "[S]each by [G]rep" },
		{ "<leader>sr", "<cmd>FzfLua resume<cr>", desc = "[S]earch [R]esume" },
		{ "<leader>sp", "<cmd>FzfLua<cr>", desc = "[S]earch [P]ickers" },
	},
	opts = {
		keymap = {
			fzf = {
				["ctrl-q"] = "select-all+accept",
			},
		},
		winopts = {
			col = 0.5,
			height = 0.9,
			width = 0.9,
			preview = {
				horizontal = "right:50%",
			},
		},
		defaults = {
			no_header = true,
		},
		lines = {
			winopts = {
				treesitter = false,
			},
		},
		previewers = {
			builtin = {
				snacks_image = {
					enabled = false,
				},
			},
		},
		grep = {
			hidden = true,
			winopts = {
				treesitter = true,
			},
			rg_opts = vim.iter({
				-- Extra flags
				"-g",
				"!.git",
				-- Colors
				"--colors=match:none",
				"--colors=match:style:bold",
				"--colors=match:bg:" .. rg_color(colors.highlight_light_blue),
				"--colors=path:fg:" .. rg_color(colors.blue),
				"--colors=line:fg:" .. rg_color(colors.cyan),
				"--colors=column:fg:" .. rg_color(colors.dark_green),
				-- Default flags
				"--column",
				"--line-number",
				"--no-heading",
				"--color=always",
				"--smart-case",
				"--max-columns=4096",
				"-e",
			}):join(" "),
		},
	},
}

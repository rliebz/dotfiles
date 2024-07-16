vim.keymap.set("", "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.cmd.colorscheme("dots")

vim.o.colorcolumn = "80"
vim.opt.completeopt = { "menuone", "noselect" }
vim.o.cursorline = true
vim.opt.diffopt:append("vertical")
vim.opt.fileformats = { "unix", "dos", "mac" }
vim.opt.fillchars = { foldopen = "", foldclose = "", diff = "╱" }
vim.o.foldcolumn = "auto:1"
vim.o.ignorecase = true
vim.o.list = true
vim.opt.listchars = { tab = "⟶ ", space = "·", trail = "·", nbsp = "␣" }
vim.o.matchtime = 2
vim.o.mouse = ""
vim.o.number = true
vim.o.scrolloff = 5
vim.o.showmatch = true
vim.o.showmode = false
vim.o.signcolumn = "yes"
vim.o.smartcase = true
vim.o.shiftwidth = 0
vim.opt.shortmess:append("c")
vim.o.softtabstop = -1
vim.o.swapfile = false
vim.o.tabstop = 2
vim.o.updatetime = 100
vim.o.wrap = false

-- Restore cursor position when opening new files
local augroup_cursor_position = vim.api.nvim_create_augroup("cursor_position", {})
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		vim.api.nvim_create_autocmd("FileType", {
			group = augroup_cursor_position,
			buffer = 0,
			once = true,
			callback = function()
				if vim.o.filetype == "gitcommit" or vim.o.filetype == "gitrebase" then
					return
				end

				local last = vim.fn.line([['"]])
				if last >= 1 and last <= vim.fn.line("$") then
					vim.cmd.normal({ [[g`"']], bang = true })
				end
			end,
		})
	end,
})

vim.g.sql_type_default = "postgresql"

vim.keymap.set("", "j", "gj")
vim.keymap.set("", "k", "gk")

vim.keymap.set("n", "<leader>V", "<Cmd>source $MYVIMRC<CR>", { desc = "Reload configuration" })
vim.keymap.set("n", "<leader>qq", "<Cmd>cclose | pclose | helpclose<CR>", { desc = "Close windows" })
vim.keymap.set("n", "<leader>ss", "<Cmd>setlocal spell!<CR>", { desc = "Toggle spelling" })
vim.keymap.set("n", "<leader>hi", "<Cmd>Inspect<CR>", { desc = "Inspect" })
vim.keymap.set("n", "<C-s>", "<Cmd>w!<CR>", { desc = "Save buffer" })
vim.keymap.set("", "gy", '"+y')
vim.keymap.set("", "gp", '"+p')
vim.keymap.set("", "gP", '"+P')

vim.keymap.set("n", "<leader>di", vim.diagnostic.open_float, { desc = "Diagnostic info", silent = true })
vim.keymap.set(
	"n",
	"<leader>de",
	function() vim.diagnostic.enable(true) end,
	{ desc = "Enable diagnostics", silent = true }
)
vim.keymap.set(
	"n",
	"<leader>dd",
	function() vim.diagnostic.enable(false) end,
	{ desc = "Disable diagnostics", silent = true }
)

vim.keymap.set("n", "<leader>l", "<Cmd>Lazy<CR>", { desc = "Open Lazy" })

vim.diagnostic.config({
	float = {
		border = "rounded",
		format = function(diagnostic)
			if diagnostic.code then
				return string.format("[%s: %s] %s", diagnostic.source, diagnostic.code, diagnostic.message)
			end

			return string.format("[%s] %s", diagnostic.source, diagnostic.message)
		end,
	},
	severity_sort = true,
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "●",
			[vim.diagnostic.severity.WARN] = "●",
			[vim.diagnostic.severity.INFO] = "●",
			[vim.diagnostic.severity.HINT] = "●",
		},
	},
})

require("cfg.lazy")

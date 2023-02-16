vim.keymap.set("", "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

if vim.env.COLORTERM == "truecolor" then
	vim.o.termguicolors = true
end

vim.cmd.colorscheme("dots")

vim.o.colorcolumn = "80"
vim.opt.completeopt = { "menuone", "noselect" }
vim.o.cursorline = true
vim.opt.diffopt:append("vertical")
vim.opt.fileformats = { "unix", "dos", "mac" }
vim.o.ignorecase = true
vim.o.lazyredraw = true
vim.o.list = true
vim.opt.listchars = { tab = "» ", space = "·", trail = "·", nbsp = "␣" }
vim.o.matchtime = 2
vim.o.mouse = ""
vim.go.number = true
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

vim.g.loaded_netrwPlugin = 1

vim.keymap.set("", "j", "gj")
vim.keymap.set("", "k", "gk")

vim.keymap.set("n", "<leader>qq", ":cclose | pclose | helpclose<CR>", { silent = true })
vim.keymap.set("n", "<leader>ss", ":setlocal spell!<CR>", { silent = true })
vim.keymap.set("n", "<leader>v", ":source $MYVIMRC | :runtime! plugin/**/*.lua<CR>", { silent = true })
vim.keymap.set("n", "<leader>w", ":w!<CR>", { silent = true })
vim.keymap.set("", "gy", '"+y')
vim.keymap.set("", "gp", '"+p')
vim.keymap.set("", "gP", '"+P')

vim.keymap.set("n", "<leader>di", vim.diagnostic.open_float, { silent = true })
vim.keymap.set("n", "<leader>de", vim.diagnostic.enable, { silent = true })
vim.keymap.set("n", "<leader>dd", vim.diagnostic.disable, { silent = true })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { silent = true })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { silent = true })

vim.keymap.set("n", "<leader>l", vim.cmd.Lazy)

vim.diagnostic.config({
	float = {
		border = "single",
		format = function(diagnostic)
			if diagnostic.code then
				return string.format("[%s: %s] %s", diagnostic.source, diagnostic.code, diagnostic.message)
			end

			return string.format("[%s] %s", diagnostic.source, diagnostic.message)
		end,
	},
})

require("cfg.lazy")

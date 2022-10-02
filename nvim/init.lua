vim.keymap.set("", "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

if vim.env.COLORTERM == "truecolor" then
	vim.opt.termguicolors = true
end

vim.cmd([[colorscheme dots]])

vim.opt.cinwords = {}
vim.opt.colorcolumn = "80"
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.cursorline = true
vim.opt.diffopt:append("vertical")
vim.opt.fileformats = { "unix", "dos", "mac" }
vim.opt.ignorecase = true
vim.opt.lazyredraw = true
vim.opt.list = true
vim.opt.listchars = { tab = "» ", space = "·", trail = "·", nbsp = "␣" }
vim.opt.matchtime = 2
vim.opt.number = true
vim.opt.scrolloff = 5
vim.opt.showmatch = true
vim.opt.showmode = false
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.shiftwidth = 0
vim.opt.shortmess:append("c")
vim.opt.softtabstop = -1
vim.opt.swapfile = false
vim.opt.tabstop = 2
vim.opt.updatetime = 100

-- Restore cursor position when opening new files
local augroup_cursor_position = vim.api.nvim_create_augroup("cursor_position", {})
vim.api.nvim_create_autocmd("BufReadPost", {
	callback = function()
		vim.api.nvim_create_autocmd("FileType", {
			group = augroup_cursor_position,
			buffer = 0,
			once = true,
			callback = function()
				local ft = vim.opt.filetype:get()
				if ft == "gitcommit" or ft == "gitrebase" then
					return
				end

				local last = vim.fn.line([['"]])
				if last >= 1 and last <= vim.fn.line("$") then
					vim.cmd([[exe 'normal! g`"']])
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

vim.keymap.set("n", "<leader>d", vim.diagnostic.open_float, { silent = true })
vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { silent = true })
vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { silent = true })

vim.keymap.set("n", "<leader>ps", function()
	package.loaded["cfg.plugins"] = nil
	require("cfg.plugins").sync()
end)

vim.keymap.set("n", "<leader>pc", function()
	package.loaded["cfg.plugins"] = nil
	require("cfg.plugins").compile()
end)

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

vim.api.nvim_create_user_command("Pack", function()
	vim.notify("DEPRECATED: Use <leader>ps", vim.log.levels.WARN)
	package.loaded["cfg.plugins"] = nil
	require("cfg.plugins").sync()
end, {
	desc = "lua packer.sync()",
})

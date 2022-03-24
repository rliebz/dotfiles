vim.keymap.set("", "<Space>", "<Nop>", { silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

if vim.env.COLORTERM == "truecolor" then
	vim.opt.termguicolors = true
end

vim.cmd([[colorscheme dots]])

vim.opt.cinwords = {}
vim.opt.colorcolumn = "80"
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
vim.opt.shortmess:append("c")
vim.opt.swapfile = false
vim.opt.updatetime = 100

function jump_to_last_position()
	local ft = vim.opt.filetype:get()
	if ft == "gitcommit" or ft == "gitrebase" then
		return
	end

	local last = vim.fn.line([['"]])
	if last >= 1 and last <= vim.fn.line("$") then
		vim.cmd([[exe 'normal! g`"']])
	end
end

vim.cmd([[
augroup restore_cursor
	autocmd!
	autocmd BufReadPost * autocmd FileType <buffer> ++once lua jump_to_last_position()
augroup END
]])

vim.g.loaded_netrwPlugin = 1

vim.keymap.set("", "j", "gj")
vim.keymap.set("", "k", "gk")

vim.keymap.set("n", "<leader>qq", ":cclose <bar> pclose <bar> helpclose<CR>", { silent = true })
vim.keymap.set("n", "<leader>ss", ":setlocal spell!<CR>", { silent = true })
vim.keymap.set("n", "<leader>v", ":source $MYVIMRC<CR> | :runtime! plugin/**/*.lua<CR>", { silent = true })
vim.keymap.set("n", "<leader>w", ":w!<CR>", { silent = true })
vim.keymap.set("", "<leader>y", '"+y')

function pack()
	package.loaded["cfg.plugins"] = nil
	require("cfg.plugins").sync()
end
vim.cmd([[command! Pack lua pack()]])

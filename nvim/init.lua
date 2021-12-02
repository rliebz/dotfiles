vim.api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
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
vim.opt.showmatch = true
vim.opt.showmode = false
vim.opt.signcolumn = "yes"
vim.opt.smartcase = true
vim.opt.smartindent = true
vim.opt.shortmess:append("c")
vim.opt.swapfile = false
vim.opt.updatetime = 100

vim.opt.scrolloff = 5
vim.cmd([[
augroup scroll_off
	autocmd!
	autocmd TermEnter * lua vim.opt.scrolloff = 0
	autocmd TermLeave * lua vim.opt.scrolloff = 5
augroup END
]])

function jump_to_last_position()
	if vim.opt.filetype == "commit" then
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
	autocmd BufReadPost * lua jump_to_last_position()
augroup END
]])

vim.g.loaded_netrwPlugin = 1

vim.api.nvim_set_keymap("", "j", "gj", {})
vim.api.nvim_set_keymap("", "k", "gk", {})

vim.api.nvim_set_keymap("n", "<leader>qq", ":cclose <bar> pclose <bar> helpclose<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>ss", ":setlocal spell!<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>v", ":source $MYVIMRC<CR> | :runtime! plugin/**/*.lua<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>w", ":w!<CR>", { silent = true })
vim.api.nvim_set_keymap("", "<leader>y", '"+y', { noremap = true })

function pack()
	package.loaded["cfg.plugins"] = nil
	require("cfg.plugins").sync()
end
vim.cmd([[command! Pack lua pack()]])

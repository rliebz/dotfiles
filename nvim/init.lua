vim.g.mapleader = " "

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
vim.opt.hidden = true
vim.opt.ignorecase = true
vim.opt.inccommand = "nosplit"
vim.opt.joinspaces = false
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

vim.g.netrw_banner = 0
vim.g.netrw_list_hide = [[\.DS_Store,\.git/,\.gitmodules/,\.vscode/,__pycache__/,\.log,\.pid]]

vim.api.nvim_set_keymap("", "j", "gj", {})
vim.api.nvim_set_keymap("", "k", "gk", {})

vim.api.nvim_set_keymap("n", "<leader>e", ":Explore<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>qq", ":cclose <bar> pclose <bar> helpclose<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>ss", ":setlocal spell!<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>v", ":luafile $MYVIMRC<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<leader>w", ":w!<CR>", { silent = true })
vim.api.nvim_set_keymap("", "<leader>y", '"+y', { noremap = true })

require("cfg.reload")
reload()

vim.cmd([[command! Pack lua require('cfg.plugins').sync()]])
vim.cmd([[
augroup packer_compile
	autocmd!
	autocmd BufWritePost */cfg/plugins.lua,*/cfg/plugin/*.lua lua reload(); require('cfg.plugins').compile()
augroup END
]])

if vim.fn.filereadable(os.getenv("HOME") .. "/vimrc.lua") then
	vim.cmd([[source ~/.vimrc.lua]])
end

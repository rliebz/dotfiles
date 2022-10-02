if vim.fn.filereadable(os.getenv("HOME") .. "/.vimrc.lua") == 1 then
	vim.cmd.source("~/.vimrc.lua")
end

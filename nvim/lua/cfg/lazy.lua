local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable",
		lazypath,
	})
end
vim.opt.runtimepath:prepend(lazypath)

require("lazy").setup("cfg.plugins", {
	install = { colorscheme = { "dots" } },
	ui = { border = "rounded" },
	concurrency = 8,
	change_detection = {
		notify = false,
	},
})

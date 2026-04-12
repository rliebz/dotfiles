vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		if ev.data.path ~= "nvim-treesitter" then
			return
		end

		if ev.data.kind == "update" then
			vim.cmd.TSUpdate()
		end
	end,
})

vim.pack.add({
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
	"https://github.com/windwp/nvim-ts-autotag",
})

require("nvim-ts-autotag").setup({})

vim.treesitter.language.register("hcl", "nomad")
local ignore_install = {
	"dockerfile",
}
local disable_indent = {
	"markdown",
	"sql",
	"yaml",
}

local nvim_treesitter = require("nvim-treesitter")
local available = nvim_treesitter.get_available()

vim.api.nvim_create_autocmd("FileType", {
	callback = function(ev)
		local lang = vim.treesitter.language.get_lang(vim.bo.filetype)
		if not lang or vim.list_contains(ignore_install, lang) then
			return
		end

		if not vim.list_contains(available, lang) then
			return
		end

		local installed = nvim_treesitter.get_installed()
		if not vim.list_contains(installed, lang) then
			nvim_treesitter.install({ lang }):wait(30000)
		end

		if not vim.treesitter.language.add(lang) then
			return
		end

		vim.treesitter.start(ev.buf, lang)
		vim.opt_local.foldmethod = "expr"
		vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
		vim.opt_local.foldtext = ""

		if not vim.list_contains(disable_indent, lang) then
			vim.opt_local.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
		end
	end,
})

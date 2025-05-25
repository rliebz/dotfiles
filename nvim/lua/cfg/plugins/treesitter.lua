return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	dependencies = {
		{ "windwp/nvim-ts-autotag", opts = {} },
	},
	build = ":TSUpdate",
	init = function()
		vim.treesitter.language.register("hcl", "nomad")
		local ignore_install = {
			"docker",
		}
		local disable_indent = {
			"sql",
			"yaml",
		}

		vim.api.nvim_create_autocmd("FileType", {
			callback = function(ev)
				local lang = vim.treesitter.language.get_lang(vim.bo.filetype)
				if vim.list_contains(ignore_install, lang) then
					return
				end

				require("nvim-treesitter").install({ lang }):wait(30000)
				if not pcall(vim.treesitter.get_parser, ev.buf) then
					return
				end

				vim.treesitter.start()
				vim.opt_local.foldmethod = "expr"
				vim.opt_local.foldexpr = "v:lua.vim.treesitter.foldexpr()"
				vim.opt_local.foldtext = ""

				if not vim.list_contains(disable_indent, lang) then
					vim.opt_local.indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
				end
			end,
		})
	end,
}

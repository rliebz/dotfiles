vim.api.nvim_set_keymap("n", "<leader>e", ":Dirvish %:h<CR>", { silent = true })

local ignored = {
	[[\.DS_Store]],
	[[\.git/]],
	[[\.gitmodules/]],
	[[\.pytest_cache/]],
	[[\.vscode/]],
	[[__pycache__/]],
	[[\.log]],
	[[\.pid]],
	[[\.pyc]],
}

local cmds = {
	"sort",
	"sort ;.*/;",
	string.format("silent keeppattern g;%s;d", table.concat(ignored, [[\|]])),
}

vim.g.dirvish_mode = ":" .. table.concat(cmds, "|")

function dirvish_rename()
	local path = vim.fn.getline(".")

	local target = vim.fn.input("Rename: ", path)
	vim.cmd("mode")

	vim.fn.system({ "mv", path, target })
	vim.cmd("Dirvish %")
end

function dirvish_delete()
	local confirm = vim.fn.input("Confirm deletion [y/n]: ")
	vim.cmd("mode")

	if confirm ~= "y" then
		print("Canceled")
		return
	end

	local path = vim.fn.getline(".")

	local rm = "rm"
	if vim.fn.executable("trash") then
		rm = "trash"
	elseif string.sub(path, -1) == "/" then
		rm = "rmdir"
	end

	vim.fn.system({ rm, path })
	vim.cmd("Dirvish %")
end

function dirvish_mkdir()
	local dirname = vim.fn.input("Directory name: ")
	vim.cmd("mode")

	vim.fn.system({ "mkdir", dirname })
	vim.cmd("Dirvish %")
end

function dirvish_mkfile()
	local filename = vim.fn.input("File name: ")

	if filename == "" then
		print("Canceled")
		return
	end

	vim.cmd("e " .. filename)
end

function dirvish_config()
	vim.cmd("setlocal nonumber")

	vim.api.nvim_buf_del_keymap(0, "", "<C-p>")

	vim.api.nvim_buf_set_keymap(0, "n", "R", ":lua dirvish_rename()<CR>", { silent = true })
	vim.api.nvim_buf_set_keymap(0, "n", "D", ":lua dirvish_delete()<CR>", { silent = true })
	vim.api.nvim_buf_set_keymap(0, "n", "d", ":lua dirvish_mkdir()<CR>", { nowait = true, silent = true })
	vim.api.nvim_buf_set_keymap(0, "n", "%", ":lua dirvish_mkfile()<CR>", { silent = true })
	vim.api.nvim_buf_set_keymap(0, "n", "<C-l>", ":Dirvish %<CR>", { silent = true })
end

vim.cmd([[
augroup filetype_dirvish
	autocmd!
	autocmd Filetype dirvish silent! lua dirvish_config()
augroup END
]])

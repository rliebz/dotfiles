vim.keymap.set("n", "<leader>e", ":Dirvish %:h<CR>", { silent = true })

local ignored = {
	[[\.DS_Store]],
	[[\.git/]],
	[[\.gitmodules/]],
	[[\.pytest_cache/]],
	[[\.vscode/]],
	[[__pycache__/]],
	[[\.bak]],
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

	vim.fn.system({ "mkdir", vim.fn.expand("%") .. dirname })
	vim.cmd("Dirvish %")
end

function dirvish_mkfile()
	local filename = vim.fn.input("File name: ")

	if filename == "" then
		print("Canceled")
		return
	end

	vim.cmd("e " .. vim.fn.expand("%") .. filename)
end

function dirvish_config()
	vim.cmd("setlocal nonumber")

	vim.keymap.del("", "<C-p>", { buffer = true })

	vim.keymap.set("n", "R", dirvish_rename, { buffer = true, silent = true })
	vim.keymap.set("n", "D", dirvish_delete, { buffer = true, silent = true })
	vim.keymap.set("n", "d", dirvish_mkdir, { buffer = true, nowait = true, silent = true })
	vim.keymap.set("n", "%", dirvish_mkfile, { buffer = true, silent = true })
	vim.keymap.set("n", "<C-l>", ":Dirvish %<CR>", { buffer = true, silent = true })
end

vim.cmd([[
augroup filetype_dirvish
	autocmd!
	autocmd Filetype dirvish silent! lua dirvish_config()
augroup END
]])

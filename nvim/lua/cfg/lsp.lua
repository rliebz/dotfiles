local M = {}

local function lsp_organize_imports(client, bufnr)
	local params = vim.lsp.util.make_range_params()
	params.context = { only = { "source.organizeImports" } }

	local timeout_ms = 1000
	local resp, err = client.request_sync("textDocument/codeAction", params, timeout_ms, bufnr)
	if err or not resp or resp.err or not resp.result or not resp.result[1] then
		return
	end

	local action = resp.result[1]
	if action.kind and action.kind ~= "source.organizeImports" then
		return
	end

	if action.edit or type(action.command) == "table" then
		if action.edit then
			vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
		end
		if type(action.command) == "table" then
			vim.lsp.buf.execute_command(action.command)
		end
	else
		vim.lsp.buf.execute_command(action)
	end
end

M.bind_keys = function(bufnr)
	local opts = { buffer = bufnr, silent = true }
	vim.keymap.set("n", "<c-]>", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
	vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
	vim.keymap.set({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opts)
	vim.keymap.set("n", "<leader>cA", function()
		vim.lsp.buf.code_action({
			context = {
				only = {
					"source",
				},
				diagnostics = {},
			},
		})
	end, opts)
	vim.keymap.set({ "i", "n" }, "<c-k>", vim.lsp.buf.signature_help, opts)
end

M.organize_imports_on_save = function(client, bufnr)
	local augroup = vim.api.nvim_create_augroup("lsp_organize_imports_" .. client.name, { clear = false })
	vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
	vim.api.nvim_create_autocmd("BufWritePre", {
		group = augroup,
		buffer = bufnr,
		callback = function()
			if client.supports_method("textDocument/codeAction") then
				lsp_organize_imports(client, bufnr)
			end
		end,
	})
end

return M

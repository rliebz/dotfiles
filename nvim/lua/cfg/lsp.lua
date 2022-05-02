local M = {}

function lsp_organize_imports()
	local params = vim.lsp.util.make_range_params()
	params.context = { only = { "source.organizeImports" } }

	local timeout_ms = 1000
	local resp = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
	if not resp then
		return
	end

	-- Assume we have at most one LSP that can organize imports.
	-- If not, just do the first one and ignore the rest.
	local client_id, result = next(resp)
	if not result or not result.result or not result.result[1] then
		return
	end

	local action = result.result[1]
	if action.kind and action.kind ~= "source.organizeImports" then
		return
	end

	if action.edit or type(action.command) == "table" then
		if action.edit then
			local client = vim.lsp.get_client_by_id(client_id)
			vim.lsp.util.apply_workspace_edit(action.edit, client.offset_encoding)
		end
		if type(action.command) == "table" then
			vim.lsp.buf.execute_command(action.command)
		end
	else
		vim.lsp.buf.execute_command(action)
	end
end

M.bind_keys = function(client)
	local opts = { buffer = true, silent = true }
	vim.keymap.set("n", "<c-]>", vim.lsp.buf.definition, opts)
	vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
	vim.keymap.set("n", "gt", vim.lsp.buf.type_definition, opts)
	vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
	vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, opts)
	vim.keymap.set({ "i", "n" }, "<c-k>", vim.lsp.buf.signature_help, opts)
end

M.format_on_save = function(client)
	if client.supports_method("textDocument/formatting") then
		vim.cmd([[
		augroup lsp_format
			autocmd! * <buffer>
			autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_seq_sync()
		augroup END
		]])
	end
end

M.organize_imports_on_save = function(client)
	if client.supports_method("textDocument/codeAction") then
		vim.cmd([[
		augroup lsp_organize_imports
			autocmd! * <buffer>
			autocmd BufWritePre <buffer> lua lsp_organize_imports()
		augroup END
		]])
	end
end

return M

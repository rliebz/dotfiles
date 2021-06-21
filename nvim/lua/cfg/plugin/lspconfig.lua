local lspconfig = require'lspconfig'

function lsp_organize_imports()
  local params = vim.lsp.util.make_range_params()
  params.context = { only = { 'source.organizeImports' } }

  local timeout_ms = 1000
  local resp = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
  if not resp then return end

  -- Assume we have at most one LSP that can organize imports.
  -- If not, just do the first one and ignore the rest.
  local _, result = next(resp)
  if not result or not result.result or not result.result[1] then return end

  local action = result.result[1]
  if action.kind and action.kind ~= 'source.organizeImports' then return end

  if action.edit or type(action.command) == "table" then
    if action.edit then
      vim.lsp.util.apply_workspace_edit(action.edit)
    end
    if type(action.command) == "table" then
      vim.lsp.buf.execute_command(action.command)
    end
  else
    vim.lsp.buf.execute_command(action)
  end
end

local function on_attach(client, bufnr)
  local function noremap(mode, key, value)
    vim.api.nvim_buf_set_keymap(bufnr, mode, key, value, { noremap = true})
  end

  noremap('n', '<c-]>',      '<cmd>lua vim.lsp.buf.definition()<CR>')
  noremap('n', 'K',          '<cmd>lua vim.lsp.buf.hover()<CR>')
  noremap('n', 'gr',         '<cmd>lua vim.lsp.buf.references()<CR>')
  noremap('n', 'gi',         '<cmd>lua vim.lsp.buf.implementation()<CR>')
  noremap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
  noremap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')
  noremap('n', '<C-k>',      '<cmd>lua vim.lsp.buf.signature_help()<CR>')
  noremap('i', '<C-k>',      '<cmd>lua vim.lsp.buf.signature_help()<CR>')

  if client.resolved_capabilities.code_action then
    vim.cmd([[
      augroup lsp_organize_imports
        autocmd! * <buffer>
        autocmd BufWritePre <buffer> lua lsp_organize_imports()
      augroup END
    ]])
  end

  if client.resolved_capabilities.document_formatting then
    vim.cmd([[
      augroup lsp_format
        autocmd! * <buffer>
        autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
      augroup END
    ]])
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {
    'documentation',
    'detail',
    'additionalTextEdits',
  },
}

lspconfig.util.default_config = vim.tbl_extend(
  "force",
  lspconfig.util.default_config,
  {
    on_attach = on_attach,
    capabilities = capabilities,
  }
)

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(
  vim.lsp.handlers.hover, {
    border = 'single',
  }
)

vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(
  vim.lsp.handlers.signature_help, {
    border = 'single',
  }
)

local lspconfig = require'lspconfig'

function lsp_organize_imports()
  local context = { source = { organizeImports = true } }
  vim.validate { context = { context, "table", true } }

  local params = vim.lsp.util.make_range_params()
  params.context = context

  local timeout_ms = 1000
  local resp = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, timeout_ms)
  if not resp then return end

  -- Assume we have at most one LSP that can organize imports.
  -- If not, just do the first one and ignore the rest.
  local _, result = next(resp)
  if not result or not result.result or not result.result[1] then return end

  local action = result.result[1]
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
  require'completion'.on_attach()

  local function nnoremap(key, value)
    vim.api.nvim_buf_set_keymap(bufnr, 'n', key, value, { noremap = true})
  end

  nnoremap('<c-]>',      '<cmd>lua vim.lsp.buf.definition()<CR>')
  nnoremap('K',          '<cmd>lua vim.lsp.buf.hover()<CR>')
  nnoremap('gr',         '<cmd>lua vim.lsp.buf.references()<CR>')
  nnoremap('gi',         '<cmd>lua vim.lsp.buf.implementation()<CR>')
  nnoremap('<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
  nnoremap('<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')

  if client.resolved_capabilities.code_action then
    vim.api.nvim_exec([[
      augroup lsp_organize_imports
        autocmd! * <buffer>
        autocmd BufWritePre <buffer> lua lsp_organize_imports()
      augroup END
    ]], false)
  end

  if client.resolved_capabilities.document_formatting then
    vim.api.nvim_exec([[
      augroup lsp_format
        autocmd! * <buffer>
        autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
      augroup END
    ]], false)
  end
end

-- Opt in to snippets explicitly, because we use a plugin that supports them.
-- See: https://github.com/neovim/neovim/pull/13183
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig.util.default_config = vim.tbl_extend(
  "force",
  lspconfig.util.default_config,
  {
    on_attach = on_attach,
    capabilities = capabilities,
  }
)

require'lspconfig'.bashls.setup{}
require'lspconfig'.gopls.setup{
  settings = {
    gopls = {
      linksInHover = false,
      buildFlags = {
        -- Enable common build flags used for test files
        '-tags=e2e,integration,integrity',
      },
      gofumpt = true,
    },
  },
}
require'lspconfig'.tsserver.setup{}

require'nvim-ale-diagnostic'

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = false,
    virtual_text = false,
    signs = true,
    update_in_insert = false,
  }
)

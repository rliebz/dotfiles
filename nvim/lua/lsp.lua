local lspconfig = require'lspconfig'

function lsp_organize_imports()
  local context = { source = { organizeImports = true } }
  vim.validate { context = { context, "table", true } }

  local params = vim.lsp.util.make_range_params()
  params.context = context

  local method = "textDocument/codeAction"
  local timeout = 1000 -- ms

  local resp = vim.lsp.buf_request_sync(0, method, params, timeout)
  if not resp or not resp[1] then return end

  local result = resp[1].result
  if not result or not result[1] then return end

  local edit = result[1].edit
  vim.lsp.util.apply_workspace_edit(edit)
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
    require('lspconfig').util.nvim_multiline_command [[
      augroup lsp_organize_imports
        autocmd!
        autocmd BufWritePre <buffer> lua lsp_organize_imports()
      augroup END
    ]]
  end

  if client.resolved_capabilities.document_formatting then
    require('lspconfig').util.nvim_multiline_command [[
      augroup lsp_format
        autocmd!
        autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
      augroup END
    ]]
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

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
    underline = false,
    virtual_text = false,
    signs = true,
    update_in_insert = false,
  }
)

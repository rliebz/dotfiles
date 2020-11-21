local lspconfig = require'lspconfig'

local function on_attach()
  require'completion'.on_attach()

  local function nnoremap(key, value)
    vim.api.nvim_buf_set_keymap(0, 'n', key, value, { noremap = true})
  end

  nnoremap('<c-]>',      '<cmd>lua vim.lsp.buf.definition()<CR>')
  nnoremap('K',          '<cmd>lua vim.lsp.buf.hover()<CR>')
  nnoremap('gr',         '<cmd>lua vim.lsp.buf.references()<CR>')
  nnoremap('<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>')
  nnoremap('<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>')

  vim.api.nvim_command[[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()]]
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

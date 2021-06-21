local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local language_configs = {
  ['go'] = {
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
  },
  ['lua'] = {
    settings = {
      Lua = {
        runtime = {
          version = 'LuaJIT',
          path = runtime_path,
        },
        diagnostics = {
          globals = {'vim'},
          disable = {'lowercase-global'}
        },
        workspace = {
          library = vim.api.nvim_get_runtime_file("", true),
          preloadFileSize = 1000,
        },
        telemetry = {
          enable = false,
        },
      },
    },
  },
}

local lspinstall = require('lspinstall')
local lspconfig = require('lspconfig')

local function setup_servers()
  lspinstall.setup()

  local servers = lspinstall.installed_servers()
  for _, server in ipairs(servers) do
    local config = language_configs[server]
    lspconfig[server].setup(config or {})
  end
end

setup_servers()

lspinstall.post_install_hook = function()
  setup_servers()
  vim.cmd('bufdo e')
end

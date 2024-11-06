local config = require("plugins.configs.lspconfig")

local on_attach = config.on_attach
local capabilities = config.capabilities

local lspconfig = require("lspconfig")

lspconfig.pyright.setup({
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {"python"},
})

lspconfig.ruff.setup{
  on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    client.server_capabilities.documentFormattingProvider = true
  end,
  capabilities = capabilities,
  filetypes = {"python"},
  init_options = {
    settings = {
      args = {},
    }
  }
}

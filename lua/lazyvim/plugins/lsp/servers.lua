-- Add any servers here together with their settings
local servers = {
  bashls = {},
  -- clangd = {},
  -- cssls = {},
  -- tsserver = {},
  -- html = {},
  -- jsonls = {},
  pyright = {},
  yamlls = {},
  sumneko_lua = {
    settings = {
      Lua = {
        diagnostics = {
          globals = { "vim" },
        },
      },
    },
  },
}

return servers

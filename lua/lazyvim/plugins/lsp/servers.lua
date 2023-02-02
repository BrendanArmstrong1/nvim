local util = require("lspconfig/util")
-- Add any servers here together with their settings
local servers = {
  bashls = {},
  -- clangd = {},
  -- cssls = {},
  -- tsserver = {},
  -- html = {},
  rust_analyzer = {
    ["rust-analyzer"] = {
      assist = {
        importEnforceGranularity = true,
        importPrefix = "crate",
      },
      cargo = {
        features = "all",
      },
      checkOnSave = {
        overrideCommand = { "cargo", "clippy", "--message-format=json" },
      },
      inlayHints = {
        lifetimeElisionHints = {
          enable = true,
          useParameterNames = true,
        },
      },
    },
  },
  pyright = {
    root_dir = function(fname)
      local root_files = {
        ".git",
        "pyproject.toml",
        "setup.py",
        "setup.cfg",
        "requirements.txt",
        "Pipfile",
        "pyrightconfig.json",
      }
      return util.root_pattern(root_files.unpack)(fname) or util.find_git_ancestor(fname) or util.path.dirname(fname)
    end,
  },
  -- yamlls = {},
  -- selene = {},
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

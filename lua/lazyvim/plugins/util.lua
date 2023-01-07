return
  {
    -- surround
    {
      "echasnovski/mini.surround",
      keys = { "gz", "dz", "cz", "vz", { "Z", ":<C-u>lua MiniSurround.add('visual')<CR>", mode = "x" } },
      init = function()
        -- Remap adding surrounding to Visual mode selection
        -- vim.api.nvim_set_keymap("x", "Z", [[:<C-u>lua MiniSurround.add('visual')<CR>]], { noremap = true })
        -- Make special mapping for "add surrounding for line"
        vim.api.nvim_set_keymap("n", "gzz", "gz_", { noremap = false })
      end,
      config = function()
        -- use gz mappings instead of s to prevent conflict with leap
        require("mini.surround").setup({
          mappings = {
            add = "gz", -- Add surrounding in Normal and Visual modes
            delete = "dz", -- Delete surrounding
            find = "", -- Find surrounding (to the right)
            find_left = "", -- Find surrounding (to the left)
            highlight = "vz", -- Highlight surrounding
            replace = "cz", -- Replace surrounding
            update_n_lines = "", -- Update `n_lines`
          },
        })
      end,
    },
    -- comments
    { "JoosepAlviste/nvim-ts-context-commentstring" },
    {
      "echasnovski/mini.comment",
      event = "VeryLazy",
      config = function()
        require("mini.comment").setup({
          hooks = {
            pre = function()
              require("ts_context_commentstring.internal").update_commentstring({})
            end,
          },
        })
      end,
    },

    -- auto pairs
    {
      "echasnovski/mini.pairs",
      event = "VeryLazy",
      config = function()
        require("mini.pairs").setup({})
      end,
    },

    -- Split Join
    {
      "Wansmer/treesj",
      cmd = {
        "TSJToggle",
        "TSJSplit",
        "TSJJoin",
      },
      keys = {
        { "GS", "<cmd>TSJSplit<cr>" },
        { "J", "<cmd>TSJJoin<cr>" },
        { "GJ", "<cmd>TSJToggle<cr>" },
      },
      config = function()
        require("treesj").setup({
          -- Use default keymaps
          -- (<space>m - toggle, <space>j - join, <space>s - split)
          use_default_keymaps = false,

          -- Node with syntax error will not be formatted
          check_syntax_error = true,

          -- If line after join will be longer than max value,
          -- node will not be formatted
          max_join_length = 120,

          -- hold|start|end:
          -- hold - cursor follows the node/place on which it was called
          -- start - cursor jumps to the first symbol of the node being formatted
          -- end - cursor jumps to the last symbol of the node being formatted
          cursor_behavior = "hold",

          -- Notify about possible problems or not
          notify = true,
          -- langs = langs,
        })
      end,
    },
  }

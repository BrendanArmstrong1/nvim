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
      keys = { { "gc", mode = { "n", "x" } } },
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
      "windwp/nvim-autopairs",
      event = "InsertEnter",
      config = function()
        require("nvim-autopairs").setup({
          disable_filetype = { "TelescopePrompt" },
          disable_in_macro = false, -- disable when recording or executing a macro
          disable_in_visualblock = false, -- disable when insert after visual block mode
          disable_in_replace_mode = true,
          ignored_next_char = [=[[%w%%%'%[%"%.%`%$]]=],
          enable_moveright = true,
          enable_afterquote = true, -- add bracket pairs after quote
          enable_check_bracket_line = true, --- check bracket in same line
          enable_bracket_in_quote = true, --
          enable_abbr = false, -- trigger abbreviation
          break_undo = true, -- switch for basic rule break undo sequence
          check_ts = false,
          map_cr = true,
          map_bs = true, -- map the <BS> key
          map_c_h = false, -- Map the <C-h> key to delete a pair
          map_c_w = false, -- map <c-w> to delete a pair iff possible
        })
        local cmp_autopairs = require("nvim-autopairs.completion.cmp")
        local cmp_status_ok, cmp = pcall(require, "cmp")
        if not cmp_status_ok then
          return
        end
        cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
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
        { "gss", "<cmd>TSJSplit<cr>" },
        { "gsj", "<cmd>TSJJoin<cr>" },
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

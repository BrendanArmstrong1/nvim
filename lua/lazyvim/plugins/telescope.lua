local M = {
  "nvim-telescope/telescope.nvim",
  commit = "0b1c41ad8052badca6e72eafa4bc5481152e483e",
  branch = "0.1.x",
  dependencies = {
    { "nvim-lua/plenary.nvim" },
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  cmd = { "Telescope", "Tel" }, -- lazy loads on these commands
  keys = {
    { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "RG" },
    { "<leader>fg", "<cmd>Telescope git_files<cr>", desc = "Find Git Files" },
    { "<leader>fp", "<cmd>Telescope projects<cr>", desc = "Find Git Files" },
    { "<leader>ff", "<cmd>Telescope find_files<cr>", desc = "Find Files" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
    { "<leader>FB", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
    { "<leader>fc", "<Cmd>Telescope git_commits<CR>", desc = "commits" },
    { "<leader>FG", "<Cmd>Telescope git_status<CR>", desc = "status" },
    { "<leader>FC", "<cmd>Telescope commands<cr>", desc = "Commands" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
    { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
    { "<leader>fl", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
    { "<leader>f;", "<cmd>Telescope command_history<cr>", desc = "Command History" },
    { "<leader>f'", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
    {
      "<leader>fs",
      function()
        require("telescope.builtin").lsp_document_symbols({
          symbols = {
            "Class",
            "Function",
            "Method",
            "Constructor",
            "Interface",
            "Module",
            "Struct",
            "Trait",
            "Field",
            "Property",
          },
        })
      end,
      desc = "Goto Symbol",
    },
  },
}

function M.config()
  local telescope = require("telescope")
  local actions = require("telescope.actions")
  local trouble = require("trouble.providers.telescope")
  telescope.setup({
    defaults = {

      path_display = { "smart" },

      mappings = {
        i = {
          ["<C-n>"] = actions.cycle_history_next,
          ["<C-p>"] = actions.cycle_history_prev,

          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous,

          ["<C-c>"] = actions.close,

          ["<Down>"] = actions.move_selection_next,
          ["<Up>"] = actions.move_selection_previous,

          ["<CR>"] = actions.select_default + actions.center,
          ["<C-x>"] = actions.select_horizontal + actions.center,
          ["<C-v>"] = actions.select_vertical + actions.center,

          ["<C-t>"] = trouble.open_with_trouble,

          ["<C-u>"] = actions.preview_scrolling_up,
          ["<C-d>"] = actions.preview_scrolling_down,

          ["<PageUp>"] = actions.results_scrolling_up,
          ["<PageDown>"] = actions.results_scrolling_down,

          ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
          ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
          ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
          ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          ["<C-l>"] = actions.complete_tag,
          ["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
        },

        n = {
          ["<esc>"] = actions.close,
          ["<CR>"] = actions.select_default + actions.center,
          ["<C-x>"] = actions.select_horizontal + actions.center,
          ["<C-v>"] = actions.select_vertical + actions.center,

          ["<C-t>"] = trouble.open_with_trouble,

          ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
          ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
          ["<C-q>"] = actions.send_to_qflist + actions.open_qflist,
          ["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

          ["j"] = actions.move_selection_next,
          ["k"] = actions.move_selection_previous,
          ["H"] = actions.move_to_top,
          ["M"] = actions.move_to_middle,
          ["L"] = actions.move_to_bottom,

          ["<Down>"] = actions.move_selection_next,
          ["<Up>"] = actions.move_selection_previous,
          ["gg"] = actions.move_to_top,
          ["G"] = actions.move_to_bottom,

          ["<C-u>"] = actions.preview_scrolling_up,
          ["<C-d>"] = actions.preview_scrolling_down,

          ["<PageUp>"] = actions.results_scrolling_up,
          ["<PageDown>"] = actions.results_scrolling_down,

          ["?"] = actions.which_key,
        },
      },
    },
    pickers = {
      -- Default configuration for builtin pickers goes here:
      -- picker_name = {
      --   picker_config_key = value,
      --   ...
      -- }
      -- Now the picker_config_key will be applied every time you call this
      -- builtin picker
    },
    extensions = {
      fzf = {
        fuzzy = true, -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true, -- override the file sorter
        case_mode = "smart_case", -- or "ignore_case" or "respect_case"
        -- the default case_mode is "smart_case"
      },
    },
  })

  require("telescope").load_extension("projects")
  telescope.load_extension("fzf")
end

return M

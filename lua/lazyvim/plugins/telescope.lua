local util = require("lazyvim.util")

local M = {
  'nvim-telescope/telescope.nvim', branch = '0.1.x',
  dependencies = {
    {'nvim-lua/plenary.nvim'},
    {'nvim-telescope/telescope-fzf-native.nvim', build = 'make'},
  },
  cmd = { "Telescope", "Tel" }, -- lazy loads on these commands
  keys = {
    { "<leader>/", util.telescope("live_grep"), desc = "Find in Files (Grep)" },
    { "<leader>fg", util.telescope("git_files"), desc = "Find Git Files" },
    { "<leader>ff", util.telescope("find_files"), desc = "Find Files" },
    { "<leader>fb", "<cmd>Telescope buffers<cr>", desc = "Buffers" },
    { "<leader>fB", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
    { "<leader>fr", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
    { "<leader>fc", "<Cmd>Telescope git_commits<CR>", desc = "commits" },
    { "<leader>fs", "<Cmd>Telescope git_status<CR>", desc = "status" },
    { "<leader>fC", "<cmd>Telescope commands<cr>", desc = "Commands" },
    { "<leader>fh", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
    { "<leader>fk", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
    { "<leader>fl", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
    { "<leader>f;", "<cmd>Telescope command_history<cr>", desc = "Command History" },
    { "<leader>fm", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
    {
      "<leader>fd",
      util.telescope("lsp_document_symbols", {
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
      }),
      desc = "Goto Symbol",
    },
  },
}

function M.config()
  local telescope = require("telescope")
  local actions = require "telescope.actions"
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
          ["<C-t>"] = actions.select_tab + actions.center,

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
          ["<C-t>"] = actions.select_tab + actions.center,

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
        fuzzy = true,                    -- false will only do exact matching
        override_generic_sorter = true,  -- override the generic sorter
        override_file_sorter = true,     -- override the file sorter
        case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
        -- the default case_mode is "smart_case"
      },
    },
  })

  telescope.load_extension('fzf')
  local builtin = require('telescope.builtin')
  local map = vim.keymap.set
  map('n', '<leader>fg', builtin.git_files, {})
  map('n', '<leader>ff', builtin.find_files, {})
  map('n', '<leader>fl', builtin.current_buffer_fuzzy_find, {})
  map('n', '<leader>/', builtin.live_grep, {})
  map('n', '<leader>fb', builtin.buffers, {})
  map('n', '<leader>fh', builtin.help_tags, {})
end

return M

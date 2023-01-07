return {

  -- auto rooting
  {
    "ahmedkhalf/project.nvim",
    event = "BufReadPost",
    config = function()
      require("project_nvim").setup({})
    end,
  },

  -- search/replace in multiple files
  {
    "windwp/nvim-spectre",
    init = function()
      vim.api.nvim_set_keymap("x", "<leader>rr", [[<esc>:lua require('spectre').open_visual()<CR>]], {})
      vim.api.nvim_set_keymap(
        "n",
        "<leader>rb",
        [[<cmd>lua require('spectre').open_visual({select_word=true})<CR>]],
        {}
      )
      vim.api.nvim_set_keymap("n", "<leader>rf", [["syiw<cmd>lua require('spectre').open_file_search()<CR>"sp]], {})
    end,
    keys = {
      { "<leader>r" },
      {
        "<leader>rr",
        function()
          require("spectre").open()
        end,
        desc = "Replace in files (Spectre)",
      },
    },
  },

  -- file explorer
  {
    "nvim-tree/nvim-tree.lua",
    cmd = { "NvimTreeToggle", "NvimTreeFocus", "NvimTreeFindFile", "NvimTreeCallapse" },
    keys = { { "<leader>ft", "<cmd>NvimTreeToggle<cr>" } },
    dependencies = {
      "nvim-tree/nvim-web-devicons", -- optional, for file icons
    },
    config = function()
      require("nvim-tree").setup({
        view = {
          adaptive_size = true,
          mappings = {
              -- stylua: ignore
            list = { -- BEGIN_DEFAULT_MAPPINGS
              { key = { "<CR>", "l", "<2-LeftMouse>" }, action = "edit" },
              { key = "<C-e>",                          action = "edit_in_place" },
              { key = "O",                              action = "edit_no_picker" },
              { key = { ".", "<2-RightMouse>" },        action = "cd" },
              { key = "<C-v>",                          action = "vsplit" },
              { key = "<C-x>",                          action = "split" },
              { key = "<C-t>",                          action = "tabnew" },
              { key = "<",                              action = "prev_sibling" },
              { key = ">",                              action = "next_sibling" },
              { key = "h",                              action = "parent_node" },
              { key = "za",                             action = "close_node" },
              { key = "P",                              action = "preview" },
              { key = "gg",                             action = "first_sibling" },
              { key = "G",                              action = "last_sibling" },
              { key = "C",                              action = "toggle_git_clean" },
              { key = "X",                              action = "toggle_git_ignored" },
              { key = "H",                              action = "toggle_dotfiles" },
              { key = "B",                              action = "toggle_no_buffer" },
              { key = "U",                              action = "toggle_custom" },
              { key = "R",                              action = "refresh" },
              { key = "o",                              action = "create" },
              { key = "D",                              action = "remove" },
              { key = "<C-d>",                          action = "trash" },
              { key = "i",                              action = "rename" },
              { key = "I",                              action = "full_rename" },
              { key = "a",                              action = "rename_basename" },
              { key = "d",                              action = "cut" },
              { key = "c",                              action = "copy" },
              { key = "p",                              action = "paste" },
              { key = "y",                              action = "copy_name" },
              { key = "Y",                              action = "copy_path" },
              { key = "gy",                             action = "copy_absolute_path" },
              { key = "[d",                             action = "prev_diag_item" },
              { key = "[h",                             action = "prev_git_item" },
              { key = "]d",                             action = "next_diag_item" },
              { key = "]h",                             action = "next_git_item" },
              { key = "-",                              action = "dir_up" },
              { key = "s",                              action = "system_open" },
              { key = "f",                              action = "live_filter" },
              { key = "F",                              action = "clear_live_filter" },
              { key = "q",                              action = "close" },
              { key = "zm",                             action = "collapse_all" },
              { key = "zr",                             action = "expand_all" },
              { key = "<C-f>",                          action = "search_node" },
              { key = ":",                              action = "run_file_command" },
              { key = "zt",                             action = "toggle_file_info" },
              { key = "?",                              action = "toggle_help" },
              { key = "'",                              action = "toggle_mark" },
              { key = "gm",                            action = "bulk_move" },
            }, -- END_DEFAULT_MAPPINGS,
          },
        },
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_focused_file = {
          enable = true,
          update_root = true,
        },
      })
    end,
  },
}

return {

  -- auto rooting
  {
    "ahmedkhalf/project.nvim",
    event = "BufReadPost",
    config = function()
      require("project_nvim").setup({
        manual_mode = false,
        detection_methods = { "lsp", "pattern" },
        patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "Cargo.toml" },
        ignore_lsp = {},
        exclude_dirs = { "~/S/Rust/rustlings/" },
      })
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
      { "<leader>r", desc = "spectre" },
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
    keys = { { "<leader>ft", "<cmd>NvimTreeToggle<cr>", desc = "nvim-tree" } },
    config = function()
      require("nvim-tree").setup({
        remove_keymaps = true,
        view = {
          adaptive_size = true,
          mappings = {
              -- stylua: ignore
            list = { -- BEGIN_DEFAULT_MAPPINGS
              { key = { "<CR>", "l", "<2-LeftMouse>" }, action = "edit" },
              { key = "e",                              action = "edit_in_place" },
              { key = "<C-e>",                          action = "edit_no_picker" },
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
        renderer = {
          add_trailing = false,
          group_empty = false,
          highlight_git = false,
          full_name = false,
          highlight_opened_files = "none",
          highlight_modified = "none",
          root_folder_label = ":~:s?$?/..?",
          indent_width = 2,
          indent_markers = {
            enable = false,
            inline_arrows = true,
            icons = {
              corner = "└",
              edge = "│",
              item = "│",
              bottom = "─",
              none = " ",
            },
          },
          icons = {
            webdev_colors = true,
            git_placement = "before",
            modified_placement = "after",
            padding = " ",
            symlink_arrow = " ➛ ",
            show = {
              file = true,
              folder = true,
              folder_arrow = true,
              git = true,
              modified = true,
            },
            glyphs = {
              default = "",
              symlink = "s",
              bookmark = "b",
              modified = "●",
              folder = {
                arrow_closed = "",
                arrow_open = "",
                default = "",
                open = "",
                empty = "",
                empty_open = "",
                symlink = "",
                symlink_open = "",
              },
              git = {
                unstaged = "~",
                staged = "✓",
                unmerged = "",
                renamed = "^",
                untracked = "★",
                deleted = "D",
                ignored = "◌",
              },
            },
          },
          special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
          symlink_destination = true,
        },
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_focused_file = {
          enable = true,
          update_root = true,
        },
        actions = {
          open_file = {
            quit_on_open = true,
          },
        },
      })
    end,
  },
}

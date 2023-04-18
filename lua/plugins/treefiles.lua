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
      vim.api.nvim_set_keymap(
        "x",
        "<leader>rr",
        [[<esc>:lua require('spectre').open_visual()<CR>]],
        { desc = "spectre (visual)" }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>rb",
        [[<cmd>lua require('spectre').open_visual({select_word=true})<CR>]],
        { desc = "spectre with word" }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>rf",
        [["syiw<cmd>lua require('spectre').open_file_search()<CR>"sp]],
        { desc = "spectre in file" }
      )
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
      local function on_attach(bufnr)
        local api = require("nvim-tree.api")

        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end

        -- Default mappings not inserted as:
        --  remove_keymaps = true
        --  OR
        --  view.mappings.custom_only = true

        -- Mappings migrated from view.mappings.list
        --
        -- You will need to insert "your code goes here" for any mappings with a custom action_cb
        vim.keymap.set("n", "<CR>", api.node.open.edit, opts("Open"))
        vim.keymap.set("n", "l", api.node.open.edit, opts("Open"))
        vim.keymap.set("n", "<2-LeftMouse>", api.node.open.edit, opts("Open"))
        vim.keymap.set("n", "e", api.node.open.replace_tree_buffer, opts("Open: In Place"))
        vim.keymap.set("n", "<C-e>", api.node.open.no_window_picker, opts("Open: No Window Picker"))
        vim.keymap.set("n", ".", api.tree.change_root_to_node, opts("CD"))
        vim.keymap.set("n", "<2-RightMouse>", api.tree.change_root_to_node, opts("CD"))
        vim.keymap.set("n", "<C-v>", api.node.open.vertical, opts("Open: Vertical Split"))
        vim.keymap.set("n", "<C-x>", api.node.open.horizontal, opts("Open: Horizontal Split"))
        vim.keymap.set("n", "<C-t>", api.node.open.tab, opts("Open: New Tab"))
        vim.keymap.set("n", "<", api.node.navigate.sibling.prev, opts("Previous Sibling"))
        vim.keymap.set("n", ">", api.node.navigate.sibling.next, opts("Next Sibling"))
        vim.keymap.set("n", "h", api.node.navigate.parent, opts("Parent Directory"))
        vim.keymap.set("n", "za", api.node.navigate.parent_close, opts("Close Directory"))
        vim.keymap.set("n", "P", api.node.open.preview, opts("Open Preview"))
        vim.keymap.set("n", "gg", api.node.navigate.sibling.first, opts("First Sibling"))
        vim.keymap.set("n", "G", api.node.navigate.sibling.last, opts("Last Sibling"))
        vim.keymap.set("n", "C", api.tree.toggle_git_clean_filter, opts("Toggle Git Clean"))
        vim.keymap.set("n", "X", api.tree.toggle_gitignore_filter, opts("Toggle Git Ignore"))
        vim.keymap.set("n", "H", api.tree.toggle_hidden_filter, opts("Toggle Dotfiles"))
        vim.keymap.set("n", "B", api.tree.toggle_no_buffer_filter, opts("Toggle No Buffer"))
        vim.keymap.set("n", "U", api.tree.toggle_custom_filter, opts("Toggle Hidden"))
        vim.keymap.set("n", "R", api.tree.reload, opts("Refresh"))
        vim.keymap.set("n", "o", api.fs.create, opts("Create"))
        vim.keymap.set("n", "D", api.fs.remove, opts("Delete"))
        vim.keymap.set("n", "<C-d>", api.fs.trash, opts("Trash"))
        vim.keymap.set("n", "i", api.fs.rename, opts("Rename"))
        vim.keymap.set("n", "I", api.fs.rename_sub, opts("Rename: Omit Filename"))
        vim.keymap.set("n", "a", api.fs.rename_basename, opts("Rename: Basename"))
        vim.keymap.set("n", "d", api.fs.cut, opts("Cut"))
        vim.keymap.set("n", "c", api.fs.copy.node, opts("Copy"))
        vim.keymap.set("n", "p", api.fs.paste, opts("Paste"))
        vim.keymap.set("n", "y", api.fs.copy.filename, opts("Copy Name"))
        vim.keymap.set("n", "Y", api.fs.copy.relative_path, opts("Copy Relative Path"))
        vim.keymap.set("n", "gy", api.fs.copy.absolute_path, opts("Copy Absolute Path"))
        vim.keymap.set("n", "[d", api.node.navigate.diagnostics.prev, opts("Prev Diagnostic"))
        vim.keymap.set("n", "[h", api.node.navigate.git.prev, opts("Prev Git"))
        vim.keymap.set("n", "]d", api.node.navigate.diagnostics.next, opts("Next Diagnostic"))
        vim.keymap.set("n", "]h", api.node.navigate.git.next, opts("Next Git"))
        vim.keymap.set("n", "-", api.tree.change_root_to_parent, opts("Up"))
        vim.keymap.set("n", "s", api.node.run.system, opts("Run System"))
        vim.keymap.set("n", "f", api.live_filter.start, opts("Filter"))
        vim.keymap.set("n", "F", api.live_filter.clear, opts("Clean Filter"))
        vim.keymap.set("n", "q", api.tree.close, opts("Close"))
        vim.keymap.set("n", "zm", api.tree.collapse_all, opts("Collapse"))
        vim.keymap.set("n", "zr", api.tree.expand_all, opts("Expand All"))
        vim.keymap.set("n", "<C-f>", api.tree.search_node, opts("Search"))
        vim.keymap.set("n", ":", api.node.run.cmd, opts("Run Command"))
        vim.keymap.set("n", "zt", api.node.show_info_popup, opts("Info"))
        vim.keymap.set("n", "?", api.tree.toggle_help, opts("Help"))
        vim.keymap.set("n", "'", api.marks.toggle, opts("Toggle Bookmark"))
        vim.keymap.set("n", "gm", api.marks.bulk.move, opts("Move Bookmarked"))
      end
      require("nvim-tree").setup({
        remove_keymaps = true,
        on_attach = on_attach,
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

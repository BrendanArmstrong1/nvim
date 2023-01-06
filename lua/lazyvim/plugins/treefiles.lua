return {

  -- auto rooting
  {
    "ahmedkhalf/project.nvim",
    event = "BufReadPost",
    config = function()
      require("project_nvim").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
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
      vim.api.nvim_set_keymap("n", "<leader>rf", [["syiw:lua require('spectre').open_file_search()<CR>"sp]], {})
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
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v2.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
    },
    cmd = "Neotree",
    keys = {
      { "<leader>ft", "<cmd>Neotree toggle<CR>", desc = "NeoTree" },
    },
    init = function()
      vim.g.neo_tree_remove_legacy_commands = 1
    end,
    config = function()
      -- If you want icons for diagnostic errors, you'll need to define them somewhere:
      for name, icon in pairs(require("lazyvim.config.settings").icons.diagnostics) do
        name = "DiagnosticSign" .. name
        vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
      end
      -- NOTE: this is changed from v1.x, which used the old style of highlight groups
      -- in the form "LspDiagnosticsSignWarning"

      require("neo-tree").setup({
        close_if_last_window = true, -- Close Neo-tree if it is the last window left in the tab
        popup_border_style = "rounded",
        enable_git_status = true,
        enable_diagnostics = true,
        sort_case_insensitive = false, -- used when sorting files and directories in the tree
        -- sort_function = nil, -- use a custom function for sorting files and directories in the tree
        sort_function = function(a, b)
          if a.type == b.type then
            return a.path > b.path
          else
            return a.type > b.type
          end
        end, -- this sorts files and directories descendantly
        default_component_configs = {
          container = {
            enable_character_fade = true,
          },
          indent = {
            indent_size = 2,
            padding = 1, -- extra padding on left hand side
            -- indent guides
            with_markers = true,
            indent_marker = "│",
            last_indent_marker = "└",
            highlight = "NeoTreeIndentMarker",
            -- expander config, needed for nesting files
            with_expanders = nil, -- if nil and file nesting is enabled, will enable expanders
            expander_collapsed = "",
            expander_expanded = "",
            expander_highlight = "NeoTreeExpander",
          },
          icon = {
            folder_closed = "",
            folder_open = "",
            folder_empty = "ﰊ",
            -- The next two settings are only a fallback, if you use nvim-web-devicons and configure default icons there
            -- then these will never be used.
            default = "*",
            highlight = "NeoTreeFileIcon",
          },
          modified = {
            symbol = "[+]",
            highlight = "NeoTreeModified",
          },
          name = {
            trailing_slash = false,
            use_git_status_colors = true,
            highlight = "NeoTreeFileName",
          },
          git_status = {
            symbols = {
              -- Change type
              added = "", -- or "✚", but this is redundant info if you use git_status_colors on the name
              modified = "", -- or "", but this is redundant info if you use git_status_colors on the name
              deleted = "✖", -- this can only be used in the git_status source
              renamed = "", -- this can only be used in the git_status source
              -- Status type
              untracked = "",
              ignored = "",
              unstaged = "",
              staged = "",
              conflict = "",
            },
          },
        },
        window = {
          position = "left",
          width = 40,
          mapping_options = {
            noremap = true,
            nowait = true,
          },
          mappings = {
            ["<space>"] = {
              "toggle_node",
              nowait = false, -- disable `nowait` if you have existing combos starting with this char that you want to use
            },
            ["<2-LeftMouse>"] = "open",
            ["<cr>"] = "open",
            ["l"] = "open",
            ["<esc>"] = "revert_preview",
            ["P"] = { "toggle_preview", config = { use_float = true } },
            ["<c-n>"] = "open_split",
            ["<c-v>"] = "open_vsplit",
            -- ["t"] = "open_tabnew",
            -- ["S"] = "split_with_window_picker",
            -- ["s"] = "vsplit_with_window_picker",
            -- ["<cr>"] = "open_drop",
            -- ["t"] = "open_tab_drop",
            -- ["w"] = "open_with_window_picker",
            --["P"] = "toggle_preview", -- enter preview mode, which shows the current node without focusing
            ["C"] = "close_node",
            ["z"] = "close_all_nodes",
            --["Z"] = "expand_all_nodes",
            ["o"] = {
              "add",
              -- this command supports BASH style brace expansion ("x{a,b,c}" -> xa,xb,xc). see `:h neo-tree-file-actions` for details
              -- some commands may take optional config options, see `:h neo-tree-mappings` for details
              config = {
                show_path = "none", -- "none", "relative", "absolute"
              },
            },
            ["O"] = "add_directory", -- also accepts the optional config.show_path option like "add". this also supports BASH style brace expansion.
            ["D"] = "delete",
            ["a"] = "rename",
            ["y"] = "copy_to_clipboard",
            ["d"] = "cut_to_clipboard",
            ["p"] = "paste_from_clipboard",
            -- ["c"] = "copy", -- takes text input for destination, also accepts the optional config.show_path option like "add":
            ["c"] = {
              "copy",
              config = {
                show_path = "none", -- "none", "relative", "absolute"
              },
            },
            ["m"] = "move", -- takes text input for destination, also accepts the optional config.show_path option like "add".
            ["q"] = "close_window",
            ["R"] = "refresh",
            ["?"] = "show_help",
            ["<"] = "prev_source",
            [">"] = "next_source",
          },
        },
        nesting_rules = {},
        filesystem = {
          filtered_items = {
            visible = false, -- when true, they will just be displayed differently than normal items
            hide_dotfiles = true,
            hide_gitignored = true,
            hide_hidden = true, -- only works on Windows for hidden files/directories
            hide_by_name = {
              "node_modules",
            },
            hide_by_pattern = { -- uses glob style patterns
              --"*.meta",
              --"*/src/*/tsconfig.json",
            },
            always_show = { -- remains visible even if other settings would normally hide it
              --".gitignored",
            },
            never_show = { -- remains hidden even if visible is toggled to true, this overrides always_show
              --".DS_Store",
              --"thumbs.db"
            },
            never_show_by_pattern = { -- uses glob style patterns
              --".null-ls_*",
            },
          },
          follow_current_file = false, -- This will find and focus the file in the active buffer every
          -- time the current file is changed while the tree is open.
          group_empty_dirs = false, -- when true, empty folders will be grouped together
          hijack_netrw_behavior = "open_current", -- netrw disabled, opening a directory opens neo-tree
          -- in whatever position is specified in window.position
          -- "open_current",  -- netrw disabled, opening a directory opens within the
          -- window like netrw would, regardless of window.position
          -- "disabled",    -- netrw left alone, neo-tree does not handle opening dirs
          use_libuv_file_watcher = false, -- This will use the OS level file watchers to detect changes
          -- instead of relying on nvim autocmd events.
          window = {
            mappings = {
              ["<bs>"] = "navigate_up",
              ["h"] = "navigate_up",
              ["."] = "set_root",
              ["gs"] = "toggle_hidden",
              ["/"] = "fuzzy_finder",
              ["<c-f>"] = "fuzzy_finder_directory",
              ["f"] = "filter_on_submit",
              ["<c-x>"] = "clear_filter",
              ["[h"] = "prev_git_modified",
              ["]h"] = "next_git_modified",
            },
          },
        },
        buffers = {
          follow_current_file = true, -- This will find and focus the file in the active buffer every
          -- time the current file is changed while the tree is open.
          group_empty_dirs = true, -- when true, empty folders will be grouped together
          show_unloaded = true,
          window = {
            mappings = {
              ["bd"] = "buffer_delete",
              ["<bs>"] = "navigate_up",
              ["h"] = "navigate_up",
              ["."] = "set_root",
            },
          },
        },
        git_status = {
          window = {
            position = "float",
            mappings = {
              ["S"] = "git_add_all",
              ["u"] = "git_unstage_file",
              ["s"] = "git_add_file",
              ["X"] = "git_revert_file",
              ["cc"] = "git_commit",
              ["P"] = "git_push",
              ["gp"] = "git_commit_and_push",
            },
          },
        },
      })

      vim.cmd([[nnoremap \ :Neotree reveal<cr>]])
    end,
  },
}

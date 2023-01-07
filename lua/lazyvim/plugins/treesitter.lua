return {
  { "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufReadPost",
    dependencies = {
      {
        "nvim-treesitter/nvim-treesitter-context",
        config = true,
      },
      {
        "andymass/vim-matchup",
        config = function()
          vim.g.matchup_matchparen_offscreen = { method = "popup" }
        end,
      },
    },
    config = function()
      require("nvim-treesitter.configs").setup({
        auto_install = false,
        sync_install = false,
        ensure_installed = {
          "bash",
          "help",
          "html",
          "javascript",
          "json",
          "lua",
          "c",
          "rust",
          "latex",
          "markdown",
          "markdown_inline",
          "python",
          "query",
          "regex",
          "tsx",
          "typescript",
          "vim",
          "yaml",
        },
        highlight = {
          enable = true,
          disable = function(_, buf) -- "_" variable is lang
            local max_filesize = 1000 * 1024 -- 1000 KB
            local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
            if ok and stats and stats.size > max_filesize then
              return true
            end
          end,
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
        context_commentstring = { enable = true, enable_autocmd = false },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "S",
            node_incremental = "S",
            scope_incremental = "<C-s>",
            node_decremental = "H",
          },
        },
        query_linter = {
          enable = true,
          use_virtual_text = true,
          lint_events = { "BufWrite", "CursorHold" },
        },
        textobjects = {
          select = {
            enable = false,
          },
          move = {
            enable = false,
          },
          lsp_interop = {
            enable = false,
          },
        },
      })
    end,
  },
}

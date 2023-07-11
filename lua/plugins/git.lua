return {
  -- Fugitive
  {
    "tpope/vim-fugitive",
    cmd = "G",
    init = function()
      vim.api.nvim_set_keymap("n", "<leader>gp", "<CMD>Git push<CR>", {})
      vim.api.nvim_set_keymap("n", "<leader>gd", "<CMD>Gdiffsplit<CR>", {})
      vim.api.nvim_set_keymap("n", "<leader>gD", "<CMD>Gdiffsplit!<CR>", {})
      vim.api.nvim_set_keymap("n", "<leader>ga", "<CMD>diffget //2<CR>", {})
      vim.api.nvim_set_keymap("n", "<leader>gi", "<CMD>diffget //3<CR>", {})
    end,
    keys = {
      { "<leader>gg", "<CMD>Git<CR>" },
      { "<leader>gL", "<CMD>Git log<CR>" },
      { "<leader>gb", "<CMD>Git blame<CR>" },
    },
  },

  -- Diffview
  {
    "sindrets/diffview.nvim",
    cmd = "DiffviewOpen",
  },

  -- git signs
  {
    "lewis6991/gitsigns.nvim",
    event = "BufReadPre",
    config = function()
      require("gitsigns").setup({
        signs = {
          add = { text = "▎" },
          change = { text = "▎" },
          changedelete = { text = "▎" },
          untracked = { text = "▎" },
        },
        signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
        numhl = true, -- Toggle with `:Gitsigns toggle_numhl`
        linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
        word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
        watch_gitdir = {
          interval = 1000,
          follow_files = true,
        },
        attach_to_untracked = true,
        current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
          delay = 1000,
          ignore_whitespace = false,
        },
        current_line_blame_formatter_opts = {
          relative_time = false,
        },
        sign_priority = 6,
        update_debounce = 100,
        status_formatter = nil, -- Use default
        max_file_length = 40000,
        preview_config = {
          -- Options passed to nvim_open_win
          border = "single",
          style = "minimal",
          relative = "cursor",
          row = 0,
          col = 1,
        },
        yadm = {
          enable = false,
        },
        on_attach = function(bufnr)
          local gs = package.loaded.gitsigns

          local function map(mode, l, r, opts)
            opts = opts or {}
            opts.buffer = bufnr
            vim.keymap.set(mode, l, r, opts)
          end

          -- Navigation
          map("n", "]h", function()
            if vim.wo.diff then
              return "]h"
            end
            vim.schedule(function()
              gs.next_hunk()
              vim.cmd("norm! zz")
            end)
            return "<Ignore>"
          end, { expr = true })

          map("n", "[h", function()
            if vim.wo.diff then
              return "[h"
            end
            vim.schedule(function()
              gs.prev_hunk()
              vim.cmd("norm! zz")
            end)
            return "<Ignore>"
          end, { expr = true })

          -- Actions
          -- stylua: ignore start
          map({ "n", "v" }, "<leader>hs", ":Gitsigns stage_hunk<CR>", {silent=true})
          map({ "n", "v" }, "<leader>hr", ":Gitsigns reset_hunk<CR>", {silent=true})
          map("n", "<leader>HS", gs.stage_buffer, {silent=true})
          map("n", "<leader>HR", gs.reset_buffer, {silent=true})
          map("n", "<leader>hu", gs.undo_stage_hunk, {silent=true})
          map("n", "<leader>hp", gs.preview_hunk, {silent=true})
          map("n", "<leader>hb", function() gs.blame_line({ full = true }) end, {silent=true})
          map("n", "<leader>hl", gs.toggle_current_line_blame, {silent=true})
          map("n", "<leader>gl", gs.toggle_linehl, {silent=true})
          map("n", "<leader>hd", gs.diffthis, {silent=true})
          map("n", "<leader>HD", function() gs.diffthis("~") end, {silent=true})
          map("n", "<leader>ht", gs.toggle_deleted, {silent=true})
          -- Text object
          map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>")
          -- stylua: ignore end
        end,
      })
    end,
  },
}

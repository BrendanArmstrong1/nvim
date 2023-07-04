return {
  {
    "smoka7/multicursors.nvim",
    cmd = { "MCstart" },
    keys = { { "<leader>m", "<cmd>MCstart<cr>", desc = "Start Multicursor" } },
    config = function()
      require("multicursors").setup({})
    end,
  },
}

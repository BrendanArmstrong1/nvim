return {
  {
    "m4xshen/hardtime.nvim",
    dependencies = { "MunifTanjim/nui.nvim", "nvim-lua/plenary.nvim" },
    cmd = {
      "Hardtime",
    },
    config = function()
      require("hardtime").setup({
        disabled_filetypes = {
          "qf",
          "gitignore",
          "fugitiveblame",
          "netrw",
          "fugitive",
          "NvimTree",
          "lazy",
          "mason",
          "oil",
        },
      })
    end,
  },
}

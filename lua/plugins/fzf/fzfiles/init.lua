local M = {}

M.setup = function()
  vim.api.nvim_create_user_command("FzFiles", function(args)
    vim.fn["fzf#vim#files"](
      args["args"],
      vim.fn["fzf#vim#with_preview"]({ options = { "--layout=reverse", "--info=inline" } })
    )
  end, { bang = false, nargs = "?", complete = "dir" })
end

return M

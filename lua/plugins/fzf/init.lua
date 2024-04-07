local util = require("plugins.fzf.util")
local setup = require("plugins.fzf.setup")

M = {"junegunn/fzf.vim"}
M.dependencies = { "junegunn/fzf" }


-- stylua: ignore
M.keys = {
	{ "<leader>:", "<cmd>Commands<cr>", mode = { "n" } },
	{ "<leader>ff", "<cmd>FzFiles<cr>", mode = { "n" } },
	{ "<leader>fl", "<cmd>BLines<cr>", mode = { "n" } },
	{ "<leader>FL", "<cmd>Lines<cr>", mode = { "n" } },
	{ "<leader>fk", "<cmd>FzHelpTags<cr>", mode = { "n" } },
	{ "<leader>FK", "<cmd>Maps<cr>", mode = { "n" } },
	{ "<leader>\\", "<cmd>RG<CR>", mode = { "n" } },
	{ "<leader>?", function() return util.word_search(false) end, expr = true, mode = "n" },
	{ "<leader>?", function() return util.word_search(true) end, expr = true, mode = "x" },
	{ "<c-x><c-k>", function() vim.fn['fzf#vim#complete#word']() end, expr = true, mode = "i" },
	{ "<c-x><c-l>", function() vim.fn['fzf#vim#complete#line']() end, expr = true, mode = "i" },
	{ "<c-x><c-f>", function() vim.fn['fzf#vim#complete#path']("rg --files") end, expr = true, mode = "i" },
}

function M.config()
  setup.setup()
	setup.fzfiles_command()
  setup.fzhelptags_command()
end

return M

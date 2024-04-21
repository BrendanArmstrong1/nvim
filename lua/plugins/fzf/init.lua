local M = { "junegunn/fzf.vim" }
M.dependencies = { "junegunn/fzf" }


-- stylua: ignore
M.keys = {
	{ "<leader>:", "<cmd>Commands<cr>", mode = { "n" } },
	{ "gd", vim.lsp.buf.definition, mode = { "n" } },
	{ "gr", function() vim.lsp.buf.references() end, mode = { "n" } },
	{ "gI", vim.lsp.buf.implementation, mode = { "n" } },
	{ "gt", vim.lsp.buftype_definition, mode = { "n" } },
	{ "<leader>fd", "<cmd>FzfLspDiagnosticsAll<cr>", mode = { "n" } },
	{ "<leader>FD", "<cmd>FzfLspDiagnostics<cr>", mode = { "n" } },
	{ "<leader>fr", "<cmd>FzfFuzzyLast<cr>", mode = { "n" } },
	{ "<leader>ff", "<cmd>FzFiles<cr>", mode = { "n" } },
	{ "<leader>fl", "<cmd>BLines<cr>", mode = { "n" } },
	{ "<leader>FL", "<cmd>Lines<cr>", mode = { "n" } },
	{ "<leader>fk", "<cmd>FzHelpTags<cr>", mode = { "n" } },
	{ "<leader>FK", "<cmd>Maps<cr>", mode = { "n" } },
	{ "<leader>\\", "<cmd>RG<CR>", mode = { "n" } },
	{ "<leader>?", function() return require("plugins.fzf.fzword_search").run(false) end, expr = true, mode = "n" },
	{ "<leader>?", function() return require("plugins.fzf.fzword_search").run(true) end, expr = true, mode = "x" },
	{ "<c-x><c-k>", function() vim.fn['fzf#vim#complete#word']() end, expr = true, mode = "i" },
	{ "<c-x><c-l>", function() vim.fn['fzf#vim#complete#line']() end, expr = true, mode = "i" },
	{ "<c-x><c-f>", function() vim.fn['fzf#vim#complete#path']("rg --files") end, expr = true, mode = "i" },
}

M.config = function()
	require("plugins.fzf.setup").setup()
	require("plugins.fzf.fzfiles").setup()
	require("plugins.fzf.fzhelp_tags").setup()
	require("plugins.fzf.fzLsp").setup()
end

return M

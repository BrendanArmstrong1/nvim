vim.opt.textwidth = 80
vim.opt.autoindent = false
vim.o.autowriteall = true

vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
	pattern = { "*.norg" },
	command = "set conceallevel=3",
})

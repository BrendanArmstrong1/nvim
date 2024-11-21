local binary_group = vim.api.nvim_create_augroup("binary_editing", { clear = true })

vim.api.nvim_create_autocmd("BufReadPost", {
	group = binary_group,
	pattern = "*",
	callback = function()
		if vim.opt_local.binary:get() then
			vim.opt_local.ft = "xxd"
			vim.cmd("silent %!xxd")
			vim.b.xxd_mode = true
      vim.opt_local.modified = false
		end
	end,
})

vim.api.nvim_create_autocmd("BufWritePre", {
	group = binary_group,
	pattern = "*",
	callback = function()
		if vim.b.xxd_mode then
			local cursor_pos = vim.fn.getcurpos()
			vim.cmd("silent %!xxd -r")
			vim.b.xxd_cursor_pos = cursor_pos
		end
	end,
})

vim.api.nvim_create_autocmd("BufWritePost", {
	group = binary_group,
	pattern = "*",
	callback = function()
		if vim.b.xxd_mode then
			vim.cmd("silent %!xxd")
			if vim.b.xxd_cursor_pos then
				vim.fn.setpos(".", vim.b.xxd_cursor_pos)
			end
      vim.opt_local.modified = false
		end
	end,
})

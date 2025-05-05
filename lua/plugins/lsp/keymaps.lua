local M = {}

function M.new(client, buffer)
	return setmetatable({ client = client, buffer = buffer }, { __index = M })
end

function M:has(cap)
	return self.client.server_capabilities[cap .. "Provider"]
end

function M:map(lhs, rhs, opts)
	opts = opts or {}
	if opts.has and not self:has(opts.has) then
		return
	end
	vim.keymap.set(
		opts.mode or "n",
		lhs,
		type(rhs) == "string" and ("<cmd>%s<cr>"):format(rhs) or rhs,
		{ silent = true, buffer = self.buffer, expr = opts.expr, desc = opts.desc }
	)
end

function M.rename()
	if pcall(require, "inc_rename") then
		return ":IncRename " .. vim.fn.expand("<cword>")
	else
		vim.lsp.buf.rename()
	end
end

function M.on_attach(client, buffer)
  local self = M.new(client, buffer)
  self:map("<leader>vd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
  self:map("<leader>li", "LspInfo", { desc = "Lsp Info" })
  self:map("<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action", mode = { "n", "v" }, has = "codeAction" })
  self:map("<leader>cf", "ALEFix", { desc = "Format Document", has = "documentFormatting" })
  self:map("[<CR>", vim.diagnostic.goto_prev, { desc = "goto previous diagnostic", mode = { "n" } })
  self:map("]<CR>", vim.diagnostic.goto_next, { desc = "goto next diagnostic", mode = { "n" } })
end

return M

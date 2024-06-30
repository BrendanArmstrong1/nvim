M = {}

function M.on_attach(client, buffer)
	local self = M.new(client, buffer)
  self:map("<leader>vd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
	self:map("<leader>li", "LspInfo", { desc = "Lsp Info" })
	self:map("<C-k>", vim.lsp.buf.signature_help, { desc = "Signature Help", mode = { "i" }, has = "signatureHelp" })
	self:map("<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action", mode = { "n", "v" }, has = "codeAction" })
	self:map("<leader>cf", "ALEFix", { desc = "Format Document", has = "documentFormatting" })
  -- -- THIS IS FOR COMPLETION LATER
  -- ---Utility for keymap creation.
  -- ---@param lhs string
  -- ---@param rhs string|function
  -- ---@param opts string|table
  -- ---@param mode? string|string[]
  -- local function keymap(lhs, rhs, opts, mode)
  --   opts = type(opts) == 'string' and { desc = opts }
  --   or vim.tbl_extend('error', opts --[[@as table]], { buffer = bufnr })
  --   mode = mode or 'n'
  --   vim.keymap.set(mode, lhs, rhs, opts)
  -- end
  --
  -- ---For replacing certain <C-x>... keymaps.
  -- ---@param keys string
  -- local function feedkeys(keys)
  --   vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), 'n', true)
  -- end
  --
  -- ---Is the completion menu open?
  -- local function pumvisible()
  --   return tonumber(vim.fn.pumvisible()) ~= 0
  -- end
  --
  -- -- Enable completion and configure keybindings.
  -- if client.supports_method(methods.textDocument_completion) then
  --   vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
  --
  --   -- Use enter to accept completions.
  --   keymap('<cr>', function()
  --     return pumvisible() and '<C-y>' or '<cr>'
  --   end, { expr = true }, 'i')
  --
  --   -- Use slash to dismiss the completion menu.
  --   keymap('/', function()
  --     return pumvisible() and '<C-e>' or '/'
  --   end, { expr = true }, 'i')
  --
  --   -- Use <C-n> to navigate to the next completion or:
  --   -- - Trigger LSP completion.
  --   -- - If there's no one, fallback to vanilla omnifunc.
  --   keymap('<C-n>', function()
  --     if pumvisible() then
  --       feedkeys '<C-n>'
  --     else
  --       if next(vim.lsp.get_clients { bufnr = 0 }) then
  --         vim.lsp.completion.trigger()
  --       else
  --         if vim.bo.omnifunc == '' then
  --           feedkeys '<C-x><C-n>'
  --         else
  --           feedkeys '<C-x><C-o>'
  --         end
  --       end
  --     end
  --   end, 'Trigger/select next completion', 'i')
  --
  --   -- Buffer completions.
  --   keymap('<C-u>', '<C-x><C-n>', { desc = 'Buffer completions' }, 'i')
  --
  --   -- Use <Tab> to accept a Copilot suggestion, navigate between snippet tabstops,
  --   -- or select the next completion.
  --   -- Do something similar with <S-Tab>.
  --   keymap('<Tab>', function()
  --     local copilot = require 'copilot.suggestion'
  --
  --     if copilot.is_visible() then
  --       copilot.accept()
  --     elseif pumvisible() then
  --       feedkeys '<C-n>'
  --     elseif vim.snippet.active { direction = 1 } then
  --       vim.snippet.jump(1)
  --     else
  --       feedkeys '<Tab>'
  --     end
  --   end, {}, { 'i', 's' })
  --   keymap('<S-Tab>', function()
  --     if pumvisible() then
  --       feedkeys '<C-p>'
  --     elseif vim.snippet.active { direction = -1 } then
  --       vim.snippet.jump(-1)
  --     else
  --       feedkeys '<S-Tab>'
  --     end
  --   end, {}, { 'i', 's' })
  --
  --   -- Inside a snippet, use backspace to remove the placeholder.
  --   keymap('<BS>', '<C-o>s', {}, 's')
  -- end
end

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


return M

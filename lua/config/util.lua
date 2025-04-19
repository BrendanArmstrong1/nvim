local M = {}
---Create an autocmd to launch a file browser plugin when opening dirs.
---@param plugin_name string
---@param plugin_open fun(path: string) Function to open the file browser
function M.attach_file_browser(plugin_name, plugin_open)
	local previous_buffer_name
	vim.api.nvim_create_autocmd("BufEnter", {
		-- group = "Oil", -- I use the same group for all my autocmds. To create one: vim.api.nvim_create_augroup("CustomAutocmdGroupName", { clear = true })
		desc = string.format("[%s] replacement for Netrw", plugin_name),
		pattern = "*",
		callback = function()
			vim.schedule(function()
				local buffer_name = vim.api.nvim_buf_get_name(0)
				if vim.fn.isdirectory(buffer_name) == 0 then
					_, previous_buffer_name = pcall(vim.fn.expand, "#:p:h")
					return
				end

				-- Avoid reopening when exiting without selecting a file
				if previous_buffer_name == buffer_name then
					previous_buffer_name = nil
					return
				else
					previous_buffer_name = buffer_name
				end

				-- Ensure no buffers remain with the directory name
				vim.api.nvim_set_option_value("bufhidden", "wipe", { buf = 0 })
				plugin_open(vim.fn.expand("%:p:h"))
			end)
		end,
	})
end

return M

local function tab_win_closed(winnr)
	local tabnr = vim.api.nvim_win_get_tabpage(winnr)
	local tab_wins = vim.tbl_filter(function(w)
		return w ~= winnr
	end, vim.api.nvim_tabpage_list_wins(tabnr))
	local tab_bufs = vim.tbl_map(vim.api.nvim_win_get_buf, tab_wins)
	if #tab_bufs == 1 then -- if there is only 1 buffer left in the tab
		local last_buf_info = vim.fn.getbufinfo(tab_bufs[1])[1]
		if
			last_buf_info.name:match(".*NvimTree_%d*$")
			or last_buf_info.name:match(".*NeoTree$")
			or last_buf_info.name:match(".*zsh$")
		then -- and that buffer is nvim tree
			vim.schedule(function()
				if #vim.api.nvim_list_wins() == 1 then -- if its the last buffer in vim
					vim.cmd("quit") -- then close all of vim
				else -- else there are more tabs open
					vim.api.nvim_win_close(tab_wins[1], true) -- then close only the tab
				end
			end)
		end
	end
end

local function augroup(name)
  return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

vim.api.nvim_command("autocmd TermOpen * setlocal nonumber norelativenumber")
vim.api.nvim_command("autocmd BufWinEnter,WinEnter term://* startinsert")
vim.api.nvim_command("autocmd BufLeave term://* stopinsert")


vim.api.nvim_create_autocmd("WinClosed", {
  group = augroup("nesting_close"),
	callback = function()
		local winnr = tonumber(vim.fn.expand("<amatch>"))
		vim.schedule_wrap(tab_win_closed(winnr))
	end,
	nested = true,
})


-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
	group = augroup("checktime"),
	command = "checktime",
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
	group = augroup("highlight_yank"),
	callback = function()
		vim.highlight.on_yank()
	end,
})

-- resize splits if window got resized
vim.api.nvim_create_autocmd({ "VimResized" }, {
	group = augroup("resize_splits"),
	callback = function()
		vim.cmd("tabdo wincmd =")
	end,
})

-- go to last loc when opening a buffer
local last_view = vim.api.nvim_create_autocmd("BufReadPost", {
	group = augroup("last_loc"),
	callback = function()
		local mark = vim.api.nvim_buf_get_mark(0, '"')
		local lcount = vim.api.nvim_buf_line_count(0)
		if mark[1] > 0 and mark[1] <= lcount then
			pcall(vim.api.nvim_win_set_cursor, 0, mark)
		end
	end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("close_with_q"),
	pattern = {
		"PlenaryTestPopup",
		"help",
		"lspinfo",
		"man",
		"notify",
		"qf",
		"spectre_panel",
		"startuptime",
		"tsplayground",
	},
	callback = function(event)
		vim.bo[event.buf].buflisted = false
		vim.keymap.set("n", "Q", "<cmd>close<cr>", { buffer = event.buf, silent = true })
	end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
	group = augroup("wrap_spell"),
	pattern = { "gitcommit", "markdown" },
	callback = function()
		vim.opt_local.wrap = true
		vim.opt_local.spell = true
	end,
})

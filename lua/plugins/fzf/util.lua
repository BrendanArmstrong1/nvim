table.unpack = table.unpack or unpack -- 5.1 compatibility
M = {}

-- stylua: ignore
local function get_vis_cols()
  local y1, x1 = table.unpack(vim.api.nvim_buf_get_mark(0, "<"))
  local y2, x2 = table.unpack(vim.api.nvim_buf_get_mark(0, ">"))
  if y1 > y2 then y2, y1 = y1, y2 end
  if x1 > x2 then x2, x1 = x1, x2 end
  return y1, x1, x2
end

local function escape_chars(text)
	return text
end

function M.word_search(visual)
	if visual then
		local keys = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
		vim.api.nvim_feedkeys(keys, "x", false)
		local y1, x1, x2 = get_vis_cols()
		local vis_sel = vim.api.nvim_buf_get_text(0, y1 - 1, x1, y1 - 1, x2 + 1, {})[1]
		return "<cmd>Rg " .. escape_chars(vis_sel) .. "<CR>"
	end
	return "<cmd>Rg " .. vim.fn.expand("<cword>") .. "<CR>"
end

local ignore_string = {
	".git",
	"*.dll",
	"*.seq",
	"*.stp",
	"*.zip",
	"*.whl",
	"*.lib",
	"*.pdf",
	"*.jpg",
	"*.png",
	"*.docx",
}

M.ignored_filetypes = table.concat(ignore_string, ",")

return M

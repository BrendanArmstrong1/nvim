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

local function path_tail(path)
    for i = #path, 1, -1 do
      if path:sub(i, i) == "/" then
        return path:sub(i + 1, -1)
      end
    end
    return path
end

local function escape_chars(text)
	return text
end

function M.find_tags()
  local tag_files = {}
  local function add_tag_file(lang, file)
    if tag_files[lang] then
      table.insert(tag_files[lang], file)
    else
      tag_files[lang] = { file }
    end
  end

  local help_files = {}
  local all_files = vim.api.nvim_get_runtime_file("doc/*", true)
  for _, fullpath in ipairs(all_files) do
    local file = path_tail(fullpath)
    if file == "tags" then
      add_tag_file("en", fullpath)
    else
      help_files[file] = fullpath
    end
  end

  local tags = {}
  local tags_map = {}
  local delimiter = string.char(9) -- tab
  local tag_corrections = {
    ["%*"] = "\\*",
    ["%("] = "\\(",
    ["%)"] = "\\)",
    ["/"] = "",
  }

  for _, file in ipairs(tag_files["en"]) do
    for line in io.lines(file) do
      if not line:match("^!_TAG_") then
        local fields = vim.split(line, delimiter, { plain = true })
        if #fields == 3 and not tags_map[fields[1]] then
          if fields[1] ~= "help-tags" or fields[2] ~= "tags" then
            local original_tags = fields[3]
            local escaped_tags = fields[3]
            for i, v in pairs(tag_corrections) do
              escaped_tags = string.gsub(escaped_tags, i, v)
            end
            table.insert(
              tags,
              table.concat({
                fields[1],
                help_files[fields[2]],
                escaped_tags,
                original_tags,
              }, "\t")
            )
            tags_map[fields[1]] = true
          end
        end
      end
    end
  end

  return tags
end

function M.process_help_tags(line)
  local command = line[1]
  local info = vim.split(line[2], "\t")
  local tag = string.sub(info[4], 3, #info[4] - 2)
  print(vim.inspect(info))
  local cmd
  if command == "enter" then
    cmd = "help "
  elseif command == "ctrl-v" then
    cmd = "vert help "
  end
  vim.cmd(cmd .. tag)
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

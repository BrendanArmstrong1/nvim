local util = require("plugins.fzf.util")

local M = {}

local function path_tail(path)
	for i = #path, 1, -1 do
		if path:sub(i, i) == "/" then
			return path:sub(i + 1, -1)
		end
	end
	return path
end

M.find_tags = function()
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
								util.green(fields[1], "Label"),
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


return M

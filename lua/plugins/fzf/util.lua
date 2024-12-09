table.unpack = table.unpack or unpack -- 5.1 compatibility

local M = {}

local function get_color(attr, group)
	local gui = vim.fn.has("termguicolors") and vim.api.nvim_get_option("termguicolors")
	local fam = gui and "gui" or "cterm"
	local pat = gui and "^#[a-f0-9]+" or "^[0-9]+$"
	local code = vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID(group)), attr, fam)
	if string.match(code, pat) then
		return code
	end
	return ""
end

local function csi(color, fg)
	local prefix = fg and "38;" or "48;"
	if string.sub(color, 1, 1) == "#" then
		return prefix
			.. "2;"
			.. vim.fn.join(
				vim.fn.map(
					{ string.sub(color, 1, 2), string.sub(color, 3, 4), string.sub(color, 5, 6) },
					"str2nr(v:val, 16)"
				),
				";"
			)
	end
	return prefix .. "5;" .. color
end

local ansi_color = { black = 30, red = 31, green = 32, yellow = 33, blue = 34, magenta = 35, cyan = 36 }

local function ansi(str, group, default, ...)
	local param = { ... }
	local fg = get_color("fg", group)
	local bg = get_color("bg", group)
	local color = (fg == "" and ansi_color[default] or csi(fg, 1)) .. (bg == "" and "" or ";" .. csi(bg, 0))
	return vim.fn.printf("\x1b[%s%sm%s\x1b[m", color, #param and ";1" or "", str)
end

for color_name, _ in pairs(ansi_color) do
	M[color_name] = function(str, ...)
		local parm = { ... }
		return ansi(str, parm[1] or "", color_name)
	end
end

M.complete_word = function()
	local _, cur_x = table.unpack(vim.api.nvim_win_get_cursor(0))
	local current_line = vim.api.nvim_get_current_line()
	local sliced_line = string.sub(current_line, 1, cur_x)
	local query = string.match(sliced_line, "^.-(%w+)$")
	require("fzf-lua").fzf_exec(function(fzf_cb)
		coroutine.wrap(function()
			local co = coroutine.running()
			local dictionary = vim.split(vim.api.nvim_get_option("dictionary"), ",", { plain = true })
			for _, dict in ipairs(dictionary) do
				for line in io.lines(dict) do
					fzf_cb(line, function()
						coroutine.resume(co)
					end)
					coroutine.yield()
				end
			end
			fzf_cb()
		end)()
	end, { complete = true, query = query })
end

M.git_pickaxe = function()
	local actions = require("fzf-lua.actions")
	local index_choice = 0
	require("fzf-lua").fzf_live(
		'git log --color --pretty=format:"%C(yellow)%h%Creset '
			.. '%Cgreen(%><(12)%cr%><|(12))%Creset %s %C(blue)<%an>%Creset" -S',
		{
			prompt = "PickAxe> ",
			delimiter = " ",
			header = ":: <" .. M.yellow("ctrl-y") .. "> to " .. M.red("copy commit hash"),
			preview = {
				type = "cmd",
				field_index = "{+}", -- for fzf_opts = {["--multi"] = true}
				fn = function(items)
					local current_line = vim.api.nvim_get_current_line()
					local query = string.match(current_line, "^PickAxe> (%w+).*$")
					local hash = vim.split(items[1], " ")[1]
					local handle = io.popen("git show --color --pretty=medium " .. hash .. " -S " .. query)
					local index = 0
					local found = 0
					local index_choice_copy = index_choice
					if handle ~= nil then
						for line in handle:lines() do
							index = index + 1
							if string.match(line, query) then
								if index_choice_copy <= 0 then
									found = 1
									break
								end
								index_choice_copy = index_choice_copy - 1
							end
						end
						handle:close()
					end
					if found ~= 1 then
						index = 0
					end
					local start = 0
					if index >= 3 then
						start = index - 3
					end
					return "git show --color --pretty=medium "
						.. hash
						.. " -S "
						.. query
						.. " | bat --style=default --color=always "
						.. "--line-range "
						.. start
						.. ": "
						.. "--highlight-line "
						.. index
				end,
			},
			actions = {
				["default"] = function(selected, _)
					local hash = vim.split(selected[1], " ")[1]
					vim.cmd("Gedit " .. hash)
				end,
				["ctrl-v"] = function(selected, _)
					local hash = vim.split(selected[1], " ")[1]
					vim.cmd("Gvsplit " .. hash)
				end,
				["ctrl-y"] = { fn = actions.git_yank_commit, exec_silent = true },
				["ctrl-n"] = {
					fn = function(_, _)
						index_choice = index_choice + 1
					end,
					exec_silent = true,
          reload = true,
				},
				["ctrl-p"] = {
					fn = function(_, _)
						if index_choice >= 0 then
							index_choice = index_choice - 1
						end
					end,
					exec_silent = true,
          reload = true,
				},
			},
		}
	)
end

return M

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
	if string.sub(color,1,1) == "#" then
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
  local param = {...}
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

return M

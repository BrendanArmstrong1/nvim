-- better up/down, Add jumps 5 and greater to the jump list
vim.keymap.set("n", "j", 'v:count1 > 4 ? "m\'" .. v:count .. "gjm\'" : "gj"', { expr = true, silent = true })
vim.keymap.set("n", "k", 'v:count1 > 4 ? "m\'" .. v:count .. "gkm\'" : "gk"', { expr = true, silent = true })

-- don't add '{' or '}' to jumplist.
-- https://superuser.com/questions/836784/in-vim-dont-store-motions-in-jumplist
vim.api.nvim_set_keymap(
	"n",
	"}",
	"':<C-u> execute \"keepjumps norm! ' .. v:count1 .. '}\"<CR>'",
	{ expr = true, silent = true }
)
vim.api.nvim_set_keymap(
	"n",
	"{",
	"':<C-u> execute \"keepjumps norm! ' .. v:count1 .. '{\"<CR>'",
	{ expr = true, silent = true }
)

-- Lazy access without triggering cmp lazy-load
vim.keymap.set("n", "<leader>L", "<cmd>Lazy<cr>")

-- disable troublesome keys
vim.keymap.set("n", "<C-z>", "<nop>")
vim.keymap.set("i", "<C-z>", "<nop>")
vim.keymap.set("n", "<C-l>", "<nop>")

-- nice replace macro, works with counts now
-- "https://github.com/community/community/discussions/29817"
vim.api.nvim_set_keymap(
	"n",
	"<leader>s",
	"':' .. (v:count ? '' : '%') .. 's/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>'",
	{ desc = "replace word under cursor", noremap = true, expr = true }
)

-- local function ReplaceVisualSelection()
-- 	local count = vim.v.count
-- 	local keys = vim.api.nvim_replace_termcodes("<ESC>", true, false, true)
-- 	vim.api.nvim_feedkeys(keys, "x", false)
-- 	local function Set(list)
-- 		local set = {}
-- 		for _, l in ipairs(list) do
-- 			set[l] = true
-- 		end
-- 		return set
-- 	end
-- 	local escaped_keys = Set({ "<", "[", "\\", "." })
-- 	local vstart = vim.api.nvim_buf_get_mark(0, "<")
-- 	local vend = vim.api.nvim_buf_get_mark(0, ">")
-- 	local line = vim.api.nvim_buf_get_lines(0, vstart[1] - 1, vend[1], 0)
-- 	local text = string.sub(line[1], vstart[2] + 1, vend[2] + 1)
-- 	local escaped_string = text
--
-- 	local index = 0
-- 	for i = 1, string.len(text) do
-- 		local letter = string.sub(text, i, i)
-- 		if escaped_keys[letter] then
-- 			escaped_string = string.sub(escaped_string, 0, i - 1 + index)
-- 				.. "\\"
-- 				.. string.sub(escaped_string, i + index, string.len(escaped_string))
-- 			index = index + 1
-- 		end
-- 	end
--
-- 	if count > 0 then
-- 		return ":<C-U>.,.+" .. count .. "s/" .. escaped_string .. "/" .. text .. "/gI<Left><Left><Left>"
-- 	end
-- 	return ":<C-U>%s/" .. escaped_string .. "/" .. text .. "/gI<Left><Left><Left>"
-- end
--
-- vim.keymap.set(
-- 	"x",
-- 	"<leader>s",
-- 	ReplaceVisualSelection,
-- 	{ desc = "replace visual selection", noremap = true, expr = true }
-- )

-- movement mappings
vim.keymap.set({ "n", "x" }, "<C-e>", "repeat('<C-e>', 5)", { noremap = true, expr = true })
vim.keymap.set({ "n", "x" }, "<C-y>", "repeat('<C-y>', 5)", { noremap = true, expr = true })
vim.keymap.set({ "n", "x" }, "<C-d>", "<C-d>zz", { noremap = true })
vim.keymap.set({ "n", "x" }, "<C-u>", "<C-u>zz", { noremap = true })
vim.keymap.set({ "n", "x" }, "n", "nzz", { noremap = true })
vim.keymap.set({ "n", "x" }, "N", "Nzz", { noremap = true })

-- command line help
vim.keymap.set("c", "<c-j>", "<nop>")
vim.keymap.set("c", "<c-k>", "<nop>")
vim.keymap.set("c", "<c-l>", "<right>")
vim.keymap.set("c", "<c-h>", "<left>")

-- save
vim.keymap.set("n", "<C-s>", "<cmd>w<cr><esc>")

-- fast quit
vim.keymap.set("n", "<c-w><c-t>", "<cmd>tabclose!<CR>", { silent = true })
vim.keymap.set("n", "<c-w><c-d>", "<cmd>wq!<CR>", { silent = true })
vim.keymap.set("n", "<c-w><c-q>", "<cmd>q!<CR>", { silent = true })
vim.keymap.set("n", "<c-w><c-b>", "<cmd>bd!<CR>", { silent = true })
vim.keymap.set("n", "<c-w><c-m>", "<cmd>bd!<CR>", { silent = true })

-- terminal commands
vim.keymap.set("t", "<c-z>", "<c-\\><c-n>", { noremap = true })
vim.keymap.set("t", "<C-w><c-q>", "<c-\\><c-n><c-w><c-q>", {})
vim.keymap.set("t", "<C-w><c-w>", "<c-\\><c-n><c-w><c-w>", {})

-- Move to window using the <meta> movement keys
vim.keymap.set("n", "<left>", "<C-w>h")
vim.keymap.set("n", "<down>", "<C-w>j")
vim.keymap.set("n", "<up>", "<C-w>k")
vim.keymap.set("n", "<right>", "<C-w>l")

-- Resize window using <shift> arrow keys
vim.keymap.set("n", "<S-Up>", "<cmd>resize +2<CR>", { silent = true })
vim.keymap.set("n", "<S-Down>", "<cmd>resize -2<CR>", { silent = true })
vim.keymap.set("n", "<S-Left>", "<cmd>vertical resize -2<CR>", { silent = true })
vim.keymap.set("n", "<S-Right>", "<cmd>vertical resize +2<CR>", { silent = true })

-- Switch buffers with <ctrl>
vim.keymap.set("n", "<C-b>", "<nop>")
vim.keymap.set("n", "<C-f>", "<nop>")
vim.keymap.set("n", "<C-b>", "<cmd>bprevious<cr>")
vim.keymap.set("n", "<C-f>", "<cmd>bnext<cr>")
vim.keymap.set({ "n", "x", "o" }, "L", "$")
vim.keymap.set({ "n", "x", "o" }, "H", "^")

-- Easier pasting(with auto-indent)
vim.keymap.set("n", "gp", "`[v`]")
vim.keymap.set("n", "[p", ":pu!<cr>`[v`]=", { silent = true })
vim.keymap.set("n", "]p", ":pu<cr>`[v`]=", { silent = true })

-- Clear search with <esc>
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>")
vim.keymap.set("n", "gw", "*N")
vim.keymap.set("x", "gw", "*N")

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set("n", "n", "'Nn'[v:searchforward] .. 'zz'", { expr = true })
vim.keymap.set("x", "n", "'Nn'[v:searchforward] .. 'zz'", { expr = true })
vim.keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true })
vim.keymap.set("n", "N", "'nN'[v:searchforward] .. 'zz'", { expr = true })
vim.keymap.set("x", "N", "'nN'[v:searchforward] .. 'zz'", { expr = true })
vim.keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true })

-- Add undo break-points
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", ";", ";<c-g>u")

-- better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- new file
vim.keymap.set("n", "<leader>o", ":e <C-R>=expand('%:p:h') . '/' <CR>", { desc = "New File" })
vim.keymap.set("n", "<leader>.", "<cmd>echo expand('%:p')<cr>", { desc = "print file" })

function Print_tmux_panes()
	local tmux_active = vim.fn.expand("$TMUX")
	if tmux_active ~= "$TMUX" then
		vim.fn.jobstart("tmux list-panes", {
			stdout_buffered = true,
			on_stdout = function(_, data, _)
				data[#data] = nil
				for k, v in ipairs(data) do
					print(k, v)
				end
			end,
		})
	end
end

function Test_function()
  local str = vim.api.nvim_replace_termcodes(":hello worl<Left><Left>",true,false,true)
  vim.api.nvim_feedkeys(str, "t", false)
end
vim.keymap.set("n", "gy", Print_tmux_panes)
vim.keymap.set("n", "g.", Test_function)

local Util = require("lazy.core.util")
local enabled = true
function Toggle_diagnostics()
	enabled = not enabled
	if enabled then
		vim.diagnostic.enable(0)
		Util.info("Diagnostics on", { title = "Diagnostics" })
	else
		vim.diagnostic.disable(0)
		Util.info("Diagnostics off", { title = "Diagnostics" })
	end
end

local fmt_enabled = false
function Toggle_formatting()
	fmt_enabled = not fmt_enabled
	if fmt_enabled then
		Util.info("Enabled format on save", { title = "Format" })
		vim.g.ale_fix_on_save = 1
	else
		Util.info("Disabled format on save", { title = "Format" })
		vim.g.ale_fix_on_save = 0
	end
end

-- toggle options
-- stylua: ignore start
vim.keymap.set("n", "<leader>tf", Toggle_formatting, { desc = "Format on Save" })
vim.keymap.set("n", "<leader>td", Toggle_diagnostics, { desc = "Diagnostics" })
-- stylua: ignore end

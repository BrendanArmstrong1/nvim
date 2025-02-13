-- better up/down, Add jumps 5 and greater to the jump list
vim.keymap.set(
	"n",
	"j",
	'v:count1 > 5 ? "m\'" .. v:count .. "gjm\'" .. (v:count1 > 20 ? "zz" : "") : "gj"',
	{ expr = true, silent = true }
)
vim.keymap.set(
	"n",
	"k",
	'v:count1 > 5 ? "m\'" .. v:count .. "gkm\'" .. (v:count1 > 20 ? "zz" : "") : "gk"',
	{ expr = true, silent = true }
)

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
vim.keymap.set("i", "<C-k>", "<nop>")
vim.keymap.set("i", "<C-j>", "<nop>")

-- nice replace macro, works with counts now
-- "https://github.com/community/community/discussions/29817"
vim.api.nvim_set_keymap(
	"n",
	"<leader>s",
	"':' .. (v:count ? '' : '%') .. 's/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>'",
	{ desc = "replace word under cursor", noremap = true, expr = true }
)

-- movement mappings
vim.keymap.set({ "n", "x" }, "<C-e>", "repeat('<C-e>', 5)", { noremap = true, expr = true })
vim.keymap.set({ "n", "x" }, "<C-y>", "repeat('<C-y>', 5)", { noremap = true, expr = true })
vim.keymap.set({ "n", "x" }, "<C-d>", "<C-d>zz", { noremap = true })
vim.keymap.set({ "n", "x" }, "<C-u>", "<C-u>zz", { noremap = true })

-- command line help
-- stylua: ignore start
vim.keymap.set("c", "<c-j>", "<nop>")
vim.keymap.set("c", "<c-k>", "<nop>")
vim.keymap.set("c", "<c-n>", function() require("cmp").complete() end)
vim.keymap.set("c", "<c-l>", "<right>")
vim.keymap.set("c", "<c-h>", "<left>")
-- stylua: ignore end

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
-- vim.keymap.set("t", "<C-w><c-q>", "<c-\\><c-n><c-w><c-q>", {})
-- vim.keymap.set("t", "<C-w><c-w>", "<c-\\><c-n><c-w><c-w>", {})

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

-- Easier pasting(with auto-indent)
vim.keymap.set("n", "gp", "`[v`]")
vim.keymap.set("n", "[p", ":pu!<cr>`[v`]=", { silent = true })
vim.keymap.set("n", "]p", ":pu<cr>`[v`]=", { silent = true })

-- Clear search with <esc>
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>")
vim.keymap.set("n", "gw", "*N")
vim.keymap.set("x", "gw", "*N")
vim.keymap.set("n", "<leader>gw", function()
	vim.cmd("windo diffthis")
end, { noremap = true, desc = "Git diff (w)indows" })

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set({ "n", "x" }, "n", "'Nn'[v:searchforward] .. 'zz'", { expr = true })
vim.keymap.set({ "n", "x" }, "N", "'nN'[v:searchforward] .. 'zz'", { expr = true })
vim.keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true })
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
	local str = vim.api.nvim_replace_termcodes(":hello worl<Left><Left>", true, false, true)
	vim.api.nvim_feedkeys(str, "t", false)
end
vim.keymap.set("n", "gy", Print_tmux_panes)
vim.keymap.set("n", "g.", Test_function)

-- Application Specific keymapings
--Neorg
vim.api.nvim_create_autocmd("FileType", {
	pattern = "norg",
	callback = function()
		vim.keymap.set("i", "<M-CR>", "<Plug>(neorg.itero.next-iteration)", { buffer = true })
		vim.keymap.set({ "o", "x" }, "ih", "<Plug>(neorg.text-objects.textobject.heading.inner)", { buffer = true })
		vim.keymap.set({ "o", "x" }, "ah", "<Plug>(neorg.text-objects.textobject.heading.outer)", { buffer = true })
	end,
})

local function feedkeys(keys)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), "n", true)
end

local function feedkeys_cmd(keys)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), "t", true)
end

local function pumvisible()
	return tonumber(vim.fn.pumvisible()) ~= 0
end

vim.keymap.set({ "c" }, "<C-n>", function()
	if pumvisible() then
		feedkeys("<C-n>")
	else
		feedkeys_cmd("<Tab>")
	end
end, { expr = true })

vim.keymap.set({ "i" }, "<C-j>", function()
	if pumvisible() then
		feedkeys("<C-n>")
	else
		feedkeys("<C-j>")
	end
end, { expr = true })

vim.keymap.set({ "c" }, "<C-j>", function()
	feedkeys("<C-n>")
end, { expr = true })

vim.keymap.set({ "i", "c" }, "<C-k>", function()
	if pumvisible() then
		feedkeys("<C-p>")
	elseif vim.lsp.buf_get_clients(0) ~= nil then
		vim.lsp.buf.signature_help()
		return ""
	else
		feedkeys("<C-k>")
	end
end, { expr = true })

vim.keymap.set({ "i", "n", "s" }, "<C-l>", function()
	if vim.snippet.active({ direction = 1 }) then
		vim.snippet.jump(1)
		return ""
	else
		feedkeys("<C-l>")
	end
end, { expr = true, silent = true })

vim.keymap.set({ "i", "n", "s" }, "<C-h>", function()
	if vim.snippet.active({ direction = -1 }) then
		vim.snippet.jump(-1)
		return ""
	else
		feedkeys("<C-h>")
	end
end, { expr = true, silent = true })

-- Function to manipulate paths in command mode
vim.keymap.set("c", "<C-l>", function()
	if pumvisible() then
		feedkeys_cmd("<C-y><Tab>")
	else
		feedkeys_cmd("<Tab>")
	end
end, { expr = true, silent = true })

vim.keymap.set("c", "<C-h>", function()
	if pumvisible() then
		feedkeys_cmd("<C-e>")
	end
	local cmd_line = vim.fn.getcmdline()
	local cursor_pos = vim.fn.getcmdpos()

	local prefix, path = cmd_line:match("^(%S+)%s*(.*)")
	if not path or path == "" then
		return "<C-h>"
	end

	local current_path = path:sub(1, cursor_pos - #prefix - 2)
	if current_path:match("[/\\]$") then
		current_path = current_path:sub(1, -2)
	end
	local new_path = vim.fn.fnamemodify(current_path, ":h") .. "/"
	local remaining_cmd = path:sub(cursor_pos - #prefix - 1)
	local new_cmd_line = prefix .. " " .. new_path .. remaining_cmd
	vim.fn.setcmdline(new_cmd_line)
	return ""
end, { expr = true, silent = true })

--Snippets
local function get_current_treesitter_language()
	-- Get the current Tree-sitter parser for the buffer
	local ts_parser = vim.treesitter.get_parser(0)
	if not ts_parser then
		return vim.bo.filetype -- Fallback to buffer-local filetype
	end

	-- Get the current node at the cursor
	local cursor = vim.api.nvim_win_get_cursor(0)
	local root = ts_parser:parse()[1]:root()
	local node = root:named_descendant_for_range(cursor[1] - 1, cursor[2], cursor[1] - 1, cursor[2])
	if not node then
		return vim.bo.filetype -- Fallback if no node is found
	end

	-- Check for language of the node
	local language_tree = ts_parser:language_for_range({ node:range() })
	return language_tree:lang() or vim.bo.filetype
end

local function load_snippets()
	local snippets = {}

	local all_snippets_path = vim.fn.stdpath("config") .. "/snippets/all.lua"
	local all_snippets = loadfile(all_snippets_path) or {}
  local t = type(all_snippets)
	if t == "function" then
		for k, v in pairs(all_snippets()) do
			snippets[k] = v
		end
	end

	local filetype = get_current_treesitter_language()
	if filetype then
		local ft_snippets_path = vim.fn.stdpath("config") .. "/snippets/" .. filetype .. ".lua"
		local ft_snippets = loadfile(ft_snippets_path) or {}
    t = type(ft_snippets)
		if t == "function" then
			for k, v in pairs(ft_snippets()) do
				snippets[k] = v
			end
		end
	end

	return snippets
end
CUSTOM_SELECTED_TEXT = ""
vim.keymap.set("x", "<C-n>", function()
	local previous_s_register = vim.fn.getreg("s")
	vim.cmd('normal! "sy') -- pull text to "s" register
	CUSTOM_SELECTED_TEXT = vim.fn.getreg("s")
	vim.fn.setreg("s", previous_s_register)
	feedkeys_cmd("gvc") -- gv(get visual mode back) and then change
end, { silent = true })

vim.keymap.set("i", "<C-y>", function()
	if pumvisible() then
		feedkeys("<C-y>")
		return ""
	end
	local my_snippets = load_snippets()
	local cursor_pos = vim.fn.col(".")
	local line = vim.fn.getline(".")
	local trigger = line:sub(1, cursor_pos - 1):match("[%w_]+$")
	-- Check if the trigger matches a defined snippet
	local snippet = my_snippets[trigger]
	if snippet then
		if type(snippet) == "function" then
			snippet = snippet(CUSTOM_SELECTED_TEXT)
      CUSTOM_SELECTED_TEXT = ""
		end

		local start_col = cursor_pos - #trigger
		vim.api.nvim_buf_set_text(0, vim.fn.line(".") - 1, start_col - 1, vim.fn.line(".") - 1, cursor_pos - 1, {})
		vim.snippet.expand(snippet)
	else
		-- Default <C-y> behavior if no snippet matches
		feedkeys("<C-y>")
	end
end, { silent = true })

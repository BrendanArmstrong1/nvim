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

-- toggle options
-- stylua: ignore start
vim.keymap.set("n", "<leader>td", Toggle_diagnostics, { desc = "Diagnostics" })
-- stylua: ignore end

-- Application Specific keymapings
--Neorg
vim.api.nvim_create_autocmd("FileType", {
	pattern = "norg",
	callback = function()
		vim.keymap.set( "i" , "<M-CR>", "<Plug>(neorg.itero.next-iteration)", { buffer = true })
		vim.keymap.set({ "o", "x" }, "ih", "<Plug>(neorg.text-objects.textobject.heading.inner)", { buffer = true })
		vim.keymap.set({ "o", "x" }, "ah", "<Plug>(neorg.text-objects.textobject.heading.outer)", { buffer = true })
	end,
})

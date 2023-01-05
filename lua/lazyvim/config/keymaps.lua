-- This file is automatically loaded by plugins.config


-- disable troublesome keys
vim.keymap.set("n", "<C-z>", "<nop>")
vim.keymap.set("i", "<C-z>", "<nop>")
vim.keymap.set("n", "<C-l>", "<nop>")
vim.keymap.set("i", "<C-l>", "<nop>")

-- nice replace macro
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])


-- movement mappings
vim.keymap.set({"n", "v"}, "<C-e>", "repeat('<C-e>', 5)", {noremap = true, expr = true})
vim.keymap.set({"n", "v"}, "<C-y>", "repeat('<C-y>', 5)", {noremap = true, expr = true})
vim.keymap.set({"n", "v"}, "<C-d>", "<C-d>zz", {noremap = true})
vim.keymap.set({"n", "v"}, "<C-u>", "<C-u>zz", {noremap = true})
vim.keymap.set({"n", "v"}, "n", "nzz", {noremap = true})
vim.keymap.set({"n", "v"}, "N", "Nzz", {noremap = true})

-- command line help
vim.keymap.set("c", "<c-j>", "<nop>")
vim.keymap.set("c", "<c-k>", "<nop>")
vim.keymap.set("c", "<c-l>", "<down>")
vim.keymap.set("c", "<c-h>", "<up>")

-- save in insert mode
vim.keymap.set("i", "<C-z><C-g>", "<cmd>:w<cr><esc>")
vim.keymap.set("n", "<C-z><C-g>", "<cmd>:w<cr><esc>")

-- fast quit
vim.keymap.set("n", "<c-z><c-q>", "<cmd>q!<CR>", {silent= true})
vim.keymap.set("n", "<c-z><c-d>", "<cmd>wq!<CR>", {silent= true})


-- terminal commands
vim.keymap.set("t", "<c-z>", "<c-\\><c-n>", {noremap = true})
vim.keymap.set("t", "<C-w><c-h>", "<c-\\><c-n><c-w>h", {})
vim.keymap.set("t", "<C-w><c-l>", "<c-\\><c-n><c-w>l", {})
vim.keymap.set("n", "<c-w><c-t>", "<CMD>vs term://zsh<CR>", {})


-- Move to window using the <meta> movement keys
vim.keymap.set("n", "<A-left>", "<C-w>h")
vim.keymap.set("n", "<A-down>", "<C-w>j")
vim.keymap.set("n", "<A-up>", "<C-w>k")
vim.keymap.set("n", "<A-right>", "<C-w>l")

-- Resize window using <shift> arrow keys
vim.keymap.set("n", "<S-Up>", "<cmd>resize +2<CR>",{silent = true})
vim.keymap.set("n", "<S-Down>", "<cmd>resize -2<CR>",{silent = true})
vim.keymap.set("n", "<S-Left>", "<cmd>vertical resize -2<CR>",{silent = true})
vim.keymap.set("n", "<S-Right>", "<cmd>vertical resize +2<CR>",{silent = true})

-- Move Lines
vim.keymap.set("n", "<A-j>", ":m .+1<CR>==",{silent = true})
vim.keymap.set("v", "<A-j>", ":m '>+1<CR>gv=gv",{silent = true})
vim.keymap.set("i", "<A-j>", "<Esc>:m .+1<CR>==gi",{silent = true})
vim.keymap.set("n", "<A-k>", ":m .-2<CR>==",{silent = true})
vim.keymap.set("v", "<A-k>", ":m '<-2<CR>gv=gv",{silent = true})
vim.keymap.set("i", "<A-k>", "<Esc>:m .-2<CR>==gi",{silent = true})

-- Switch buffers with <ctrl>
vim.keymap.set("n", "<C-Left>", "<cmd>bprevious<cr>")
vim.keymap.set("n", "<C-Right>", "<cmd>bnext<cr>")

-- Easier pasting
vim.keymap.set("n", "[p", ":pu!<cr>")
vim.keymap.set("n", "]p", ":pu<cr>")

-- Clear search with <esc>
vim.keymap.set({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>")
vim.keymap.set("n", "gw", "*N")
vim.keymap.set("x", "gw", "*N")

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
vim.keymap.set("n", "n", "'Nn'[v:searchforward]", { expr = true })
vim.keymap.set("x", "n", "'Nn'[v:searchforward]", { expr = true })
vim.keymap.set("o", "n", "'Nn'[v:searchforward]", { expr = true })
vim.keymap.set("n", "N", "'nN'[v:searchforward]", { expr = true })
vim.keymap.set("x", "N", "'nN'[v:searchforward]", { expr = true })
vim.keymap.set("o", "N", "'nN'[v:searchforward]", { expr = true })

-- Add undo break-points
vim.keymap.set("i", ",", ",<c-g>u")
vim.keymap.set("i", ".", ".<c-g>u")
vim.keymap.set("i", ";", ";<c-g>u")


-- better indenting
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")



-- highlights under cursor
--vim.keymap.set("n", "<leader>hh", vim.show_pos, { desc = "Highlight Groups at cursor" })

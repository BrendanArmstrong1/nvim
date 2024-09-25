local fn = vim.fn
local o = vim.opt

o.completeopt = "menu,menuone" -- A comma separated list of options for Insert mode completion
o.mouse = "a"
o.number = true -- show line numbers (or only the current one)
o.relativenumber = true -- line numbers
o.shiftwidth = 4
o.smartcase = true -- smart case
o.smartindent = true -- make indenting smarter again
o.swapfile = false -- enable/disable swap file creation
o.expandtab = true -- expand tabs into spaces on save
o.softtabstop = 2
o.tabstop = 2 -- Number of spaces tabs count for
o.shiftround = true -- Round indent
o.shiftwidth = 2 -- Size of an indent
o.splitright = true
o.splitbelow = true
o.undodir = fn.stdpath("data") .. "/undodir" -- set undo directory
o.undolevels = 10000
o.undofile = true -- enable/disable undo file creation
o.shadafile = fn.stdpath("data") .. "/viminfo"
o.shada = "<800,'100,/50,:100,h"
o.laststatus = 3 -- only one status bar
o.updatetime = 50
o.diffopt = "internal,filler,closeoff,vertical"

o.dictionary = fn.stdpath("config") .. "/spell/american-english"
o.spelllang = { "en_us" }

local is_wsl = (function()
	local output = vim.fn.systemlist("uname -r")
	return not not string.find(output[1] or "", "WSL")
end)()
local is_mac = vim.fn.has("macunix") == 1
local is_linux = not is_wsl and not is_mac

if is_linux then
	o.clipboard:append("unnamedplus") -- system clipboard
end

o.cmdheight = 1
o.cursorline = false -- Enable highlighting of the current line
o.formatoptions = "jqlnt" -- tcqj
o.grepformat = "%f:%l:%c:%m"
o.grepprg = "rg --vimgrep"
o.inccommand = "nosplit" -- preview incremental substitute
o.joinspaces = false -- No double spaces with join after a dot
o.pumblend = 10 -- Popup blend
o.pumheight = 10 -- Maximum number of entries in a popup
o.scrolloff = 4 -- Lines of context
o.showmode = false -- dont show mode since we have a statusline
o.sidescrolloff = 8 -- Columns of context
o.signcolumn = "yes" -- Always show the signcolumn, otherwise it would shift the text each time
o.spelllang = { "en" }
o.termguicolors = true -- True color support
o.timeoutlen = 300
o.ttimeoutlen = 1 -- prevent <esc> from being mapped to <alt> on quick keystrokes
o.wildmode = "longest:full,full" -- Command-line completion mode
o.wildignorecase = true -- When set case is ignored when completing file names and directories
o.wrap = false -- Disable line wrap

if vim.fn.has("nvim-0.9.0") == 1 then
	vim.opt.splitkeep = "screen"
	vim.o.shortmess = "filnxtToOFWIcC"
end

-- fix markdown indentation settings
vim.g.markdown_recommended_style = 0
vim.g.markdown_fenced_languages = { "html", "js=javascript", "ruby", "python", "rust", "lua", "vim", "typescript" }

-- fix auto rust stuff
vim.g.rust_recommended_style = false

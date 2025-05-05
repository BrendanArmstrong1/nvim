local fn = vim.fn
local o = vim.opt

local opts_info = vim.api.nvim_get_all_options_info()

local opt = setmetatable({}, {
	__newindex = function(_, key, value)
		vim.o[key] = value
		local scope = opts_info[key].scope
		if scope == "win" then
			vim.wo[key] = value
		elseif scope == "buf" then
			vim.bo[key] = value
		end
	end,
})

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
o.undolevels = 1000
if vim.opt_local.binary:get() then
	o.undofile = false -- undo files create huge lag in binary files
else
	o.undofile = true
end
o.shadafile = fn.stdpath("data") .. "/viminfo"
o.shada = "<800,'100,/50,:100,h"
o.laststatus = 3 -- only one status bar

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
o.updatetime = 50
o.timeoutlen = 300
o.ttimeoutlen = 1 -- prevent <esc> from being mapped to <alt> on quick keystrokes
o.wrap = false -- Disable line wrap

if vim.fn.has("nvim-0.9.0") == 1 then
	vim.opt.splitkeep = "screen"
	vim.o.shortmess = table.concat({
		"f", -- (file x of x) instead of just (x of x)
		"l", -- use "999L, 888B" instead of "999 lines, 888 bytes"
		"t", -- truncate file messages at start
		"T", -- truncate non-file messages in middle
		"o", -- file-read message overwrites previous
		"O", -- file-read message overwrites previous
		"F", -- Don't give file info when editing a file
		"W", -- Dont show [w] or written when writing
		"A", -- ignore annoying swap file messages
		"s", -- don't give "search hit BOTTOM, continuing at TOP"
		"c", -- don't give |ins-completion-menu| messages
	})
end

local function add(value, str, sep)
	sep = sep or ","
	str = str or ""
	value = type(value) == "table" and table.concat(value, sep) or value
	return str ~= "" and table.concat({ value, str }, sep) or value
end

-- A comma separated list of options for Insert mode completion
o.completeopt = add({
	"menu",
	"menuone",
	"noinsert",
	"noselect",
	"popup",
	 "fuzzy",
})

opt.cpoptions = table.concat({
	"a", -- on read, set alternate filename for window
	"A", -- on write, set alternate filename for window
	"F", -- on write, change the filename for buffer
	"B", -- allows for use of \ in mappings, eg. \<esc>
	"c", -- search continues at the end of match on cursor
	"e", -- put <CR> at the end of ":@r" register executions
	"s", -- set buffer options when entering buffer for first time
	"_", -- include whitespace after word on "cw"
})

opt.formatoptions = table.concat({
	"1",
	"q", -- continue comments with gq"
	"c", -- Auto-wrap comments using textwidth
	"n", -- Recognize numbered lists
	"t", -- autowrap lines using text width value
	"p", -- Don't break lines at single spaces that follow periods.
	"j", -- remove a comment leader when joining lines.
	"lv", -- Only break if the line was not longer than 'textwidth' when the insert
	-- started and only at a white character that has been entered during the
	-- current insert command.
})

vim.o.diffopt = add({
	"internal",
	"filler",
	"closeoff",
	"vertical",
	"iwhite",
	"hiddenoff",
	"foldcolumn:0",
	"context:4",
	"algorithm:histogram",
	"indent-heuristic",
}, vim.o.diffopt)

vim.o.fillchars = add({
	"vert:▕", -- alternatives │
	"fold: ",
	"eob: ", -- suppress ~ at EndOfBuffer
	"diff:─", -- alternatives: ⣿ ░
	"msgsep:‾",
	"foldopen:▾",
	"foldsep:│",
	"foldclose:▸",
})

-- when to open folds
vim.o.foldopen = add({
	"block", -- (, {, [[, [{, etc.
	-- "hor", -- horizontal movements: "l", "w", "fx", etc.
	"mark", -- jumping to a mark: "'m", CTRL-O, etc.
	"percent", -- "%"
	"quickfix", -- ":cn", ":crew", ":make", etc.
	"search", -- search for a pattern: "/", "n", "*", "gd", etc.
	"tag", -- jumping to a tag: ":ta", CTRL-T, etc.
	"undo", -- undo or redo: "u" and CTRL-R
})

o.foldlevel = 99
o.foldlevelstart = 10
o.foldmethod = "expr"
o.foldexpr = "nvim_treesitter#foldexpr()"
o.foldtext = "v:lua.folds()"

vim.o.wildmode = "longest:full,full,noselect" -- Command-line completion mode
-- vim.o.wildcharm = api.nvim_eval([[char2nr("\<C-Z>")]]) -- FIXME: what's the correct way to do this?

vim.cmd("set wildcharm=<C-Z>")
vim.o.wildmenu = true
vim.o.wildignorecase = true -- Ignore case when completing file names and directories
-- Binary
vim.o.wildignore = add({
	"*.aux,*.out,*.toc",
	"*.o,*.obj,*.dll,*.jar,*.pyc,*.rbc,*.class",
	"*.ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp",
	"*.avi,*.m4a,*.mp3,*.oga,*.ogg,*.wav,*.webm",
	"*.eot,*.otf,*.ttf,*.woff",
	"*.doc,*.pdf",
	"*.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz",
	-- Cache
	".sass-cache",
	"*/vendor/gems/*,*/vendor/cache/*,*/.bundle/*,*.gem",
	-- Temp/System
	"*.*~,*~ ",
	"*.swp,.lock,.DS_Store,._*,tags.lock",
})
vim.o.wildoptions = "pum"

-- fix markdown indentation settings
vim.g.markdown_recommended_style = 0
vim.g.markdown_fenced_languages = { "html", "js=javascript", "ruby", "python", "rust", "lua", "vim", "typescript" }

-- fix auto rust stuff
vim.g.rust_recommended_style = false

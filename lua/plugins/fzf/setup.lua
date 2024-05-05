local M = {}

local ignore_string = {
	".git",
	"target",
	"*.dll",
	"*.seq",
	"*.stp",
	"*.zip",
	"*.whl",
	"*.lib",
	"*.pdf",
	"*.jpg",
	"*.aoeb",
	"*.png",
	"*.docx",
}

M.setup = function()
	local binding_cmd = "--bind=ctrl-/:toggle-preview"
	vim.env.FZF_DEFAULT_COMMAND = "rg --files --no-ignore --hidden --follow --glob '!{"
		.. table.concat(ignore_string, ",")
		.. "}'"
	vim.env.FZF_DEFAULT_OPTS = "--layout=reverse --ansi --info=inline -m --border --margin=0 --padding=0 " .. binding_cmd
	vim.g.fzf_vim = {
		preview_window = { "right,50%,<70(hidden)", "ctrl-/" },
		buffers_jump = 1,
		commits_log_options = '--graph --color=always --format="%C(auto)%h %an %C(blue)%s %C(yellow)%C(bold)%cr"',
		commands_expect = "enter",
	}
	vim.g.fzf_layout = {
		down = "50%",
	}
	vim.g.fzf_action = {
		["ctrl-t"] = "tab split",
		["ctrl-x"] = "split",
		["ctrl-v"] = "vsplit",
	}
	vim.g.fzf_colors = {
		fg = { "fg", "Normal" },
		bg = { "bg", "Normal" },
		hl = { "fg", "Comment" },
		["fg+"] = { "fg", "CursorLine", "CursorColumn", "Normal" }, -- current line
		["bg+"] = { "bg", "CursorLine", "CursorColumn" }, -- current line
		["hl+"] = { "fg", "Statement" }, -- current line
		info = { "fg", "PreProc" },
		border = { "fg", "Ignore" },
		prompt = { "fg", "Conditional" },
		pointer = { "fg", "Exception" },
		marker = { "fg", "Keyword" },
		spinner = { "fg", "Label" },
		header = { "fg", "Comment" },
	}
end

return M

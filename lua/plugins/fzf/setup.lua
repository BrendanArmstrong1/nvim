local util = require("plugins.fzf.util")

M = {}

function M.default_command()
	vim.env.FZF_DEFAULT_COMMAND = "rg --files --no-ignore --hidden --follow --glob '!{"
		.. util.ignored_filetypes
		.. "}'"
	vim.env.FZF_DEFAULT_OPTS = "--layout=reverse --inline-info -m"
end

function M.layout()
	vim.g.fzf_layout = {
		down = "50%",
	}
end

function M.fzfiles_command()
	vim.api.nvim_create_user_command("FzFiles", function(args)
		vim.fn["fzf#vim#files"](
			args["args"],
			vim.fn["fzf#vim#with_preview"]({ options = { "--layout=reverse", "--info=inline" } })
		)
	end, { bang = false, nargs = "?", complete = "dir" })
end

function M.setup()
	vim.g.fzf_vim = {
		preview_window = { "right,50%,<70(hidden)", "ctrl-/" },
		buffers_jump = 1,
		commits_log_options = '--graph --color=always --format="%C(auto)%h %an %C(blue)%s %C(yellow)%C(bold)%cr"',
		commands_expect = "enter,ctrl-v,ctrl-x",
	}
  vim.g.fzf_action = {
    ["ctrl-t"] = 'tab split',
    ["ctrl-x"] = 'split',
    ["ctrl-v"] = 'vsplit',

  }
end

function M.colors()
	vim.g.fzf_colors = {
		fg = { "fg", "Normal" },
		bg = { "bg", "Normal" },
		hl = { "fg", "Comment" },
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

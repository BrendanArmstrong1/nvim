local util = require("plugins.fzf.util")

M = {}

function M.fzfiles_command()
	vim.api.nvim_create_user_command("FzFiles", function(args)
		vim.fn["fzf#vim#files"](
			args["args"],
			vim.fn["fzf#vim#with_preview"]({ options = { "--layout=reverse", "--info=inline" } })
		)
	end, { bang = false, nargs = "?", complete = "dir" })
end


function M.fzhelptags_command()
	vim.api.nvim_create_user_command("FzHelpTags", function(_)
		vim.fn["fzf#run"](vim.fn["fzf#wrap"]({
			source = util.find_tags(),
			sinklist = util.process_help_tags,
			options = {
				"--layout=reverse",
				"-m",
				"--preview",
				"rg --no-heading --line-number -A 20 -B 3 --color=always {3} {2} || echo {3}",
				"--ansi",
				"--tiebreak=begin",
				"--delimiter",
				"\t",
				"--with-nth",
				"1",
				"--expect=ctrl-v,enter",
			},
		}))
	end, { bang = false, nargs = "?" })
end

function M.setup()
	vim.env.FZF_DEFAULT_COMMAND = "rg --files --no-ignore --hidden --follow --glob '!{"
		.. util.ignored_filetypes
		.. "}'"
	vim.env.FZF_DEFAULT_OPTS = "--layout=reverse --inline-info -m"
	vim.env.FZF_PREVIEW_COMMAND = "bat --style=numbers,changes --wrap never --color always {} || cat {} || tree -C {}"
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

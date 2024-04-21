local M = {}

M.setup = function()
	local sink = require("plugins.fzf.fzhelp_tags.sink")
	local source = require("plugins.fzf.fzhelp_tags.source")
	local options = {
		"+m",
		"--preview",
		"rg --no-heading -A 18 -B 3 --color=always {3} {2} || echo {3}",
		"--tiebreak=begin",
		"--delimiter",
		"\t",
		"--with-nth",
		"1",
		"--expect=ctrl-v,enter",
	}
	local fzf_opts_wrap = vim.fn["fzf#wrap"]({ source = source.find_tags(), options = options })
	fzf_opts_wrap["sink*"] = sink.process_help_tags

	vim.api.nvim_create_user_command("FzHelpTags", function(_)
		vim.fn["fzf#run"](fzf_opts_wrap)
	end, {})
end

return M

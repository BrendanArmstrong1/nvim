local util = require("plugins.fzf.help_tags.util")

local M = {}

M.setup = function()
	vim.api.nvim_create_user_command("FzHelpTags", function(_)
		vim.fn["fzf#run"](vim.fn["fzf#wrap"]({
			source = util.find_tags(),
			sinklist = util.process_help_tags,
			options = {
				"+m",
				"--preview",
				"rg --no-heading -A 18 -B 3 --color=always {3} {2} || echo {3}",
				"--tiebreak=begin",
				"--delimiter",
				"\t",
				"--with-nth",
				"1",
				"--expect=ctrl-v,enter",
			},
		}))
	end, { bang = false })
end

return M

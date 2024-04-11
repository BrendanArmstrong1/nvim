local M = {}

M.process_help_tags = function(line)
	local command = line[1]
	local info = vim.split(line[2], "\t")
	local tag = string.sub(info[4], 3, #info[4] - 2)
	local cmd
	if command == "enter" then
		cmd = "help "
	elseif command == "ctrl-v" then
		cmd = "vert help "
	end
	vim.cmd(cmd .. tag)
end

return M

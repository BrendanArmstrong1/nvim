return {
	["for"] = "for ${1:index}, ${2:value} in ipairs(${3:table}) do\n\t$0\nend",
	["func"] = "function ${1:name}(${2:args})\n\t$0\nend",
	["lims"] = function(arg)
    vim.print(arg)
		if arg == "" then
			return '{"value": ${1:value}, "min": ${2:min}, "max": ${3:max}}'
		end
		return '{"value": ${1:' .. arg .. '}, "min": ${2:min}, "max": ${3:max}}'
	end,
}

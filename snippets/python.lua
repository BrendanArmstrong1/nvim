return {
	["lims"] = function(arg)
		if arg == "" then
			return '{"value": ${1:value}, "min": ${2:min}, "max": ${3:max}}'
		end
		return '{"value": ${1:' .. arg .. '}, "min": ${2:min}, "max": ${3:max}}'
	end,
  ["for"] = function()
    return [[
for ${1:i} in ${2:iterable}:
    ${3:block}
    ]]
  end,

	["main"] = function()
		local r = [[
def main():
    $0

if __name__ == '__main__':
    main()
  ]]
		return r
	end,
  ["amain"] = function()
    local r = [[
async def main():
    $0

if __name__ == '__main__':
    asyncio.run(main())
  ]]
    return r
  end,
}

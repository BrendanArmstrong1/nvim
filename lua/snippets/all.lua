local same = function(index)
  return f(function(arg)
    return arg[1]
  end, { index })
end

return {
  s(
    "curtime",
    f(function()
      return os.date("%D - %H:%M")
    end)
  ),
  s("sametest", fmt([[example: {}, function: {}]], { i(1), same(1) })),
}

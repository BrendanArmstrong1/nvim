local get_anyhow_presence = function(position)
  return d(position, function()
    local nodes = {}
    table.insert(nodes, t(" "))

    local lines = vim.api.nvim_buf_get_lines(0, 0, -1, false)
    for _, line in ipairs(lines) do
      if line:match("anyhow::Result") then
        table.insert(nodes, t(" -> Result<()> "))
        break
      end
    end
    return sn(nil, c(1, nodes))
  end, {})
end

return {
  -- print snips
  s({ trig = "print" }, fmt([[println!("{{{}}}", {});]], { c(1, { t(":?"), t("") }), i(2) })),
  s({ trig = "format" }, fmt([[format!("{{{}}}", {});]], { c(1, { t(":?"), t("") }), i(2) })),
  -- format

  -- fn snips

  -- Test snips
  s(
    "modtest",
    fmt(
      [[
  #[cfg(test)]
  mod test {{ 
  {} 
    {} 
  }}
  ]],
      { c(1, { t({ "  use super::*", "\t" }), t("") }), i(0) }
    )
  ),
  s(
    "test",
    fmt(
      [[
  #[test]
  fn {}(){}{{
    {}
  }}
  ]],
      { i(1, "testname"), get_anyhow_presence(2), i(0) }
    )
  ),
}

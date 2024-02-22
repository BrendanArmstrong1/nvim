return {
	{
		"L3MON4D3/LuaSnip",
		keys = { { "<c-n>", mode = {"x"} } },
		config = function()
			require("luasnip.loaders.from_lua").lazy_load({ paths = "./lua/snippets" })
			require("luasnip").setup({
				history = true,
				delete_check_events = "TextChanged",
				update_events = "TextChanged,TextChangedI",
				enable_autosnippets = true,
				store_selection_keys = "<c-n>",
				ext_opts = {
					[require("luasnip.util.types").choiceNode] = {
						active = {
							virt_text = { { " <- choiceNode", "Comment" } },
						},
					},
				},
			})
		end,
	},
}

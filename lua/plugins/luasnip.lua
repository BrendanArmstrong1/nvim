return {
	{
		"L3MON4D3/LuaSnip",
		keys = { { "<c-n>", mode = { "x" } } },
		dependencies = { "BrendanArmstrong1/lua_snippet_repo.nvim" },
		config = function()

      local function extend_fts(extended_fts)
        setmetatable(extended_fts, {
          -- if the filetype is not extended, only it itself should be loaded.
          -- preventing ifs via __index.
          __index = function(t, ft)
            local val = { ft }
            rawset(t, ft, val)
            return val
          end,
        })

        for ft, _ in pairs(extended_fts) do
          -- append the regular filetype to the extend-filetypes.
          table.insert(extended_fts[ft], ft)
        end

        return function(_)
          local buffers = vim.fn.tabpagebuflist()
          local fts = vim.split(vim.api.nvim_buf_get_option(buffers[1], "filetype"), ".", true)
          local res = {}

          for _, ft in ipairs(fts) do
            vim.list_extend(res, extended_fts[ft])
          end

          return res
        end
      end

			local path = require("lua_snippet_repo").load_snippets()
			require("luasnip.loaders.from_lua").lazy_load({ paths = path })
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
				ft_func = require("luasnip.extras.filetype_functions").from_pos_or_filetype,
				load_ft_func = extend_fts({
          markdown = {"tex", "lua", "json", "python"},
          html = {"javascript"}
        }),
			})
		end,
	},
}

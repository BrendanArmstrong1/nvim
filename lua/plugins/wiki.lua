return {
	{
		"lervag/wiki.vim",
		keys = {
			{ "<leader>ww", desc = "open the wiki" },
			{ "<leader>w<leader>w", desc = "open the wiki journal" },
			{ "<leader>fw", "<cmd>WikiPages<CR>", desc = "open the wiki" },
		},
		ft = { "markdown" },
		config = function()
      vim.g.wiki_index_name = "_index.md"
      vim.g.wiki_root = vim.fn.expand("~/notes/")
			vim.g.wiki_link_creation = {
				md = {
					link_type = "md",
					url_extension = "",
					url_transform = function(x)
						return "/wiki/" .. x
					end,
				},
				_ = {
					link_type = "wiki",
					url_extension = "",
				},
			}
			vim.g.wiki_templates = {
				{
					match_func = function(_)
						return true
					end,
	         source_func = function (ctx)
	           vim.fn.append(0, '+++')
	           vim.fn.append(1, "title = '" .. ctx["name"] .. "'")
	           vim.fn.append(2, 'date = ' .. ctx["date"])
	           vim.fn.append(3, 'math = false')
	           vim.fn.append(4, '+++')
	         end
				},
			}
	     vim.g.wiki_journal = {
	       name = "journal",
	       root = vim.fn.expand("~/journal/"),
	       frequency = 'daily',
	       date_format = {
	         daily = '%Y/%m/%d',
	         weekly = '%Y_w%V',
	         monthly = '%Y_m%m',
	       }
	     }
		end,
	},
}

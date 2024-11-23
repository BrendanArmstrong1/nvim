return {
	{
		"nvim-neorg/neorg",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-treesitter/nvim-treesitter-textobjects",
			"nvim-cmp",
			"nvim-lua/plenary.nvim",
		},
		build = ":Neorg sync-parsers",
		keys = {
			{ "<leader>w<leader>w", "<cmd>Neorg journal today<cr>", desc = "neorg Journal" },
			{ "<leader>ww", "<cmd>Neorg index<cr>", desc = "neorg index" },
		},
		cmd = { "Neorg" },
		ft = { "norg" },
		-- lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
		version = "*", -- Pin Neorg to the latest stable release
		config = function()
			require("neorg").setup({
				load = {
					["core.defaults"] = {}, -- Loads default behaviour
					-- ["core.concealer"] = {}, -- Adds pretty icons to your documents
					["core.ui.calendar"] = {},
					["core.completion"] = { config = { engine = "nvim-cmp", name = "[Norg]" } },
					["core.integrations.nvim-cmp"] = {},
					["core.concealer"] = { config = { icon_preset = "diamond" } },
					["core.esupports.metagen"] = { config = { type = "auto", update_date = true } },
					["core.qol.toc"] = {},
					["core.qol.todo_items"] = {},
					["core.looking-glass"] = {},
					["core.presenter"] = { config = { zen_mode = "zen-mode" } },
					["core.export"] = {},
					["core.text-objects"] = {},
					["core.export.markdown"] = { config = { extensions = "all" } },
					["core.summary"] = {},
					["core.tangle"] = { config = { report_on_empty = false } },
					["core.keybinds"] = {
						-- https://github.com/nvim-neorg/neorg/blob/main/lua/neorg/modules/core/keybinds/keybinds.lua
						config = {
							default_keybinds = true,
							neorg_leader = "<Leader><Leader>",
						},
					},
					["core.dirman"] = { -- Manages Neorg workspaces
						config = {
							workspaces = {
								notes = "~/neorg/notes",
								work = "~/neorg/work",
							},
							default_workspace = "work",
							index = "index.norg", -- The name of the main (root) .norg file
						},
					},
				},
			})
		end,
	},
	-- {
	-- 	"lervag/wiki.vim",
	-- 	keys = {
	-- 		{ "<leader>ww", desc = "open the wiki" },
	-- 		{ "<leader>w<leader>w", desc = "open the wiki journal" },
	-- 		{ "<leader>fw", "<cmd>WikiPages<CR>", desc = "open the wiki" },
	-- 	},
	--
	-- 	-- ft = { "markdown" },
	-- 	config = function()
	-- 		vim.g.wiki_index_name = "_index.md"
	-- 		vim.g.wiki_root = vim.fn.expand("~/ssd/Wiki/content/")
	-- 		vim.g.wiki_link_creation = {
	-- 			md = {
	-- 				link_type = "md",
	-- 				url_extension = "",
	-- 				url_transform = function(x)
	-- 					return "/wiki/" .. x
	-- 				end,
	-- 			},
	-- 			_ = {
	-- 				link_type = "wiki",
	-- 				url_extension = "",
	-- 			},
	-- 		}
	-- 		vim.g.wiki_templates = {
	-- 			{
	-- 				match_func = function(_)
	-- 					return true
	-- 				end,
	--          source_func = function (ctx)
	--            vim.fn.append(0, '+++')
	--            vim.fn.append(1, "title = '" .. ctx["name"] .. "'")
	--            vim.fn.append(2, 'date = ' .. ctx["date"])
	--            vim.fn.append(3, 'math = false')
	--            vim.fn.append(4, '+++')
	--          end
	-- 			},
	-- 		}
	--      vim.g.wiki_journal = {
	--        name = "journal",
	--        root = vim.fn.expand("~/journal/"),
	--        frequency = 'daily',
	--        date_format = {
	--          daily = '%Y/%m/%d',
	--          weekly = '%Y_w%V',
	--          monthly = '%Y_m%m',
	--        }
	--      }
	-- 	end,
	-- },
}

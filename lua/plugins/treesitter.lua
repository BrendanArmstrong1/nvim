return {
	{ "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },

	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		event = "BufReadPost",
		dependencies = { "nvim-treesitter/nvim-treesitter", "JoosepAlviste/nvim-ts-context-commentstring" },
		config = function()
			vim.g.skip_ts_context_commentstring_module = true
			require("ts_context_commentstring").setup({
				enable_autocmd = false,
			})
			local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
			vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
			vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)
			vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f_expr, { expr = true })
			vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F_expr, { expr = true })
			vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t_expr, { expr = true })
			vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T_expr, { expr = true })
			require("nvim-treesitter.configs").setup({
				textobjects = {
					select = { enable = false },
					move = {
						enable = true,
						set_jumps = true, -- whether to set jumps in the jumplist
						goto_next_start = {
							["]]"] = "@function.outer",
							["]m"] = { query = "@class.outer", desc = "Next class start" },
						},
						goto_next_end = {
							["]["] = "@function.outer",
							["]M"] = "@class.outer",
						},
						goto_previous_start = {
							["[["] = "@function.outer",
							["[m"] = "@class.outer",
						},
						goto_previous_end = {
							["[]"] = "@function.outer",
							["[M"] = "@class.outer",
						},
					},
				},
			})
		end,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		event = "BufReadPost",
		-- commit = "aa0c7dd29631ee8c2df738d99bd33b762b3a6e22",
		dependencies = {
			{
				"nvim-treesitter/nvim-treesitter-context",
				config = function()
					require("treesitter-context").setup({
						enable = true,
						max_lines = 3,
					})
				end,
			},
			{
				"andymass/vim-matchup",
				config = function()
					vim.g.matchup_matchparen_offscreen = { method = "popup" }
				end,
			},
		},
		config = function()
			require("nvim-treesitter.configs").setup({
				auto_install = false,
				sync_install = false,
				ensure_installed = {
					"bash",
					"html",
					"javascript",
					"json",
					"lua",
					"c",
					"rust",
					"latex",
          "typst",
					"markdown",
					"markdown_inline",
					"python",
					"query",
					"regex",
					"tsx",
					"typescript",
					"vim",
					"yaml",
				},
				highlight = {
					enable = true,
					disable = function(_, buf) -- "_" variable is lang
						local max_filesize = 10000 * 1024 -- 1000 KB
						local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
						if ok and stats and stats.size > max_filesize then
							vim.notify("Tree sitter disabled")
							return true
						end
					end,
					additional_vim_regex_highlighting = false,
				},
				indent = {
					enable = true,
					disable = { "python", "markdown" },
				},
				playground = {
					enable = true,
					disable = {},
					updatetime = 25, -- Debounced time for highlighting nodes in the playground from source code
					persist_queries = false, -- Whether the query persists across vim sessions
					keybindings = {
						toggle_query_editor = "o",
						toggle_hl_groups = "i",
						toggle_injected_languages = "t",
						toggle_anonymous_nodes = "a",
						toggle_language_display = "I",
						focus_language = "f",
						unfocus_language = "F",
						update = "R",
						goto_node = "<cr>",
						show_help = "?",
					},
				},
				incremental_selection = {
					enable = false,
					keymaps = {
						init_selection = "S",
						node_incremental = "S",
						scope_incremental = "gn",
						node_decremental = "H",
					},
				},
				query_linter = {
					enable = true,
					use_virtual_text = true,
					lint_events = { "BufWrite", "CursorHold" },
				},
				endwise = {
					enable = true,
				},
				textobjects = {
					select = {
						enable = false,
					},
					move = {
						enable = false,
					},
					lsp_interop = {
						enable = false,
					},
				},
			})
		end,
	},
}

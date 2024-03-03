return {
	{ "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },

	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		event = "BufReadPost",
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			local ts_repeat_move = require("nvim-treesitter.textobjects.repeatable_move")
			vim.keymap.set({ "n", "x", "o" }, ";", ts_repeat_move.repeat_last_move_next)
			vim.keymap.set({ "n", "x", "o" }, ",", ts_repeat_move.repeat_last_move_previous)
			vim.keymap.set({ "n", "x", "o" }, "f", ts_repeat_move.builtin_f)
			vim.keymap.set({ "n", "x", "o" }, "F", ts_repeat_move.builtin_F)
			vim.keymap.set({ "n", "x", "o" }, "t", ts_repeat_move.builtin_t)
			vim.keymap.set({ "n", "x", "o" }, "T", ts_repeat_move.builtin_T)
			require("nvim-treesitter.configs").setup({
				textobjects = {
					select = { enable = false },
					move = {
						enable = true,
						set_jumps = true, -- whether to set jumps in the jumplist
						goto_next_start = {
							["]m"] = "@function.outer",
							["]]"] = { query = "@class.outer", desc = "Next class start" },
						},
						goto_next_end = {
							["]M"] = "@function.outer",
							["]["] = "@class.outer",
						},
						goto_previous_start = {
							["[m"] = "@function.outer",
							["[["] = "@class.outer",
						},
						goto_previous_end = {
							["[M"] = "@function.outer",
							["[]"] = "@class.outer",
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
					disable = { "python" },
				},
				context_commentstring = {
					enable = true,
					enable_autocmd = false,
				},
				incremental_selection = {
					enable = true,
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

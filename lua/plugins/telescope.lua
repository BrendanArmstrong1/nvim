local M = {
	"nvim-telescope/telescope.nvim",
	dependencies = {
		{ "nvim-lua/plenary.nvim" },
		{ "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
	},
	cmd = { "Telescope", "Tel" }, -- lazy loads on these commands
	keys = {
		-- { "<leader>?", "<cmd>Telescope grep_string<cr>", desc = "find word under cursor" },
		-- { "<leader>/", "<cmd>Telescope live_grep<cr>", desc = "RG" },
		{ "<leader>fd", "<cmd>Telescope diagnostics<cr>", desc = "Diagnostics" },
		{ "<leader>fr", "<cmd>Telescope lsp_references<cr>", desc = "lsp references" },
		{ "<leader>fp", "<cmd>Telescope projects<cr>", desc = "Find Git Files" },
		{ "<leader>fb", "<cmd>Telescope buffers show_all_buffers=true<cr>", desc = "Switch Buffer" },
		{ "<leader>FO", "<cmd>Telescope oldfiles<cr>", desc = "Recent" },
		-- { "<leader>fk", "<cmd>Telescope help_tags<cr>", desc = "Help Pages" },
		-- { "<leader>FK", "<cmd>Telescope keymaps<cr>", desc = "Key Maps" },
		-- { "<leader>fl", "<cmd>Telescope current_buffer_fuzzy_find<cr>", desc = "Buffer" },
		{ "<leader>F:", "<cmd>Telescope commands<cr>", desc = "Commands" },
		{ "<leader>f;", "<cmd>Telescope command_history<cr>", desc = "Command History" },
		{ "<leader>f'", "<cmd>Telescope marks<cr>", desc = "Jump to Mark" },
		-- { "<leader>FC", "<cmd>Telescope git_bcommits<cr>", desc = "git buffer commits" },
		-- { "<leader>FG", "<cmd>Telescope git_files<cr>", desc = "Find Git Files" },
		-- { "<leader>FH", "<cmd>Telescope git_status<CR>", desc = "status" },
		-- { "<leader>FR", "<cmd>Telescope git_branches<cr>", desc = "Branches" },
		--   {
		--     "<leader>ff",
		--     function()
		--       require("telescope.builtin").find_files({
		--         find_command = {
		--           "rg",
		--           "--files",
		--         },
		--       })
		--     end,
		--     desc = "Find Files ignoring logs",
		--   },
		-- {
		-- 	"<leader>FF",
		-- 	function()
		-- 		require("telescope.builtin").find_files({
		-- 			no_ignore = true,
		-- 		})
		-- 	end,
		-- 	desc = "Find Files (no ignore)",
		-- },
		-- {
		-- 	"<leader>?",
		-- 	function()
		-- 		vim.cmd('normal! "vy')
		-- 		local vis_sel = vim.fn.getreg("v")
		-- 		require("telescope.builtin").grep_string({
		-- 			search = vis_sel,
		-- 		})
		-- 	end,
		-- 	desc = "find word in visual",
		-- 	mode = { "x" },
		-- },
		-- {
		-- 	"<leader>FS",
		-- 	function()
		-- 		require("telescope.builtin").git_commits({
		-- 			git_command = {
		-- 				"git",
		-- 				"log",
		-- 				"--pretty=oneline",
		-- 				-- "--abbrev-commit",
		-- 				"--",
		-- 				".",
		-- 			},
		-- 		})
		-- 	end,
		-- 	desc = "commits",
		-- },
		-- {
		-- 	"<leader>fi",
		-- 	function()
		-- 		require("telescope.builtin").lsp_workspace_symbols({
		-- 			symbols = {
		-- 				"Class",
		-- 				"Function",
		-- 				"Method",
		-- 				"Constructor",
		-- 				"Interface",
		-- 				"Module",
		-- 				"Struct",
		-- 				"Trait",
		-- 				"Field",
		-- 				"Property",
		-- 			},
		-- 		})
		-- 	end,
		-- 	desc = "Goto Symbol",
		-- },
	},
}

function M.config()
	local telescope = require("telescope")
	local actions = require("telescope.actions")
	local action_state = require("telescope.actions.state")
	local trouble = require("trouble.sources.telescope")
	telescope.setup({
		defaults = {

			path_display = { "smart" },

			mappings = {
				i = {
					["<C-n>"] = actions.cycle_history_next,
					["<C-p>"] = actions.cycle_history_prev,

					["<C-j>"] = actions.move_selection_next,
					["<C-k>"] = actions.move_selection_previous,

					["<C-c>"] = actions.close,

					["<Down>"] = actions.move_selection_next,
					["<Up>"] = actions.move_selection_previous,

					["<CR>"] = actions.select_default + actions.center,
					["<C-s>"] = actions.select_horizontal + actions.center,
					["<C-v>"] = actions.select_vertical + actions.center,

					["<C-x>"] = trouble.open,
					["<C-q>"] = trouble.open_selected_with_trouble,

					["<C-u>"] = actions.preview_scrolling_up,
					["<C-d>"] = actions.preview_scrolling_down,

					["<PageUp>"] = actions.results_scrolling_up,
					["<PageDown>"] = actions.results_scrolling_down,

					["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
					["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
					["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
					["<C-l>"] = actions.complete_tag,
					["<C-_>"] = actions.which_key, -- keys from pressing <C-/>
				},

				n = {
					["<esc>"] = actions.close,
					["<CR>"] = actions.select_default + actions.center,
					["<C-s>"] = actions.select_horizontal + actions.center,
					["<C-v>"] = actions.select_vertical + actions.center,

					["<C-x>"] = trouble.open,
					["<C-q>"] = trouble.open_selected_with_trouble,

					["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
					["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
					["<M-q>"] = actions.send_selected_to_qflist + actions.open_qflist,

					["j"] = actions.move_selection_next,
					["k"] = actions.move_selection_previous,
					["H"] = actions.move_to_top,
					["M"] = actions.move_to_middle,
					["L"] = actions.move_to_bottom,

					["<Down>"] = actions.move_selection_next,
					["<Up>"] = actions.move_selection_previous,
					["gg"] = actions.move_to_top,
					["G"] = actions.move_to_bottom,

					["<C-u>"] = actions.preview_scrolling_up,
					["<C-d>"] = actions.preview_scrolling_down,

					["<PageUp>"] = actions.results_scrolling_up,
					["<PageDown>"] = actions.results_scrolling_down,

					["?"] = actions.which_key,
				},
			},
		},
		pickers = {
			find_files = {
				results_title = false,
			},
			git_files = {
				results_title = false,
			},
			git_status = {
				expand_dir = false,
			},
			git_bcommits = {
				mappings = {
					i = {
						["dd"] = function()
							-- Open in diffview
							local selected_entry = action_state.get_selected_entry()
							local value = selected_entry.value
							-- close Telescope window properly prior to switching windows
							vim.api.nvim_win_close(0, true)
							vim.cmd("stopinsert")
							vim.schedule(function()
								vim.cmd(("DiffviewOpen %s^!"):format(value))
							end)
						end,
					},
					n = {
						["dd"] = function()
							-- Open in diffview
							local selected_entry = action_state.get_selected_entry()
							local value = selected_entry.value
							-- close Telescope window properly prior to switching windows
							vim.api.nvim_win_close(0, true)
							vim.cmd("stopinsert")
							vim.schedule(function()
								vim.cmd(("DiffviewOpen %s^!"):format(value))
							end)
						end,
					},
				},
			},
			git_commits = {
				mappings = {
					i = {
						["dd"] = function()
							-- Open in diffview
							local selected_entry = action_state.get_selected_entry()
							local value = selected_entry.value
							-- close Telescope window properly prior to switching windows
							vim.api.nvim_win_close(0, true)
							vim.cmd("stopinsert")
							vim.schedule(function()
								vim.cmd(("DiffviewOpen %s^!"):format(value))
							end)
						end,
					},
					n = {
						["dd"] = function()
							-- Open in diffview
							local selected_entry = action_state.get_selected_entry()
							local value = selected_entry.value
							-- close Telescope window properly prior to switching windows
							vim.api.nvim_win_close(0, true)
							vim.cmd("stopinsert")
							vim.schedule(function()
								vim.cmd(("DiffviewOpen %s^!"):format(value))
							end)
						end,
					},
				},
			},
			buffers = {
				mappings = {
					i = {
						["<c-d>"] = actions.delete_buffer,
					},
					n = {
						["<c-d>"] = actions.delete_buffer,
					},
				},
			},
			-- Default configuration for builtin pickers goes here:
			-- picker_name = {
			--   picker_config_key = value,
			--   ...
			-- }
			-- Now the picker_config_key will be applied every time you call this
			-- builtin picker
		},
		extensions = {
			fzf = {
				fuzzy = true, -- false will only do exact matching
				override_generic_sorter = true, -- override the generic sorter
				override_file_sorter = true, -- override the file sorter
				case_mode = "smart_case", -- or "ignore_case" or "respect_case"
				-- the default case_mode is "smart_case"
			},
		},
	})

	require("telescope").load_extension("projects")
	telescope.load_extension("fzf")
end

return M

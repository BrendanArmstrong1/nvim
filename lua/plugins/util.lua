return {
	-- surround
	{
		"echasnovski/mini.surround",
		keys = {
			"gz",
			"dz",
			"cz",
			"vz",
			{
				"Z",
				":<C-u>lua MiniSurround.add('visual')<CR>",
				mode = "x",
				silent = true,
			},
		},
		init = function()
			-- Remap adding surrounding to Visual mode selection
			-- vim.api.nvim_set_keymap("x", "Z", [[:<C-u>lua MiniSurround.add('visual')<CR>]], { noremap = true })
			-- Make special mapping for "add surrounding for line"
			--
			vim.api.nvim_set_keymap("n", "gzz", "gz_", { noremap = false })
			vim.api.nvim_set_keymap(
				"i",
				"<C-_>",
				"<C-o>h<C-o>gziw_<C-o>gziw_<C-o>E<C-o>a",
				{ desc = "dunder(python)", noremap = false }
			)
		end,
		config = function()
			-- use gz mappings instead of s to prevent conflict with leap
			require("mini.surround").setup({
          --stylua: ignore
          mappings = {
            add            = "gz", -- Add surrounding in Normal and Visual modes
            delete         = "dz", -- Delete surrounding
            find           = "", -- Find surrounding (to the right)
            find_left      = "", -- Find surrounding (to the left)
            highlight      = "vz", -- Highlight surrounding
            replace        = "cz", -- Replace surrounding
            update_n_lines = "", -- Update `n_lines`
          },
			})
		end,
	},

	-- auto pairs
	{
		"windwp/nvim-autopairs",
		event = "InsertEnter",
		config = function()
        --stylua: ignore
        require("nvim-autopairs").setup({
          fast_wrap = {
            map            = "<c-s>",
            chars          = { "{", "[", "(", '"', "'", "`" },
            pattern        = [=[[%'%"%)%>%]%)%}%,]]=],
            end_key        = "L",
            keys           = "aoeuidhtnsfgcrl",
            check_comma    = true,
            highlight      = "Search",
            highlight_grey = "Comment",
          },
          disable_filetype          = { "TelescopePrompt" },
          disable_in_macro          = false, -- disable when recording or executing a macro
          disable_in_visualblock    = false, -- disable when insert after visual block mode
          disable_in_replace_mode   = true,
          ignored_next_char         = [=[[%w%%%'%[%"%.%`%$]]=],
          enable_moveright          = true,
          enable_afterquote         = true, -- add bracket pairs after quote
          enable_check_bracket_line = true, --- check bracket in same line
          enable_bracket_in_quote   = true, --
          enable_abbr               = false, -- trigger abbreviation
          break_undo                = true, -- switch for basic rule break undo sequence
          check_ts                  = true,
          map_cr                    = true,
          map_bs                    = true, -- map the <BS> key
          map_c_h                   = false, -- Map the <C-h> key to delete a pair
          map_c_w                   = false, -- map <c-w> to delete a pair iff possible
        })
			local endwise = require("nvim-autopairs.ts-rule").endwise
			local npairs = require("nvim-autopairs")
			npairs.add_rules({
				endwise("then$", "end", "lua", "if_statement"),
			})
			-- local cmp_autopairs = require("nvim-autopairs.completion.cmp")
			-- local cmp_status_ok, cmp = pcall(require, "cmp")
			-- if not cmp_status_ok then
			-- 	return
			-- end
			-- cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done({ map_char = { tex = "" } }))
		end,
	},

	-- Split Join
	{
		"Wansmer/treesj",
		cmd = {
			"TSJToggle",
			"TSJSplit",
			"TSJJoin",
		},
    -- stylua: ignore
		keys = {
			{ "gss", function() require('treesj').split() end },
			{ "gsj", function() require('treesj').join() end },
      { "gm", function() require('treesj').toggle({ split = { recursive = true } }) end },
		},
		dependencies = { "nvim-treesitter/nvim-treesitter" },
		config = function()
			require("treesj").setup({
				-- Use default keymaps
				-- (<space>m - toggle, <space>j - join, <space>s - split)
				use_default_keymaps = false,

				-- Node with syntax error will not be formatted
				check_syntax_error = true,

				-- If line after join will be longer than max value,
				-- node will not be formatted
				max_join_length = 400,

				-- hold|start|end:
				-- hold - cursor follows the node/place on which it was called
				-- start - cursor jumps to the first symbol of the node being formatted
				-- end - cursor jumps to the last symbol of the node being formatted
				cursor_behavior = "hold",

				-- Notify about possible problems or not
				notify = true,
				-- langs = langs,
				dot_repeat = true,
			})
		end,
	},

	-- better text-objects
	{
		"echasnovski/mini.ai",
		keys = {
			{ "a", mode = { "x", "o" } },
			{ "i", mode = { "x", "o" } },
		},
		dependencies = { { "nvim-treesitter/nvim-treesitter-textobjects" } },
		opts = function()
			local ai = require("mini.ai")
			return {
				n_lines = 500,
				custom_textobjects = {
					o = ai.gen_spec.treesitter({
						a = { "@block.outer", "@conditional.outer", "@loop.outer" },
						i = { "@block.inner", "@conditional.inner", "@loop.inner" },
					}, {}),
					f = ai.gen_spec.treesitter({
						a = "@function.outer",
						i = "@function.inner",
					}, {}),
					c = ai.gen_spec.treesitter({
						a = "@class.outer",
						i = "@class.inner",
					}, {}),
				},
				mappings = {
					around = "a",
					inside = "i",
					goto_left = "g[",
					goto_right = "g]",
				},
				search_method = "cover_or_nearest",
			}
		end,
		config = function(_, opts)
			local ai = require("mini.ai")
			ai.setup(opts)
		end,
	},

	-- session management
	{
		"folke/persistence.nvim",
		event = "BufReadPre",
		opts = { options = { "buffers", "curdir", "tabpages", "winsize", "help", "globals" } },
    -- stylua: ignore
    keys = {
      { "<leader>qs", function() require("persistence").load() end, desc = "Restore Session" },
      { "<leader>ql", function() require("persistence").load({ last = true }) end, desc = "Restore Last Session" },
      { "<leader>qd", function() require("persistence").stop() end, desc = "Don't Save Current Session" },
    },
	},

	{
		"echasnovski/mini.align",
		version = "*",
		keys = { { "gl", mode = { "n", "x" } }, { "gL", mode = { "n", "x" } } },
		config = function()
			require("mini.align").setup({
				-- Module mappings. Use `''` (empty string) to disable one.
				mappings = {
					start = "gl",
					start_with_preview = "gL",
				},

				-- Default options controlling alignment process
				options = {
					split_pattern = "",
					justify_side = "right",
					merge_delimiter = "",
				},

				-- Default steps performing alignment (if `nil`, default is used)
				steps = {
					pre_split = {},
					split = nil,
					pre_justify = {},
					justify = nil,
					pre_merge = {},
					merge = nil,
				},

				-- Whether to disable showing non-error feedback
				silent = false,
			})
		end,
	},

	-- vim-rsi
	{
		"tpope/vim-rsi",
		event = {
			"InsertEnter",
			"CmdlineEnter",
		},
	},

	{
		"tpope/vim-repeat",
		event = "VeryLazy",
	},
}

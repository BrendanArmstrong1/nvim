return {

	-- auto rooting
	{
		"ahmedkhalf/project.nvim",
		event = "BufReadPost",
		config = function()
			require("project_nvim").setup({
				manual_mode = false,
				detection_methods = { "lsp", "pattern" },
				patterns = {
					"main.py",
					".git",
					"_darcs",
					".hg",
					".bzr",
					".svn",
					"Makefile",
					"package.json",
					"Cargo.toml",
				},
				ignore_lsp = {},
				exclude_dirs = { "~/ssd/Rust/rustlings/" },
			})
		end,
	},

	-- better `inc-rename`
	{
		"smjonas/inc-rename.nvim",
		keys = {
			{
				"<leader>rn",
				function()
					return ":IncRename " .. vim.fn.expand("<cword>")
				end,
				desc = "lsp rename",
				expr = true,
				-- mode = { "n", "x" },
			},
		},
		opts = {
			cmd_name = "IncRename", -- the name of the command
			hl_group = "Substitute", -- the highlight group used for highlighting the identifier's new name
			preview_empty_name = false, -- whether an empty new name should be previewed; if false the command preview will be cancelled instead
			show_message = true, -- whether to display a `Renamed m instances in n files` message after a rename operation
			input_buffer_type = nil, -- the type of the external input buffer to use (the only supported value is currently "dressing")
			post_hook = nil, -- callback to run after renaming, receives the result table (from LSP handler) as an argument
		},
	},

	{
		"dyng/ctrlsf.vim",
		init = function()
			vim.cmd([[

      let g:ctrlsf_auto_close = {
      \ "normal" : 0, 
      \ "compact" : 0, 
      \}

      let g:ctrlsf_auto_focus = { "at" : "start", }

      "values ar 'yes' 'no' 'smart'
      let g:ctrlsf_case_sensitive = 'yes'

      let g:ctrlsf_default_view_mode = "normal"

      let g:ctrlsf_backend = 'rg'
      let g:ctrlsf_extra_backend_args = {
      \ 'rg': '--no-ignore --glob "!.git"'
      \ }
      let g:ctrlsf_position = 'left_local'
      let g:ctrlsf_mapping = { 
      \ "vsplit": "<C-v>",
      \ "quit": "Q",
      \ "loclist": "<C-t>",
      \ }

      ]])
		end,
		keys = {
			{ "<leader>rr", "<CMD>CtrlSFOpen<CR>", mode = { "n" } },
			{
				"<leader>rb",
				function()
					vim.cmd(string.format("CtrlSF %s", vim.fn.expand("<cword>")))
				end,
				desc = "Ctlsf word in word boundary",
				mode = { "n" },
			},
			{
				"<leader>rb",
				function()
					vim.cmd('normal! "vy')
					local vis_sel = vim.fn.getreg("v")
					vim.cmd(string.format("CtrlSF '%s'", vis_sel))
				end,
				desc = "Ctlsf word in visual",
				mode = { "x" },
			},
		},
	},
}

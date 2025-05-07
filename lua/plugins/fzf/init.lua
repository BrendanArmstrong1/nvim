local M = { "ibhagwan/fzf-lua" }
M.dependencies = { "nvim-tree/nvim-web-devicons" }
-- stylua: ignore
M.keys = {
	{ "<leader>:", function() require("fzf-lua").commands() end, mode = { "n" } },
	{ "gT", function() require("fzf-lua").lsp_typedefs({jump1 = true}) end, mode = { "n" } },
	{ "gI", function() require("fzf-lua").lsp_implementations({jump1 = true}) end, mode = { "n" } },
	{ "gr", function() require("fzf-lua").lsp_references({jump1 = true}) end, mode = { "n" } },
	{ "gd", function() require("fzf-lua").lsp_definitions({jump1 = true}) end, mode = { "n" } },
  { "<leader>gi", function() require("plugins.fzf.util").git_pickaxe() end, mode = "n" },
	{ "<leader>fi", function() require("fzf-lua").lsp_document_symbols() end, mode = { "n" } },
	{ "<leader>fI", function() require("fzf-lua").lsp_workspace_symbols() end, mode = { "n" } },
	{ "<leader>fd", function() require("fzf-lua").diagnostics_document() end, mode = { "n" } },
	{ "<leader>FD", function() require("fzf-lua").diagnostics_workspace() end, mode = { "n" } },
	{ "<leader>fs", function() require("fzf-lua").git_status() end, mode = { "n" } },
	{ "<leader>fgg", function() require("fzf-lua").git_commits() end, mode = { "n" } },
	{ "<leader>fgs", function() require("fzf-lua").git_stash() end, mode = { "n" } },
	{ "<leader>fgc", function() require("fzf-lua").git_bcommits() end, mode = { "n" } },
	{ "<leader>fr", function() require("fzf-lua").resume() end, mode = { "n" } },
	{ "<leader>fb", function() require("fzf-lua").buffers() end, mode = { "n" } },
	{ "<leader>ff", function() require("fzf-lua").files() end, mode = { "n" } },
	{ "<leader>FF", function() require("fzf-lua").git_files() end, mode = { "n" } },
	{ "<leader>fl", function() require("fzf-lua").lgrep_curbuf() end, mode = { "n" } },
	{ "<leader>FL", function() require("fzf-lua").blines() end, mode = { "n" } },
	{ "<leader>fk", function() require("fzf-lua").helptags() end, mode = { "n" } },
	{ "<leader>FK", function() require("fzf-lua").keymaps() end, mode = { "n" } },
	{ "<leader>/", function() require("fzf-lua").live_grep() end, mode = { "n" } },
	{ "<leader>?", function() require("fzf-lua").grep_cword() end, mode = "n" },
	{ "<leader>?", function() require("fzf-lua").xgrep_visual() end, mode = "x" },
}

M.config = function()
	local actions = require("fzf-lua.actions")
	require("fzf-lua").setup({
    -- stylua: ignore
    files = {
      actions = {
        ["ctrl-h"]         = { actions.toggle_ignore },
        ["ctrl-g"]         = false,
      }
    },
		git = {
			status = {
				actions = {
					["right"] = false,
					["left"] = false,
					["ctrl-x"] = { fn = actions.git_reset, reload = true },
					["ctrl-s"] = { fn = actions.git_stage_unstage, reload = true },
				},
			},
		},
		grep = {
			actions = {
				["ctrl-g"] = false,
				["ctrl-t"] = { actions.grep_lgrep },
			},
		},
		tags = {
			actions = {
				["ctrl-g"] = false,
				["ctrl-t"] = { actions.grep_lgrep },
			},
		},
	})
	require("fzf-lua").register_ui_select()
  require("plugins.fzf.setup").setup()
end

return M

local M = { "ibhagwan/fzf-lua" }
M.dependencies = { "nvim-tree/nvim-web-devicons" }
-- stylua: ignore
M.keys = {
	{ "<leader>:", function() require("fzf-lua").commands() end, mode = { "n" } },
	{ "gt", function() require("fzf-lua").lsp_typedefs({jump_to_single_result = true}) end, mode = { "n" } },
	{ "gI", function() require("fzf-lua").lsp_implementations({jump_to_single_result = true}) end, mode = { "n" } },
	{ "gr", function() require("fzf-lua").lsp_references({jump_to_single_result = true}) end, mode = { "n" } },
	{ "gd", function() require("fzf-lua").lsp_definitions({jump_to_single_result = true}) end, mode = { "n" } },
	{ "<leader>fi", function() require("fzf-lua").lsp_document_symbols() end, mode = { "n" } },
	{ "<leader>fI", function() require("fzf-lua").lsp_workspace_symbols() end, mode = { "n" } },
	{ "<leader>fd", function() require("fzf-lua").diagnostics_document() end, mode = { "n" } },
	{ "<leader>FD", function() require("fzf-lua").diagnostics_workspace() end, mode = { "n" } },
	{ "<leader>fs", function() require("fzf-lua").git_status() end, mode = { "n" } },
	{ "<leader>fgc", function() require("fzf-lua").git_commits() end, mode = { "n" } },
	{ "<leader>fgb", function() require("fzf-lua").git_bcommits() end, mode = { "n" } },
	{ "<leader>fr", function() require("fzf-lua").resume() end, mode = { "n" } },
	{ "<leader>fb", function() require("fzf-lua").buffers() end, mode = { "n" } },
	{ "<leader>ff", function() require("fzf-lua").files() end, mode = { "n" } },
	{ "<leader>FF", function() require("fzf-lua").git_files() end, mode = { "n" } },
	{ "<leader>\\", function() require("fzf-lua").live_grep() end, mode = { "n" } },
	{ "<leader>fl", function() require("fzf-lua").lgrep_curbuf() end, mode = { "n" } },
	{ "<leader>FL", function() require("fzf-lua").lines() end, mode = { "n" } },
	{ "<leader>fk", function() require("fzf-lua").helptags() end, mode = { "n" } },
	{ "<leader>FK", function() require("fzf-lua").keymaps() end, mode = { "n" } },
	{ "<leader>?", function() require("fzf-lua").grep_cword() end, mode = "n" },
	{ "<leader>?", function() require("fzf-lua").xgrep_visual() end, mode = "x" },
	{ "<c-x><c-l>", function() require("fzf-lua").complete_line() end, mode = "i" },
  { "<c-x><c-k>", function() require("plugins.fzf.util").complete_word() end, mode = "i" },
  { "<c-x><c-f>", function() require("fzf-lua").complete_path({ cmd = "rg --files", winopts = { preview = { hidden = "nohidden" } } }) end, mode = "i" },
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
	-- require("plugins.fzf.setup").setup()
end

return M

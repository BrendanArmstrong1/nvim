return {
	{
		"kevinhwang91/nvim-ufo",
		dependencies = {
			"kevinhwang91/promise-async",
		},
		keys = {
			{ "zM" },
			{ "zm" },
			{ "zO" },
			{ "zo" },
			{ "zp" },
		},
		config = function()
			local ftMap = {
				vim = "indent",
				python = { "indent" },
				git = "",
			}
			vim.keymap.set("n", "ZO", require("ufo").openAllFolds)
			vim.keymap.set("n", "ZM", require("ufo").closeAllFolds)
			vim.keymap.set("n", "zo", require("ufo").openFoldsExceptKinds)
			vim.keymap.set("n", "zm", require("ufo").closeFoldsWith)
			vim.keymap.set("n", "zp", require("ufo").peekFoldedLinesUnderCursor)
			vim.keymap.set("n", "]z", require("ufo").goNextClosedFold)
			vim.keymap.set("n", "[z", require("ufo").goPreviousClosedFold)
			vim.o.foldcolumn = "0"
			vim.o.foldlevel = 99
			vim.o.foldlevelstart = 99
			vim.o.foldenable = true
			local handler = function(virtText, lnum, endLnum, width, truncate)
				local newVirtText = {}
				local suffix = (" 󰁂 %d "):format(endLnum - lnum)
				local sufWidth = vim.fn.strdisplaywidth(suffix)
				local targetWidth = width - sufWidth
				local curWidth = 0
				for _, chunk in ipairs(virtText) do
					local chunkText = chunk[1]
					local chunkWidth = vim.fn.strdisplaywidth(chunkText)
					if targetWidth > curWidth + chunkWidth then
						table.insert(newVirtText, chunk)
					else
						chunkText = truncate(chunkText, targetWidth - curWidth)
						local hlGroup = chunk[2]
						table.insert(newVirtText, { chunkText, hlGroup })
						chunkWidth = vim.fn.strdisplaywidth(chunkText)
						-- str width returned from truncate() may less than 2nd argument, need padding
						if curWidth + chunkWidth < targetWidth then
							suffix = suffix .. (" "):rep(targetWidth - curWidth - chunkWidth)
						end
						break
					end
					curWidth = curWidth + chunkWidth
				end
				table.insert(newVirtText, { suffix, "MoreMsg" })
				return newVirtText
			end
			require("ufo").setup({
				open_fold_hl_timeout = 150,
        enable_get_fold_virt_text = true,
				fold_virt_text_handler = handler,
				close_fold_kinds_for_ft = { "comment" },
				preview = {
					win_config = {
						border = { "", "─", "", "", "", "─", "", "" },
						winhighlight = "Normal:Folded",
						winblend = 0,
					},
					mappings = {
						scrollU = "<C-u>",
						scrollD = "<C-d>",
						jumpTop = "[",
						jumpBot = "]",
					},
				},
				provider_selector = function(_, filetype, _)
					return ftMap[filetype] or { "treesitter", "indent" }
				end,
			})
		end,
	},
}

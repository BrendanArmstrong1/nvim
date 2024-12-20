return {
	{
		"nvim-neorg/neorg",
		dependencies = {
			"nvim-treesitter/nvim-treesitter",
			"nvim-treesitter/nvim-treesitter-textobjects",
			"nvim-lua/plenary.nvim",
		},
		build = ":Neorg sync-parsers",
		keys = {
			{ "<leader>B<leader>B", "<cmd>Neorg journal yesterday<cr>", desc = "neorg Journal" },
			{ "<leader>W<leader>W", "<cmd>Neorg journal tomorrow<cr>", desc = "neorg Journal" },
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
					["core.ui.calendar"] = {},
					["core.esupports.metagen"] = { config = { type = "auto", update_date = true } },
					["core.qol.toc"] = { config = { close_after_use = true } },
					["core.qol.todo_items"] = {},
					["core.looking-glass"] = {},
					["core.presenter"] = { config = { zen_mode = "zen-mode" } },
					["core.export"] = {},
					["core.journal"] = {},
					["core.text-objects"] = {},
					["core.export.markdown"] = { config = { extensions = "all" } },
					["core.summary"] = {},
					["core.concealer"] = {
						config = {
							icons = {
								heading = {
									icons = { "▬", "◊", "○", "●", "◙", "◘" },
									-- render = module.public.icon_renderers.multilevel_on_right(false),
								},
							},
						},
					}, -- Adds pretty icons to your documents
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

      --- Completion stuff ---
			local neorg = require("neorg.core")
			local modules = neorg.modules
			local dirman = modules.get_module("core.dirman")

			local function get_description_from_frontmatter(file)
				-- Open the file and read the first few lines to extract the description from front matter
				local lines = vim.fn.readfile(file)
				local description = ""

				-- Look for the @document.meta block and extract the description field
				local in_meta = false
				for _, line in ipairs(lines) do
					if line:match("@document.meta") then
						in_meta = true
					elseif in_meta and line:match("description:") then
						description = line:match('description:%s*"(.-)"')
						break
					elseif in_meta and line:match("@end") then
						break
					end
				end

				return description or "No description available."
			end

			local function get_headings_from_file(file)
				-- Read the file and find all headings
				local headings = {}
				local lines = vim.fn.readfile(file)

				local current_heading = ""
				for _, line in ipairs(lines) do
					-- Find lines that are headings (e.g., `*** Heading`)
					if line:match("^[*]+%s") then
						-- Capture the heading text
						current_heading = line:gsub("^%s*", "")
						table.insert(headings, current_heading)
					end
				end
				return headings
			end

			local function construct_filepath(path, workspace_root)
				local file_path = ""

				-- Check for absolute path type (starting with ":/")
				if path:match("^:/") then
					-- Absolute filesystem path
					file_path = path:sub(3) -- Remove ":/" and use the rest as an absolute path

				-- Check for workspace path (starting with ":$/")
				elseif path:match("^$/") then
					-- Workspace path
					file_path = workspace_root .. path:sub(3) -- Remove ":$/", prepend the workspace root
				else
					-- Invalid path type, return nil or handle it accordingly
					return nil
				end

				-- Add .norg extension to the file path
				return file_path .. ".norg"
			end

			local function neorg_completefunc(findstart, base)
				-- Directory where Neorg files are stored
        local workspace_name = dirman.get_workspace_match()
        local workspace_path = dirman.get_workspace(workspace_name)
        workspace_path = workspace_path:tostring()

				local files = vim.fn.globpath(workspace_path, "**/*.norg", false, true)

				if findstart == 1 then
					-- Find the start of the word to complete
					local line = vim.fn.getline(".")
					local col = vim.fn.col(".")
					local start = col - 1
					while start > 0 and line:sub(start, start):match("[%w_/]") do
						start = start - 1
					end
					return start
				end

				local suggestions = {}
				local context = {
					full_line = vim.fn.getline("."),
					char = vim.fn.col("."),
				}


				-- Check if we're completing after a file link (e.g., {:$/path/to/file.norg:})
				if context.full_line:sub(context.char - 1, context.char - 1) == ":" then
					-- Extract the file path from the current line (handle both relative and workspace paths)
					local link_pattern = "{:(%$/.+):}"
					local file_path = context.full_line:match(link_pattern)

					if file_path then
						local absolute_path = construct_filepath(file_path, workspace_path .. "/")

						-- We have a file path, so now let's search for headings in that file
						local headings = get_headings_from_file(absolute_path)
						local description = get_description_from_frontmatter(absolute_path)

						for _, heading in ipairs(headings) do
							local link = heading
							table.insert(suggestions, {
								word = link,
								abbr = heading,
								menu = "[Heading]",
								info = description, -- This will show in the popup as the description
							})
						end
					end
				else
					-- List all files as suggestions
					for _, file in ipairs(files) do
						local relative_path = file:gsub("^" .. workspace_path:gsub("([^%w])", "%%%1") .. "/", "")
						relative_path = relative_path:gsub("%.norg$", "")
						if relative_path:find(base, 1, true) then
							local description = get_description_from_frontmatter(file)

							-- Construct the Neorg link with the relative path
							local link = "{:$/" .. relative_path .. ":}"

							table.insert(suggestions, {
								word = link,
								abbr = vim.fn.fnamemodify(relative_path, ":t"), -- Abbreviation shows the file name without the extension
								menu = "[File]",
								info = description, -- Description from the frontmatter
							})
						end
					end
				end

				-- Return all suggestions as words
				return vim.tbl_map(function(item)
					return item.word
				end, suggestions)
			end

			vim.api.nvim_create_autocmd("FileType", {
				pattern = "norg",
				callback = function()
					vim.bo.completefunc = "v:lua.neorg_completefunc"
				end,
			})
			_G.neorg_completefunc = neorg_completefunc
		end,
	},
}

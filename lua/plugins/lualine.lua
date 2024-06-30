local M = {
	"nvim-lualine/lualine.nvim",
	dependencies = {
		{ "kyazdani42/nvim-web-devicons" },
	},
	event = "VeryLazy",
}

local function clock()
	return " " .. os.date("%H:%M")
end

local location = {
	"location",
	padding = 0,
}

function M.config()
	if vim.g.started_by_firenvim then
		return
	end

	require("lualine").setup({
		options = {
			theme = "tokyonight",
			section_separators = { left = "", right = "" },
			component_separators = { left = "", right = "" },
			icons_enabled = true,
			globalstatus = true,
			disabled_filetypes = { statusline = { "dashboard", "lazy" } },
		},
		sections = {
			lualine_a = { { "mode", separator = { left = " " } } },
			lualine_b = {
				{ "branch" },
				-- integration with noice
				-- {
				--   require("noice").api.statusline.mode.get,
				--   cond = require("noice").api.statusline.mode.has,
				--   color = { fg = "#ff9e64" },
				-- },
			},
			lualine_c = {
				{ "diagnostics", sources = { "nvim_diagnostic" } },
				{ "filetype", icon_only = true, separator = "", padding = { left = 1, right = 0 } },
				-- { "filename", path = 0, symbols = { modified = "[+]", readonly = "[-]", unnamed = "[No Name]" } },
				{
					function()
						local navic = require("nvim-navic")
						local ret = navic.get_location()
						return ret:len() > 2000 and "navic error" or ret
					end,
					cond = function()
						if package.loaded["nvim-navic"] then
							local navic = require("nvim-navic")
							return navic.is_available()
						end
					end,
					color = { fg = "#ff9e64" },
				},
			},
			lualine_x = {
				{
					function()
						return require("lazy.status").updates()
					end,
					cond = require("lazy.status").has_updates,
					color = { fg = "#ff9e64" },
				},
				{
					function()
						local stats = require("lazy.stats").stats()
						local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
						return " " .. ms .. "ms"
					end,
					color = { fg = "#ff9e64" },
				},
				function()
					return require("messages.view").status
				end,
				{
					function()
						return require("util.dashboard").status()
					end,
				},
			},
			-- lualine_y = { progress },
			lualine_y = {},
			lualine_z = { location, { clock, separator = { right = " " } } },
		},
		inactive_sections = {
			lualine_a = {},
			lualine_b = {},
			lualine_c = {},
			lualine_x = {},
			lualine_y = {},
			lualine_z = {},
		},
		-- winbar = {
		--   lualine_a = {},
		--   lualine_b = {},
		--   lualine_c = { "filename" },
		--   lualine_x = {},
		--   lualine_y = {},
		--   lualine_z = {},
		-- },
		--
		-- inactive_winbar = {
		--   lualine_a = {},
		--   lualine_b = {},
		--   lualine_c = { "filename" },
		--   lualine_x = {},
		--   lualine_y = {},
		--   lualine_z = {},
		-- },
		extensions = { "nvim-tree" },
	})
end

return M

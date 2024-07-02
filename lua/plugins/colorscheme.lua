return {
	{ "shaunsingh/oxocarbon.nvim" },

	-- tokyonight
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1,
		config = function()
			local tokyonight = require("tokyonight")
			tokyonight.setup({
        plugins = {
          -- enable all plugins when not using lazy.nvim
          -- set to false to manually enable/disable plugins
          all = package.loaded.lazy == nil,
          -- uses your plugin manager to automatically enable needed plugins
          -- currently only lazy.nvim is supported
          auto = true,
          -- add any plugins here that you want to enable
          -- for all possible plugins, see:
          --   * https://github.com/folke/tokyonight.nvim/tree/main/lua/tokyonight/groups
          -- lualine = true,
        },
				style = "night", -- the theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
				light_style = "day", -- the theme is used when the background is set to light
				transparent = true, -- enable this to disable setting the background color
				terminal_colors = true, -- configure the colors used when opening a `:terminal` in neovim
				styles = {
					comments = { italic = true },
					keywords = { italic = true },
					functions = {},
					variables = {},
					-- background styles. can be "dark", "transparent" or "normal"
					sidebars = "transparent", -- style for sidebars, see below
					floats = "dark", -- style for floating windows
				},
				sidebars = { -- set a darker background on sidebar-like windows. for example: `["qf", "vista_kind", "terminal", "packer"]`
					"qf",
					"vista_kind",
					"terminal",
					"spectre_panel",
					"startuptime",
					"Outline",
				},
				on_highlights = function(hl, c)
					hl.CursorLineNr = { fg = c.orange, bold = true }
					local prompt = "#2d3149"
					hl.TelescopeNormal = { bg = c.bg_dark, fg = c.fg_dark }
					hl.TelescopeBorder = { bg = c.bg_dark, fg = c.bg_dark }
					hl.TelescopePromptNormal = { bg = prompt }
					hl.TelescopePromptBorder = { bg = prompt, fg = prompt }
					hl.TelescopePromptTitle = { bg = c.fg_gutter, fg = c.orange }
					hl.TelescopePreviewTitle = { bg = c.bg_dark, fg = c.bg_dark }
					hl.TelescopeResultsTitle = { bg = c.bg_dark, fg = c.bg_dark }
				end,
				day_brightness = 0.3, -- adjusts the brightness of the colors of the **day** style. number between 0 and 1, from dull to vibrant colors
				hide_inactive_statusline = true, -- enabling this option, will hide inactive statuslines and replace them with a thin border instead. should work with the standard **statusline** and **lualine**.
				dim_inactive = false, -- dims inactive windows
				lualine_bold = true, -- when `true`, section headers in the lualine theme will be bold
			})
			tokyonight.load()
		end,
	},

	-- catppuccin
	{
		"catppuccin/nvim",
		name = "catppuccin",
		lazy = false,
		priority = 200,
		config = function()
			require("catppuccin").setup({
				flavour = "macchiato", -- latte, frappe, macchiato, mocha
				background = { -- :h background
					light = "latte",
					dark = "mocha",
				},
				transparent_background = true,
				show_end_of_buffer = false, -- show the '~' characters after the end of buffers
				term_colors = false,
				dim_inactive = {
					enabled = false,
					shade = "dark",
					percentage = 0.15,
				},
				no_italic = false, -- Force no italic
				no_bold = false, -- Force no bold
				styles = {
					comments = { "italic" },
					conditionals = { "italic" },
					loops = {},
					functions = {},
					keywords = {},
					strings = {},
					variables = {},
					numbers = {},
					booleans = {},
					properties = {},
					types = {},
					operators = {},
				},
				color_overrides = {},
				custom_highlights = {},
				integrations = {
					cmp = true,
					gitsigns = true,
					nvimtree = true,
					telescope = true,
					-- notify = true,
					which_key = true,
					mini = true,
					-- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
				},
			})

			-- setup must be called before loading
			-- vim.cmd.colorscheme("catppuccin")
		end,
	},
}

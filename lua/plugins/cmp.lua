return {
	{
		"hrsh7th/nvim-cmp",
		event = {
			"InsertEnter",
			"CmdlineEnter",
		},
		dependencies = {
			"hrsh7th/cmp-nvim-lua",
			"hrsh7th/cmp-nvim-lsp",
			"hrsh7th/cmp-path",
			"hrsh7th/cmp-cmdline",
			"saadparwaiz1/cmp_luasnip",
			-- snippets
			{
				"L3MON4D3/LuaSnip",
			},
		},
		config = function()
			local types = require("cmp.types")
			---@type table<integer, integer>
			local modified_priority = {
				[types.lsp.CompletionItemKind.Variable] = types.lsp.CompletionItemKind.Method,
				[types.lsp.CompletionItemKind.Snippet] = 0, -- top
				[types.lsp.CompletionItemKind.Keyword] = 100, -- middle
				[types.lsp.CompletionItemKind.Text] = 100, -- bottom
			}
			---@param kind integer: kind of completion entry
			local function modified_kind(kind)
				return modified_priority[kind] or kind
			end
			local compare = require("cmp.config.compare")
			local check_backspace = function()
				local col = vim.fn.col(".") - 1
				return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
			end
			local luasnip = require("luasnip")
			local cmp = require("cmp")
      local feedkeys = require('cmp.utils.feedkeys')
      local keymap = require('cmp.utils.keymap')
			cmp.setup({
				snippet = {
					expand = function(args)
						require("luasnip").lsp_expand(args.body)
					end,
				},
				mapping = cmp.mapping.preset.insert({
					["<C-k>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.expandable() then
							luasnip.expand()
						elseif check_backspace() then
							fallback()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<C-j>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.choice_active() then
							luasnip.change_choice(1)
						elseif check_backspace() then
							fallback()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<C-d>"] = cmp.mapping.scroll_docs(4),
					["<C-u>"] = cmp.mapping.scroll_docs(-4),
					["<C-Space>"] = cmp.mapping.complete(),
					["<C-e>"] = cmp.mapping({ i = cmp.mapping.abort(), c = cmp.mapping.close() }),
					["<C-y>"] = cmp.mapping(function(fallback)
						if vim.fn.pumvisible() == 1 then
							-- native pumenu
							-- workaround for neovim/neovim#22892
							if vim.fn.complete_info({ "selected" }).selected == -1 then
								-- nothing selected, insert newline
								feedkeys.call(keymap.t("<C-y>"), "in")
							else
								-- something selected, confirm selection by stopping Ctrl-X mode
								-- :h i_CTRL-X_CTRL-Z*
								feedkeys.call(keymap.t("<C-X><C-Z>"), "in")
							end
						else
							-- `nvim-cmp` default confirm action
							-- Accept currently selected item.
							-- Set `select` to `false` to only confirm explicitly selected items.
							cmp.mapping.confirm({ select = true })(fallback)
						end
					end, { "i", "s" }),
					["<C-l>"] = cmp.mapping(function(fallback)
						if luasnip.expandable() then
							luasnip.expand()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						elseif check_backspace() then
							fallback()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<C-h>"] = cmp.mapping(function(fallback)
						if luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
					["<Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_next_item()
						elseif luasnip.expandable() then
							luasnip.expand()
						elseif luasnip.expand_or_jumpable() then
							luasnip.expand_or_jump()
						elseif check_backspace() then
							fallback()
						else
							fallback()
						end
					end, { "i", "s" }),
					["<S-Tab>"] = cmp.mapping(function(fallback)
						if cmp.visible() then
							cmp.select_prev_item()
						elseif luasnip.jumpable(-1) then
							luasnip.jump(-1)
						else
							fallback()
						end
					end, { "i", "s" }),
				}),
				sources = cmp.config.sources({
					{ name = "luasnip", max_item_count = 4 },
					{ name = "nvim_lsp"},
					{ name = "nvim_lua" },
					{ name = "path" },
				}),

				formatting = {
					fields = { "abbr", "menu" },
					format = function(entry, vim_item)
						vim_item.menu = ({
							nvim_lsp = "[LSP]",
							luasnip = "[Snippet]",
							path = "[Path]",
						})[entry.source.name]
						return vim_item
					end,
				},
				experimental = {
					ghost_text = false,
					native_menu = false,
				},
				sorting = {
					-- https://github.com/hrsh7th/nvim-cmp/blob/main/lua/cmp/config/compare.lua
					comparators = {
						compare.offset,
						compare.exact,
						compare.recently_used,
						function(entry1, entry2) -- sort by length ignoring "=~"
							local len1 = string.len(string.gsub(entry1.completion_item.label, "[=~()]", ""))
							local len2 = string.len(string.gsub(entry2.completion_item.label, "[=~()]", ""))
							if len1 ~= len2 then
								return len1 - len2 < 0
							end
						end,
						function(entry1, entry2) -- sort by compare kind (Variable, Function etc)
							local kind1 = modified_kind(entry1:get_kind())
							local kind2 = modified_kind(entry2:get_kind())
							if kind1 ~= kind2 then
								return kind1 - kind2 < 0
							end
						end,
						function(entry1, entry2) -- score by lsp, if available
							local t1 = entry1.completion_item.sortText
							local t2 = entry2.completion_item.sortText
							if t1 ~= nil and t2 ~= nil and t1 ~= t2 then
								return t1 < t2
							end
						end,
						compare.score,
						compare.order,
					},
				},
				window = {
					documentation = {
						border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
					},
				},
			})
			-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
			cmp.setup.cmdline(":", {
				mapping = cmp.mapping.preset.cmdline({
					["<C-y>"] = cmp.mapping(cmp.mapping.confirm(), { "i", "c" }),
					["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
					["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
				}),
				sources = cmp.config.sources({
					{ name = "path" },
					{ name = "cmdline" },
				}),
			})
		end,
	},
}

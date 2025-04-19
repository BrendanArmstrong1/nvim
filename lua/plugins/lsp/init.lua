local function on_attach(on_attach)
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local buffer = args.buf
			local client = vim.lsp.get_client_by_id(args.data.client_id)
			-- toggle options
			local enabled = true
			function Toggle_diagnostics()
				enabled = not enabled
				if enabled then
					vim.diagnostic.enable(0)
					print("Diagnostics on")
				else
					vim.diagnostic.disable(0)
					print("Diagnostics off")
				end
			end
			vim.keymap.set("n", "<leader>ld", Toggle_diagnostics, { desc = "Diagnostics" })
			vim.api.nvim_set_option_value("omnifunc", "v:lua.vim.lsp.omnifunc", {})
			on_attach(client, buffer)
		end,
	})
end

return {
	-- lspconfig
	{
		"neovim/nvim-lspconfig",
		event = { "BufReadPost", "BufNewFile" },
		dependencies = {
			"mason.nvim",
			"williamboman/mason-lspconfig.nvim",
			"L3MON4D3/LuaSnip",
		},
		---@class PluginLspOpts
		opts = {
			-- options for vim.diagnostic.config()
			diagnostics = {
				underline = true,
				update_in_insert = false,
				virtual_text = { spacing = 4, source = "if_many", prefix = "●" },
				severity_sort = true,
        -- virtual_lines = {current_line = true}
			},
			-- Automatically format on save
			autoformat = true,
			-- options for vim.lsp.buf.format
			-- `bufnr` and `filter` is handled by the LazyVim formatter,
			-- but can be also overridden when specified
			format = {
				formatting_options = nil,
				timeout_ms = nil,
			},
			-- LSP Server Settings
			servers = {
				marksman = { single_file_support = true },
				bashls = { single_file_support = true },
				clangd = {
					-- init_options = { fallbackFlags = { "-xc", "-Wall", "-Wextra", "-pedantic", "-std=c89" } },
					single_file_support = true,
					-- filetypes = { "c", "h" },
				},
				cssls = {},
				ts_ls = {},
				texlab = {},
				-- html = {},
				rust_analyzer = {
					["rust-analyzer"] = {
						single_file_support = true,
						assist = {
							importEnforceGranularity = true,
							importPrefix = "crate",
						},
						cargo = {
							features = "all",
						},
						checkOnSave = {
							overrideCommand = { "cargo", "clippy", "--message-format=json" },
						},
						inlayHints = {
							lifetimeElisionHints = {
								enable = true,
								useParameterNames = true,
							},
						},
					},
				},
				pyright = {
					python = {
						disableOrganizeImports = false,
						analysis = {
							indexing = true,
							include = function()
								vim.fn.getcwd()
							end,
							typeCheckingMode = "basic",
              reportUnusedImport = "error",
							autoSearchPaths = true,
							autoImportCompletions = true,
							diagnosticMode = "openFilesOnly",
							useLibraryCodeForTypes = true,
						},
					},
				},
				-- pylsp = {
				-- 	settings = {
				-- 		pylsp = {
				-- 			single_file_support = true,
				-- 			configurationSources = { "flake8" },
				-- 			plugins = {
				-- 				mccabe = {
				-- 					threshold = 20,
				-- 				},
				-- 				pydocstyle = {
				-- 					enabled = false,
				-- 					convention = "numpy",
				-- 				},
				-- 				flake8 = {
				-- 					enabled = true,
				-- 					extendIgnore = {
				-- 						"W391",
				-- 						"E742",
				-- 						"W503",
				-- 						"W504",
				--                 "E402",
				-- 					},
				--               perFileIgnores = {
				--                 ["__init__.py"] = "F01",
				--               },
				-- 					maxLineLength = 100,
				-- 				},
				-- 				pyflakes = {
				-- 					enabled = true,
				-- 				},
				-- 				pycodestyle = {
				-- 					enabled = false,
				-- 				},
				-- 			},
				-- 		},
				-- 	},
				-- },
				lua_ls = {
					settings = {
						single_file_support = true,
						Lua = {
							diagnostics = {
								globals = { "vim" },
								undefined_global = false,
								missing_parameters = false,
							},
						},
					},
				},
			},
			-- you can do any additional lsp server setup here
			-- return true if you don't want this server to be setup with lspconfig
			setup = {
				-- example to setup with typescript.nvim
				-- tsserver = function(_, opts)
				--   require("typescript").setup({ server = opts })
				--   return true
				-- end,
				-- Specify * to use this function as a fallback for any server
				-- ["*"] = function(server, opts) end,
			},
		},
		---@param opts PluginLspOpts
		config = function(_, opts)
			-- setup formatting and keymaps
			on_attach(function(client, buffer)
				require("plugins.lsp.keymaps").on_attach(client, buffer)
			end)

			-- local luasnip = require("luasnip")
			-- snippet expansion autocommand portion
			vim.api.nvim_create_augroup("my-luasnip", {})
			vim.api.nvim_create_autocmd("CompleteDone", {
				group = "my-luasnip",
				desc = "Expand LSP snippet",
				pattern = "*",
				callback = function(_)
					local comp = vim.v.completed_item

					-- check that this is an lsp completion
					if not vim.tbl_get(comp, "user_data", "nvim", "lsp") then
						return
					end

					-- check that we were given a snippet
					local complete_info = comp.user_data.nvim.lsp.completion_item
					if not complete_info.insertTextFormat or complete_info.insertTextFormat == 1 then
						return
					end

					if vim.snippet.active() then
						return
					end

					-- Retrieve the snippet text
					local snip_text = complete_info.insertText
					if complete_info.textEdit and complete_info.textEdit.newText then
						snip_text = complete_info.textEdit.newText
					end

					if not snip_text then
						return
					end

					-- remove the inserted text
					local cursor_col = vim.fn.col(".")
					local start_col = cursor_col - #comp.word
					vim.fn.cursor(vim.fn.line("."), start_col)
					vim.cmd.normal({ args = { "d" .. #comp.word .. "l" }, bang = true })

					-- if the inserted text was the last text on the line, the deletion command will leave the cursor 1 column left
					-- of where we need to insert the snippet (because insert mode can put the cursor 1 position ahead of the last column)
					-- move the cursor back over 1
					vim.fn.cursor(vim.fn.line("."), start_col)

					-- luasnip.lsp_expand(snip_text)
					vim.snippet.expand(snip_text)
				end,
			})

			-- diagnostics
			for name, icon in pairs(require("config.settings").icons.diagnostics) do
				name = "DiagnosticSign" .. name
				vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
			end
			vim.diagnostic.config(opts.diagnostics)

			local servers = opts.servers
			local function setup(server)
				local server_opts = vim.tbl_deep_extend("force", {
					capabilities = vim.deepcopy(), -- took out cmp capabilities
				}, servers[server] or {})

				if opts.setup[server] then
					if opts.setup[server](server, server_opts) then
						return
					end
				elseif opts.setup["*"] then
					if opts.setup["*"](server, server_opts) then
						return
					end
				end
				require("lspconfig")[server].setup(server_opts)
			end

			local have_mason, mlsp = pcall(require, "mason-lspconfig")
			local available = have_mason and mlsp.get_available_servers() or {}

			local ensure_installed = {} ---@type string[]
			for server, server_opts in pairs(servers) do
				if server_opts then
					server_opts = server_opts == true and {} or server_opts
					-- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
					if server_opts.mason == false or not vim.tbl_contains(available, server) then
						setup(server)
					else
						ensure_installed[#ensure_installed + 1] = server
					end
				end
			end

			if have_mason then
				mlsp.setup({ ensure_installed = ensure_installed })
				mlsp.setup_handlers({ setup })
			end
		end,
	},

	-- lsp symbol navigation for lualine
	{
		"SmiteshP/nvim-navic",
		init = function()
			vim.g.navic_silence = true
			on_attach(function(client, buffer)
				require("nvim-navic").attach(client, buffer)
			end)
		end,
		opts = { separator = " ", highlight = true, depth_limit = 5 },
	},

	-- -- formatters and linters
	{
		"dense-analysis/ale",
		event = "BufReadPost",
		config = function()
			vim.g.ale_linters_explicit = 1
			vim.g.ale_linters = {
				python = { "ruff", "mypy" },
				rust = { "analyzer", "cargo" },
				javascript = { "ts_ls" },
				css = { "csslint" },
				tex = { "texlab" },
			}

			vim.g.ale_python_mypy_options = "--enable-incomplete-feature=Unpack --check-untyped-defs"
			vim.g.ale_python_mypy_ignore_invalid_syntax = 1
			vim.g.ale_python_ruff_format_options = "--line-length 100"
			vim.g.ale_python_black_options = "--line-length 100"

			vim.g.ale_rust_cargo_use_clippy = vim.fn.executable("cargo-clippy")

			vim.g.ale_fix_on_save = 0
			vim.g.ale_c_clangformat_use_local_file = 1

			vim.g.ale_fixers = {
				["*"] = { "remove_trailing_lines", "trim_whitespace" },
				python = { "ruff_format" },
				lua = { "stylua" },
				rust = { "rustfmt" },
				c = { "clang-format" },
				javascript = { "prettier" },
				css = { "prettier" },
				tex = { "latexindent" },
			}
		end,
	},

	-- cmdline tools and lsp servers
	{

		"williamboman/mason.nvim",
		cmd = "Mason",
		keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
		opts = function(_)
			require("mason").setup()
			local ensure_installed = {
				"stylua",
				-- "selene",
				"flake8",
				"black",
				"ruff",
				"mypy",
				"rust-analyzer",
			}
			local mr = require("mason-registry")
			for _, tool in ipairs(ensure_installed) do
				local p = mr.get_package(tool)
				if not p:is_installed() then
					p:install()
				end
			end
		end,
	},
}

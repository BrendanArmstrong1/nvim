local function on_attach(on_attach)
	vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(args)
			local buffer = args.buf
			local client = vim.lsp.get_client_by_id(args.data.client_id)
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
			"hrsh7th/cmp-nvim-lsp",
		},
		---@class PluginLspOpts
		opts = {
			-- options for vim.diagnostic.config()
			diagnostics = {
				underline = true,
				update_in_insert = false,
				virtual_text = { spacing = 4, prefix = "●" },
				severity_sort = true,
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
				clangd = { single_file_support = true },
				cssls = {},
				tsserver = {},
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
				pylsp = {
					settings = {
						pylsp = {
							single_file_support = true,
							configurationSources = { "flake8" },
							plugins = {
								mccabe = {
									threshold = 20,
								},
								pydocstyle = {
									enabled = false,
									convention = "numpy",
								},
								flake8 = {
									enabled = true,
									extendIgnore = {
										"W391",
										"E742",
										"W503",
										"W504",
									},
									maxLineLength = 100,
								},
								pyflakes = {
									enabled = true,
								},
								pycodestyle = {
									enabled = false,
								},
							},
						},
					},
				},
				lua_ls = {
					settings = {
						single_file_support = true,
						Lua = {
							diagnostics = {
								globals = { "vim" },
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

			-- diagnostics
			for name, icon in pairs(require("config.settings").icons.diagnostics) do
				name = "DiagnosticSign" .. name
				vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
			end
			vim.diagnostic.config(opts.diagnostics)

			local servers = opts.servers
			local capabilities =
				require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

			local function setup(server)
				local server_opts = vim.tbl_deep_extend("force", {
					capabilities = vim.deepcopy(capabilities),
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
				javascript = { "tsserver" },
				css = { "csslint" },
			}

			vim.g.ale_python_mypy_options = "--enable-incomplete-feature=Unpack --check-untyped-defs"
			vim.g.ale_python_mypy_ignore_invalid_syntax = 1
			vim.g.ale_python_ruff_format_options = "--line-length 100"
			vim.g.ale_python_black_options = "--line-length 100"

			vim.g.ale_rust_cargo_use_clippy = vim.fn.executable("cargo-clippy")

			vim.g.ale_fix_on_save = 0

			vim.g.ale_fixers = {
				["*"] = { "remove_trailing_lines", "trim_whitespace" },
				python = { "ruff_format" },
				lua = { "stylua" },
				rust = { "rustfmt" },
				c = { "clang-format" },
				javascript = { "prettier" },
        css = { "prettier" },
			}
		end,
	},

	-- cmdline tools and lsp servers
	{

		"williamboman/mason.nvim",
		cmd = "Mason",
		keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
		ensure_installed = {
			"stylua",
			-- "selene",
			"flake8",
			"black",
			"ruff",
			"mypy",
			"rust-analyzer",
		},
		opts = function(plugin)
			require("mason").setup()
			local mr = require("mason-registry")
			for _, tool in ipairs(plugin.ensure_installed) do
				local p = mr.get_package(tool)
				if not p:is_installed() then
					p:install()
				end
			end
		end,
	},
}

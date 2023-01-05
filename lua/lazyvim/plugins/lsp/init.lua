return {
    -- lspconfig
    {
        "neovim/nvim-lspconfig",
        event = "BufReadPre",
        dependencies = {
            "mason.nvim",
            { "williamboman/mason-lspconfig.nvim", config = { automatic_installation = true } },
            "hrsh7th/cmp-nvim-lsp",
        },
        servers = nil,
        config = function(plugin)
            -- setup formatting and keymaps
            require("lazyvim.util").on_attach(function(client, buffer)
                require("lazyvim.plugins.lsp.format").on_attach(client, buffer)
                require("lazyvim.plugins.lsp.keymaps").on_attach(client, buffer)
            end)

            -- diagnostics
            for name, icon in pairs(require("lazyvim.config.settings").icons.diagnostics) do
                name = "DiagnosticSign" .. name
                vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
            end
            vim.diagnostic.config({
                underline = true,
                update_in_insert = false,
                virtual_text = { spacing = 4, prefix = "●" },
                severity_sort = true,
            })

            local capabilities =
                require("cmp_nvim_lsp").default_capabilities(vim.lsp.protocol.make_client_capabilities())

            local servers = plugin.servers or require("lazyvim.plugins.lsp.servers")
            for server, opts in pairs(servers) do
                opts.capabilities = capabilities
                require("lspconfig")[server].setup(opts)
            end
        end,
    },

    -- formatters
    {
        "jose-elias-alvarez/null-ls.nvim",
        event = "BufReadPre",
        dependencies = { "mason.nvim" },
        config = function()
            local null_ls = require("null-ls")
            -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
            local formatting = null_ls.builtins.formatting
            -- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
            -- local diagnostics = null_ls.builtins.diagnostics
            null_ls.setup({
                debug = false,
                log_level = "info",
                sources = {
                    -- formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
                    formatting.black.with({ extra_args = { "--fast" } }),
                    formatting.shfmt,
                    formatting.clang_format,
                    formatting.cmake_format,
                    formatting.stylua.with({ extra_args = { "--indent-type", "Spaces" } }),
                    formatting.codespell.with({ filetype = { "markdown", "txt" } }),
                    formatting.rustfmt.with({
                        extra_args = function(params)
                            local Path = require("plenary.path")
                            local cargo_toml = Path:new(params.root .. "/" .. "Cargo.toml")

                            if cargo_toml:exists() and cargo_toml:is_file() then
                                for _, line in ipairs(cargo_toml:readlines()) do
                                    local edition = line:match([[^edition%s*=%s*%"(%d+)%"]])
                                    if edition then
                                        return { "--edition=" .. edition }
                                    end
                                end
                            end
                            -- default edition when we don't find `Cargo.toml` or the `edition` in it.
                            return { "--edition=2021" }
                        end,
                    }),
                },
            })
        end,
    },

    -- cmdline tools and lsp servers
    {

        "williamboman/mason.nvim",
        cmd = "Mason",
        keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
        ensure_installed = {
            "stylua",
            "shellcheck",
            "shfmt",
            "black",
            "flake8",
        },
        config = function(plugin)
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

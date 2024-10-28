return {
    {
        "williamboman/mason.nvim",
        opts = function(_, opts)
            vim.list_extend(opts.ensure_installed, {
                "stylua",
                "selene",
                "luacheck",
                "shellcheck",
                "shfmt",
                "gopls",
                "gofumpt",
                "pyright",
                "ruff",
            })
        end,
    },
    {
        "neovim/nvim-lspconfig",
        opts = {
            inlay_hints = { enabled = false },
            servers = {
                gopls = {
                    gofumpt = true,
                    hints = {
                        assignVariableTypes = false,
                        compositeLiteralFields = false,
                        compositeLiteralTypes = false,
                        constantValues = false,
                        functionTypeParameters = false,
                        parameterNames = false,
                        rangeVariableTypes = false,
                    },
                },
            },
        },
    },
}

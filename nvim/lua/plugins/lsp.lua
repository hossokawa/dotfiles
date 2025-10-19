return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      inlay_hints = { enabled = false },
      diagnostics = {
        virtual_text = false,
      },
      servers = {
        basedpyright = {
          settings = {
            basedpyright = {
              disableOrganizeImports = true,
              analysis = {
                -- ignore = { "*" },
                autoImportCompletions = true,
                autoSearchPaths = true,
                diagnosticMode = "openFilesOnly",
                typeCheckingMode = "recommended",
                useLibraryCodeForTypes = true,
                diagnosticSeverityOverrides = {
                  --   reportUnknownVariableType = false,
                  --   reportUnknownMemberType = false,
                  --   reportUnknownArgumentType = false,
                  --   reportUndefinedVariable = false,
                  --   reportUnusedImport = false,
                  --   reportUnusedVariable = false,
                  reportMissingTypeStubs = "none",
                },
              },
            },
          },
        },
        gopls = {
          settings = {
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
    },
  },
}

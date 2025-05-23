-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

require("lspconfig").ruff.setup({
  init_options = {
    settings = {
      lineLength = 80,
    },
  },
})

-- require("lspconfig").basedpyright.setup({
--   settings = {
--     basedpyright = {
--       -- Using Ruff's import organizer
--       disableOrganizeImports = true,
--       analysis = {
--         autoImportCompletions = true,
--         diagnosticMode = "openFilesOnly",
--         useLibraryCodeForTypes = true,
--       },
--     },
--   },
-- })

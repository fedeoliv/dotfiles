return {
  "williamboman/mason.nvim",
  opts = {
    ensure_installed = {
      --lua
      "stylua",

      -- python
      "basedpyright",
      "ruff",
      "ruff-lsp",

      --java
      "jdtls",
      "java-debug-adapter",
      "checkstyle",
      "google-java-format",

      -- markdown
      "marksman",

      -- serialization formats
      "yaml-language-server",
      "lemminx",

      -- shell
      "shfmt",
    },
  },
}
-- return {
--   "neovim/nvim-lspconfig",
--   event = { "BufReadPost", "BufNewFile" },
--   cmd = { "LspInfo", "LspInstall", "LspUninstall" },
--   config = function()
--     require("plugins.lsp.handlers").setup()
--   end,
--   dependencies = {
--     {
--       "williamboman/mason.nvim",
--       cmd = {
--         "Mason",
--         "MasonInstall",
--         "MasonUninstall",
--         "MasonUninstallAll",
--         "MasonLog",
--       }, -- Package Manager
--       dependencies = "williamboman/mason-lspconfig.nvim",
--       config = function()
--         local mason = require("mason")
--         local mason_lspconfig = require("mason-lspconfig")
--         local lspconfig = require("lspconfig")
--
--         require("lspconfig.ui.windows").default_options.border = "rounded"
--
--         local auto_install = {
--           "lua_ls",
--           "clangd",
--           "basedpyright",
--           "ruff",
--           "cssls",
--           "html",
--           "ts_ls",
--           "emmet_ls",
--           "jdtls",
--           "lemminx",
--           "marksman",
--           "yamlls",
--           "vimls",
--         }
--
--         mason.setup({
--           ui = {
--             -- Whether to automatically check for new versions when opening the :Mason window.
--             check_outdated_packages_on_open = false,
--             border = "single",
--             icons = {
--               package_pending = " ",
--               package_installed = " ",
--               package_uninstalled = " ",
--             },
--           },
--         })
--
--         mason_lspconfig.setup({
--           ensure_installed = auto_install,
--         })
--
--         local disabled_servers = {
--           "jdtls",
--         }
--
--         mason_lspconfig.setup_handlers({
--           function(server_name)
--             for _, name in pairs(disabled_servers) do
--               if name == server_name then
--                 return
--               end
--             end
--
--             require("ufo").setup()
--
--             local opts = {
--               on_attach = require("plugins.lsp.handlers").on_attach,
--               capabilities = require("plugins.lsp.handlers").capabilities,
--             }
--
--             local require_ok, server = pcall(require, "plugins.lsp.settings." .. server_name)
--             if require_ok then
--               opts = vim.tbl_deep_extend("force", server, opts)
--             end
--
--             lspconfig[server_name].setup(opts)
--           end,
--         })
--       end,
--     },
--   },
--   opts = {
--     inlay_hints = {
--       enabled = true,
--       exclude = { "vue" }, -- filetypes for which you don't want to enable inlay hints
--     },
--     codelens = {
--       enabled = false,
--     },
--     servers = {
--       basedpyright = {},
--       ruff_lsp = {},
--     },
--     setup = {
--       ruff_lsp = function()
--         require("lazyvim.util").lsp.on_attach(function(client, _)
--           if client.name == "ruff_lsp" then
--             -- Disable hover in favor of Pyright
--             client.server_capabilities.hoverProvider = false
--           end
--         end)
--       end,
--     },
--   },
-- }

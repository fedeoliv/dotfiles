return {
  "iabdelkareem/csharp.nvim",
  dependencies = {
    "williamboman/mason.nvim", -- Required, automatically installs omnisharp
    "mfussenegger/nvim-dap",
    "Tastyep/structlog.nvim", -- Optional, but highly recommended for debugging
  },
  config = function()
    require("mason").setup() -- Mason setup must run before csharp
    require("csharp").setup()
  end,
  ft = { "cs" },
  opts = {
    lsp = {
      omnisharp = {
        -- When set to false, csharp.nvim won't launch omnisharp automatically.
        enable = true,
        -- When set, csharp.nvim won't install omnisharp automatically. Instead, the omnisharp instance in the cmd_path will be used.
        cmd_path = nil,
        -- The default timeout when communicating with omnisharp
        default_timeout = 1000,
        -- Settings that'll be passed to the omnisharp server
        enable_editor_config_support = true,
        organize_imports = true,
        load_projects_on_demand = false,
        enable_analyzers_support = true,
        enable_import_completion = true,
        include_prerelease_sdks = true,
        analyze_open_documents_only = false,
        enable_package_auto_restore = true,
        -- Launches omnisharp in debug mode
        debug = false,
      },
      roslyn = {
        -- When set to true, csharp.nvim will launch roslyn automatically.
        enable = false,
        -- Path to the roslyn LSP see 'Roslyn LSP Specific Prerequisites' above.
        cmd_path = nil,
      },
    },
  },
}

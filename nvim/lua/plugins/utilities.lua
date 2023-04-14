return {
  {
    "hrsh7th/nvim-cmp",
    event = "VeryLazy",
    dependencies = { "hrsh7th/cmp-emoji" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "emoji" } }))
    end,
  },

  -- Seamless navigation between tmux panes and vim splits
  {
    "christoomey/vim-tmux-navigator",
    event = "VeryLazy",
  },

  -- LSP extensions for eclipse jdtls
  {
    "mfussenegger/nvim-jdtls",
    event = "VeryLazy",
  },

  -- Markdown preview
  {
    "iamcco/markdown-preview.nvim",
    event = "VeryLazy",
    -- build = "cd app && npm install",
    config = function()
      vim.fn["mkdp#util#install"]()
    end,
  },

  -- w,e,b motions considering camelCase, snake_case and kebab-case as punctuation
  {
    "chrisgrieser/nvim-spider",
    event = "VeryLazy",
  },
}

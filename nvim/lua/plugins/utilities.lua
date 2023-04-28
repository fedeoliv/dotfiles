return {
  -- Code snippet
  {
    "L3MON4D3/LuaSnip",
    event = "VeryLazy",
    keys = function()
      return {}
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
}

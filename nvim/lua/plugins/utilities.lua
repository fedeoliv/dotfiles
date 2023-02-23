return {
  "christoomey/vim-tmux-navigator", -- Seamless navigation between tmux panes and vim splits
  "mfussenegger/nvim-jdtls", -- LSP extensions for eclipse jdtls

  -- Markdown preview
  {
    "iamcco/markdown-preview.nvim",
    -- build = "cd app && npm install",
    config = function()
      vim.fn["mkdp#util#install"]()
    end,
  },
}

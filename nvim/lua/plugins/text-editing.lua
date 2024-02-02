return {
  -- Edit Markdown table
  {
    "kiran94/edit-markdown-table.nvim",
    config = function()
      require("edit-markdown-table").setup()
    end,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    cmd = "EditMarkdownTable",
    event = "VeryLazy",
  },

  {
    "lukas-reineke/headlines.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    opts = {},
  },

  {
    "preservim/vim-pencil",
  },
}

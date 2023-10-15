return {
  -- Edit filesystem like a buffer
  {
    "stevearc/oil.nvim",
    opts = {},
    dependencies = { "nvim-tree/nvim-web-devicons" },
  },
  -- Code snippet
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },

  -- Terminals management
  {
    {
      "akinsho/toggleterm.nvim",

      version = "*",
      event = "VeryLazy",
      opts = {
        open_mapping = [[<c-\>]],
        direction = "float",
        float_opts = {
          border = "curved",
        },
      },
    },
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
}

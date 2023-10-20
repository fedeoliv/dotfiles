return {
  -- {
  --   "folke/tokyonight.nvim",
  --   lazy = false,
  --   priority = 1000,
  --   opts = {
  --     transparent = true,
  --   },
  --   -- enabled = false,
  -- },
  -- {
  --   "catppuccin/nvim",
  --   name = "catppuccin",
  --   priority = 1000,
  -- },
  {
    "bluz71/vim-nightfly-colors",
    name = "nightfly",
    lazy = true,
    priority = 1000,
  },
  -- {
  --   "kvrohit/mellow.nvim",
  --   lazy = true,
  --   priority = 1000,
  --   enabled = false,
  -- },
  -- {
  --   "marko-cerovac/material.nvim",
  --   lazy = true,
  --   priority = 1000,
  --   enabled = false,
  -- },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "nightfly",
    },
  },
}

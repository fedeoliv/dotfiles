return {
  { "catppuccin/nvim", enabled = false },
  {
    "bluz71/vim-nightfly-colors",
    name = "nightfly",
    lazy = true,
    priority = 1000,
    enabled = false,
  },
  {
    "Yazeed1s/minimal.nvim",
    name = "minimal",
    lazy = false,
    enabled = false,
  },
  {
    "kvrohit/mellow.nvim",
    lazy = true,
    priority = 1000,
    enabled = false,
  },
  {
    "marko-cerovac/material.nvim",
    lazy = true,
    priority = 1000,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "material",
    },
  },
}

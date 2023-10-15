return {
  { "catppuccin/nvim", enabled = false },
  {
    "bluz71/vim-nightfly-colors",
    name = "nightfly",
    lazy = true,
    priority = 1000,
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
    enabled = false,
  },
  {
    "rockyzhang24/arctic.nvim",
    branch = "v2",
    dependencies = { "rktjmp/lush.nvim" },
    enabled = false,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "nightfly",
    },
  },
}

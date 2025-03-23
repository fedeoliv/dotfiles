return {
  {
    "sam4llis/nvim-tundra",
    opts = {
      transparent_background = true,
      dim_inactive_windows = {
        enabled = false,
        color = nil,
      },
    },
  },
  {
    "sainnhe/gruvbox-material",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.gruvbox_material_enable_italic = true
      vim.g.gruvbox_material_transparent_background = 2
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = { colorscheme = "gruvbox-material" },
  },
}

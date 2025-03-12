return {
  "LunarVim/breadcrumbs.nvim",
  dependencies = {
    "SmiteshP/nvim-navic",
  },
  config = function()
    require("breadcrumbs").setup()
  end,
}

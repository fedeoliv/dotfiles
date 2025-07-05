return {
  "LunarVim/breadcrumbs.nvim",
  event = "VeryLazy",
  dependencies = {
    "SmiteshP/nvim-navic",
  },
  config = function()
    require("breadcrumbs").setup()
  end,
}

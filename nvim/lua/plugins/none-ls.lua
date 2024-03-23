return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvimtools/none-ls-extras.nvim",
  },
  opts = function(_, opts)
    opts.sources = vim.list_extend(opts.sources or {}, {
      require("none-ls.formatting.ruff"),
    })
  end,
}

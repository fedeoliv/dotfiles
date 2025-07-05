-- show lsp progress
return {
  "j-hui/fidget.nvim",
  event = "VeryLazy",
  opts = {
    notification = {
      window = {
        winblend = 0,
      },
    },
  },
}

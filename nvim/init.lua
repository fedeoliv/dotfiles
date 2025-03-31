-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

vim.lsp.enable({
  --python
  "basedpyright",
  "ruff",
  "ruff-lsp",

  -- java
  "jdtls",

  --markdown
  "marksman",

  --xml
  "lemminx",
})

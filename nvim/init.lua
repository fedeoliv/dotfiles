-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

-- require("config.options")
-- require("config.keymaps")

-- vim.pack.add({
--   { src = "https://github.com/vague2k/vague.nvim" },
-- })

-- vim.cmd("colorscheme vague")

vim.lsp.enable({
  --python
  "basedpyright",
  "ruff",
  "ruff-lsp",

  -- java
  -- "jdtls",

  --markdown
  "marksman",

  -- swift, objective c
  "sourcekit",

  --xml
  "lemminx",
})

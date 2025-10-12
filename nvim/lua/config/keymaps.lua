local map = vim.keymap.set

map("n", "<leader>o", ":update<CR> :source<CR>")
map("n", "<leader>w", ":write<CR>")
map("n", "<leader>q", ":quit<CR>")
map("n", "<leader>e", ":Oil<CR>")

map("n", "<C-h>", "<Cmd>NvimTmuxNavigateLeft<CR>", { silent = true })
map("n", "<C-j>", "<Cmd>NvimTmuxNavigateDown<CR>", { silent = true })
map("n", "<C-k>", "<Cmd>NvimTmuxNavigateUp<CR>", { silent = true })
map("n", "<C-l>", "<Cmd>NvimTmuxNavigateRight<CR>", { silent = true })
map("n", "<C-\\>", "<Cmd>NvimTmuxNavigateLastActive<CR>", { silent = true })
map("n", "<C-Space>", "<Cmd>NvimTmuxNavigateNavigateNext<CR>", { silent = true })

-- smart dd: only yank the line if it's not empty
map("n", "dd", function()
  if vim.fn.getline(".") == "" then
    return '"_dd'
  end
  return "dd"
end, { expr = true })

-- nvim-spider
map({ "n", "o", "x" }, "w", function()
  require("spider").motion("w")
end, { desc = "Spider-w" })

map({ "n", "o", "x" }, "e", function()
  require("spider").motion("e")
end, { desc = "Spider-e" })

map({ "n", "o", "x" }, "b", function()
  require("spider").motion("b")
end, { desc = "Spider-b" })

map({ "n", "o", "x" }, "ge", function()
  require("spider").motion("ge")
end, { desc = "Spider-ge" })

-- Markdown
map("n", "<leader>mp", "<cmd>MarkdownPreview<CR>")

-- rest.nvim
map("n", "<leader>rr", "<cmd>Rest run<CR>")

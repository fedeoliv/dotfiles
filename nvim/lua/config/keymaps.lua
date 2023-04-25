-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

-- nvim-spider
vim.keymap.set({ "n", "o", "x" }, "w", function()
  require("spider").motion("w")
end, { desc = "Spider-w" })

vim.keymap.set({ "n", "o", "x" }, "e", function()
  require("spider").motion("e")
end, { desc = "Spider-e" })

vim.keymap.set({ "n", "o", "x" }, "b", function()
  require("spider").motion("b")
end, { desc = "Spider-b" })

vim.keymap.set({ "n", "o", "x" }, "ge", function()
  require("spider").motion("ge")
end, { desc = "Spider-ge" })

-- open file_browser with the path of the current buffer
vim.keymap.set("n", "<space>bf", "<cmd>Telescope file_browser<cr>", { noremap = true, silent = true })

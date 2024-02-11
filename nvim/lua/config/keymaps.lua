-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua

local keymap = vim.keymap.set

keymap("n", "<C-h>", "<Cmd>NvimTmuxNavigateLeft<CR>", { silent = true })
keymap("n", "<C-j>", "<Cmd>NvimTmuxNavigateDown<CR>", { silent = true })
keymap("n", "<C-k>", "<Cmd>NvimTmuxNavigateUp<CR>", { silent = true })
keymap("n", "<C-l>", "<Cmd>NvimTmuxNavigateRight<CR>", { silent = true })
keymap("n", "<C-\\>", "<Cmd>NvimTmuxNavigateLastActive<CR>", { silent = true })
keymap("n", "<C-Space>", "<Cmd>NvimTmuxNavigateNavigateNext<CR>", { silent = true })

-- smart dd: only yank the line if it's not empty
keymap("n", "dd", function()
  if vim.fn.getline(".") == "" then
    return '"_dd'
  end
  return "dd"
end, { expr = true })

-- nvim-spider
keymap({ "n", "o", "x" }, "w", function()
  require("spider").motion("w")
end, { desc = "Spider-w" })

keymap({ "n", "o", "x" }, "e", function()
  require("spider").motion("e")
end, { desc = "Spider-e" })

keymap({ "n", "o", "x" }, "b", function()
  require("spider").motion("b")
end, { desc = "Spider-b" })

keymap({ "n", "o", "x" }, "ge", function()
  require("spider").motion("ge")
end, { desc = "Spider-ge" })

-- open file_browser with the path of the current buffer
-- keymap("n", "<space>bf", "<cmd>Telescope file_browser<cr>", { noremap = true, silent = true })

-- Telescope
keymap("n", "<leader><leader>", "<Cmd>Telescope frecency<CR>")

-- Markdown
keymap("n", "<leader>mp", "<cmd>MarkdownPreview<CR>")

-- LSP
keymap("n", "gh", "<cmd>Lspsaga lsp_finder<CR>") --find the symbol's definition
keymap({ "n", "v" }, "<leader>ca", "<cmd>Lspsaga code_action<CR>") --code action
keymap("n", "gr", "<cmd>Lspsaga rename<CR>") -- rename all occurrences of the hovered word in the file
keymap("n", "gr", "<cmd>Lspsaga rename ++project<CR>") -- rename all occurrences of the hovered word for the selected files
keymap("n", "gp", "<cmd>Lspsaga peek_definition<CR>")
keymap("n", "gd", "<cmd>Lspsaga goto_definition<CR>")
keymap("n", "gt", "<cmd>Lspsaga peek_type_definition<CR>")
keymap("n", "gt", "<cmd>Lspsaga goto_type_definition<CR>")
keymap("n", "<leader>sl", "<cmd>Lspsaga show_line_diagnostics<CR>")

keymap("n", "<leader>sb", "<cmd>Lspsaga show_buf_diagnostics<CR>")
keymap("n", "<leader>sw", "<cmd>Lspsaga show_workspace_diagnostics<CR>")
keymap("n", "<leader>sc", "<cmd>Lspsaga show_cursor_diagnostics<CR>")
keymap("n", "[e", "<cmd>Lspsaga diagnostic_jump_prev<CR>")
keymap("n", "]e", "<cmd>Lspsaga diagnostic_jump_next<CR>")

-- Diagnostic jump with filters such as only jumping to an error
keymap("n", "[E", function()
  require("lspsaga.diagnostic"):goto_prev({ severity = vim.diagnostic.severity.ERROR })
end)

keymap("n", "]E", function()
  require("lspsaga.diagnostic"):goto_next({ severity = vim.diagnostic.severity.ERROR })
end)

keymap("n", "<leader>o", "<cmd>Lspsaga outline<CR>")

-- If you want to keep the hover window in the top right hand corner,
-- you can pass the ++keep argument
-- Note that if you use hover with ++keep, pressing this key again will
-- close the hover window. If you want to jump to the hover window
-- you should use the wincmd command "<C-w>w"
-- keymap("n", "K", "<cmd>Lspsaga hover_doc ++keep<CR>")
keymap("n", "K", "<cmd>Lspsaga hover_doc<CR>")

keymap("n", "<Leader>ci", "<cmd>Lspsaga incoming_calls<CR>")
keymap("n", "<Leader>co", "<cmd>Lspsaga outgoing_calls<CR>")

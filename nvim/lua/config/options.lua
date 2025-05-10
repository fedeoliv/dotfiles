-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

local opt = vim.opt

opt.numberwidth = 3
opt.signcolumn = "yes:1"
opt.statuscolumn = "%l %s"

opt.conceallevel = 2
opt.laststatus = 2

vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.opt.listchars = { tab = "-->", multispace = " ", trail = "", extends = "⟩", precedes = "⟨" }

vim.g.move_key_modifier_visualmode = "S"

vim.diagnostic.config({
  float = { border = "single" },
  virtual_text = true,
})

-- Providers
vim.g.python_host_prog = vim.fn.system("which python3")
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

vim.opt.background = "dark"

vim.opt.spellfile = {
  vim.fn.stdpath("config") .. "/spell/en.utf-8.add",
  vim.fn.stdpath("config") .. "/spell/pt.utf-8.add",
}

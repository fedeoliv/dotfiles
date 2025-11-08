vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.wrap = false
vim.opt.tabstop = 2
vim.opt.swapfile = false
vim.opt.undofile = true

vim.o.winborder = "rounded"
vim.opt.numberwidth = 3
vim.opt.signcolumn = "yes:1"
vim.opt.statuscolumn = "%l %s"
vim.opt.conceallevel = 2
vim.opt.laststatus = 2
vim.opt.listchars = {
  tab = "-->",
  multispace = " ",
  trail = "",
  extends = "⟩",
  precedes = "⟨",
}
vim.opt.background = "dark"
vim.opt.spellfile = {
  vim.fn.stdpath("config") .. "/spell/en.utf-8.add",
  vim.fn.stdpath("config") .. "/spell/pt.utf-8.add",
}

-- fold
vim.o.foldcolumn = "0"
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

-- global
vim.g.mapleader = " "
vim.g.move_key_modifier_visualmode = "S"
vim.g.python_host_prog = vim.fn.system("which python3")
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

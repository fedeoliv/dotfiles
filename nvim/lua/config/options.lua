-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

local opt = vim.opt

-- opt.winbar = "%=%m %f" -- Add file path on the twinbar top right

-- opt.statuscolumn = "%l %r" -- Show both line and relative numbers
opt.statuscolumn = "%r" -- Show relative numbers
opt.conceallevel = 2
opt.laststatus = 2

vim.o.foldcolumn = "1" -- '0' is not bad
vim.o.foldlevel = 99
vim.o.foldlevelstart = 99
vim.o.foldenable = true

vim.opt.listchars = { tab = "-->", multispace = " ", trail = "", extends = "⟩", precedes = "⟨" }

vim.g.move_key_modifier_visualmode = "S"

vim.diagnostic.config({ float = { border = "single" } })

-- Providers
vim.g.python_host_prog = vim.fn.system("which python3")
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

vim.g.tundra_biome = "arctic" -- 'arctic' or 'jungle'
vim.opt.background = "dark"

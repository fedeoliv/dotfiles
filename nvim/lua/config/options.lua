-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

local opt = vim.opt

opt.winbar = "%=%m %f" -- Add file path on the twinbar top right

-- opt.statuscolumn = "%l %r" -- Show both line and relative numbers
opt.statuscolumn = "%r" -- Show relative numbers
opt.conceallevel = 2

vim.g.move_key_modifier_visualmode = "S"

-- Providers
vim.g.python_host_prog = vim.fn.system("which python3")
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0

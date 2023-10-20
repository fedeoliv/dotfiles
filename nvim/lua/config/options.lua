-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

local opt = vim.opt

opt.winbar = "%=%m %f" -- Add file path on the twinbar top right
opt.statuscolumn = "%l %r" -- Show both line and relative numbers

-- vim-move config
vim.g.move_key_modifier_visualmode = "S"
-- vim.g.material_style = "deep ocean"

vim.g.nightflyTransparent = true --transparent mode from nvim-nightly-colors

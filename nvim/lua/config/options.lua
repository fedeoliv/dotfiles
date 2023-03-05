-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt

opt.winbar = "%=%m %f" -- Add file path on the twinbar top right

-- Global variables
vim.g.nightflyTransparent = true --transparent mode from nvim-nightly-colors

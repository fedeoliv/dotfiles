-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

local opt = vim.opt

opt.winbar = "%=%m %f" -- Add file path on the twinbar top right
opt.statuscolumn = "%l %r" -- Show both line and relative numbers

-- Global variables
if vim.g.neovide then
  vim.o.guifont = "MonoLisa Nerd Font:h16"
  vim.opt.linespace = 0

  -- Helper function for transparency formatting
  -- local alpha = function()
  --   return string.format("%x", math.floor(255 * vim.g.transparency or 0.8))
  -- end

  -- transparency
  -- vim.g.neovide_transparency = 0.0
  -- vim.g.transparency = 0.98
  -- vim.g.neovide_background_color = "#0f1117" .. alpha()

  -- blur
  vim.g.neovide_floating_blur_amount_x = 2.0
  vim.g.neovide_floating_blur_amount_y = 2.0

  -- refresh rate
  vim.g.neovide_refresh_rate = 60
  vim.g.neovide_refresh_rate_idle = 5

  -- window size
  vim.g.neovide_remember_window_size = true
  vim.g.neovie_profiler = false

  -- animations
  vim.g.neovide_cursor_animate_in_insert_mode = true
else
  vim.g.nightflyTransparent = true --transparent mode from nvim-nightly-colors
end

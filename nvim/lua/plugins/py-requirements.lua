return {
  "MeanderingProgrammer/py-requirements.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("py-requirements").setup({
      -- Enabled by default if you do not use `nvim-cmp` set to false
      enable_cmp = true,
      -- Specify what file patterns to apply the plugin to, for use with for example pip-tools.
      file_patterns = { "requirements.txt" },
    })
  end,
  ft = { "python" },
}

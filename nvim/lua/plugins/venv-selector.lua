return {
  "linux-cultist/venv-selector.nvim",
  dependencies = { "neovim/nvim-lspconfig", "nvim-telescope/telescope.nvim", "mfussenegger/nvim-dap-python" },
  event = "VeryLazy", -- Optional: needed only if you want to type `:VenvSelect` without a keymapping
  keys = {
    { "<leader>vs", "<cmd>VenvSelect<cr>", desc = "Select Python venv" },
    { "<leader>vc", "<cmd>VenvSelectCached<cr>", desc = "Retrieve Python venv from cache" },
  },
  ft = { "py" },
}

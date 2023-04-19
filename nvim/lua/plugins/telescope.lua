return {
  {
    "telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
    event = "VeryLazy",
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
    event = "VeryLazy",
    config = function()
      require("telescope").setup({
        extensions = {
          file_browser = {
            -- theme = "ivy",
            -- disables netrw and use telescope-file-browser in its place
            hijack_netrw = true,
            -- mappings = {
            --   ["i"] = {
            --     -- your custom insert mode mappings
            --   },
            --   ["n"] = {
            --     -- your custom normal mode mappings
            --   },
            -- },
          },
        },
      })

      require("telescope").load_extension("file_browser")
    end,
  },
}

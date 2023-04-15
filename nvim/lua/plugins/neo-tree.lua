return {
  "nvim-neo-tree/neo-tree.nvim",
  opts = function(_, opts)
    opts.window = {
      position = "right",
      mappings = {
        ["<space>"] = "none",
      },
    }

    opts.filesystem = {
      filtered_items = {
        hide_dotfiles = false,
      },
      follow_current_file = true,
    }

    opts.filters = {
      dotfiles = false,
      custom = { "^.git$" },
    }
  end,
  event = "VeryLazy",
}

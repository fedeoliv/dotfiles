return {
  -- {
  --   "xiyaowong/nvim-transparent",
  --   opts = {
  --     enable = true, -- boolean: enable transparent
  --     extra_groups = { -- table/string: additional groups that should be cleared
  --       -- In particular, when you set it to 'all', that means all available groups
  --
  --       -- example of akinsho/nvim-bufferline.lua
  --       "BufferLineTabClose",
  --       "BufferlineBufferSelected",
  --       "BufferLineFill",
  --       "BufferLineBackground",
  --       "BufferLineSeparator",
  --       "BufferLineIndicatorSelected",
  --     },
  --     exclude = {}, -- table: groups you don't want to clear
  --     ignore_linked_group = true, -- boolean: don't clear a group that links to another group
  --   },
  -- },
  -- Smooth scrolling
  {
    "karb94/neoscroll.nvim",
    event = "VeryLazy",
    opts = {
      -- All these keys will be mapped to their corresponding default scrolling animation
      mappings = { "<C-u>", "<C-d>", "<C-b>", "<C-f>", "<C-y>", "<C-e>", "zt", "zz", "zb" },
      hide_cursor = true, -- Hide cursor while scrolling
      stop_eof = true, -- Stop at <EOF> when scrolling downwards
      respect_scrolloff = false, -- Stop scrolling when the cursor reaches the scrolloff margin of the file
      cursor_scrolls_alone = true, -- The cursor will keep on scrolling even if the window cannot scroll further
      easing_function = nil, -- Default easing function
      pre_hook = nil, -- Function to run before the scrolling animation starts
      post_hook = nil, -- Function to run after the scrolling animation ends
      performance_mode = false, -- Disable "Performance Mode" on all buffers.
    },
  },

  -- Sub-cursor to show current scroll direction
  {
    "gen740/SmoothCursor.nvim",
    event = "VeryLazy",
    config = true,
  },

  -- Tint inactive windows
  {
    "levouh/tint.nvim",
    config = true,
    event = "VeryLazy",
  },

  -- Expand window width with animation
  {
    "anuvyklack/windows.nvim",
    event = "VeryLazy",
    dependencies = {
      "anuvyklack/middleclass",
      "anuvyklack/animation.nvim",
    },
    config = function()
      vim.o.winwidth = 10
      vim.o.winminwidth = 10
      vim.o.equalalways = false
      require("windows").setup()
    end,
  },

  -- Notification manager
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    opts = function(_, opts)
      opts.background_colour = "#000000" -- 100% transparency
    end,
  },

  -- Dim inactive portions of the code while editing using TreeSitter
  {
    "folke/twilight.nvim",
    event = "VeryLazy",
  },

  {
    "shortcuts/no-neck-pain.nvim",
    event = "VeryLazy",
  },
}

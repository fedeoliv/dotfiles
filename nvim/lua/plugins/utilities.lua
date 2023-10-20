return {
  -- Edit filesystem like a buffer
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = {
      view_options = {
        show_hidden = true,
      },
    },
  },
  -- Code snippet
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },

  -- Terminals management
  {
    {
      "akinsho/toggleterm.nvim",

      version = "*",
      event = "VeryLazy",
      opts = {
        open_mapping = [[<c-\>]],
        direction = "float",
        float_opts = {
          border = "curved",
        },
      },
    },
  },

  -- Seamless navigation between tmux panes and vim splits
  {
    "alexghergh/nvim-tmux-navigation",
    event = "VeryLazy",
    config = function()
      local nvim_tmux_nav = require("nvim-tmux-navigation")
      nvim_tmux_nav.setup({
        disable_when_zoomed = true,
        -- defaults to false
        keybindings = {
          left = "<C-h>",
          down = "<C-j>",
          up = "<C-k>",
          right = "<C-l>",
          last_active = "<C-\\>",
          next = "<C-Space>",
        },
      })
    end,
  },

  -- LSP extensions for eclipse jdtls
  {
    "mfussenegger/nvim-jdtls",
    event = "VeryLazy",
  },

  -- Edit Markdown table
  {
    "kiran94/edit-markdown-table.nvim",
    config = function()
      require("edit-markdown-table").setup()
    end,
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    cmd = "EditMarkdownTable",
    event = "VeryLazy",
  },

  -- Note taking
  {
    "nvim-neorg/neorg",
    build = ":Neorg sync-parsers",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("neorg").setup({
        load = {
          ["core.defaults"] = {},
          ["core.concealer"] = {},
          ["core.keybinds"] = {
            config = {
              hook = function(keybinds)
                -- keybinds.remap_event("norg", "n", "<C-Space>", "core.qol.todo_items.todo.task_done")

                keybinds.remap_key("norg", "n", "<C-Space>", "<Leader>")
              end,
            },
          },
          ["core.completion"] = {
            config = {
              engine = "nvim-cmp",
              name = "[Neorg]",
            },
          },
          ["core.dirman"] = {
            config = {
              workspaces = {
                notes = "~/notes",
              },
              default_workspace = "notes",
            },
          },
        },
      })

      vim.wo.foldlevel = 99
      vim.wo.conceallevel = 2
    end,
  },
  {
    "lukas-reineke/headlines.nvim",
    dependencies = "nvim-treesitter/nvim-treesitter",
    opts = {},
  },
}

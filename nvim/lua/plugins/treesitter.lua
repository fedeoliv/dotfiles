return {
  {
    "nvim-treesitter/nvim-treesitter",
    event = { "BufReadPost", "BufNewFile" },
    opts = function(_, opts)
      -- if type(opts.ensure_installed) == "table" then
      --   vim.list_extend(opts.ensure_installed, {
      --     "bash",
      --     "c_sharp",
      --     "dockerfile",
      --     "go",
      --     "hcl",
      --     "help",
      --     "html",
      --     "http",
      --     "java",
      --     "javascript",
      --     "json",
      --     "json5",
      --     "jsonc",
      --     "lua",
      --     "markdown",
      --     "markdown_inline",
      --     "mermaid",
      --     "python",
      --     "query",
      --     "regex",
      --     "sql",
      --     "terraform",
      --     "tsx",
      --     "typescript",
      --     "vim",
      --     "yaml",
      --   })
      -- end
      opts.ensure_installed = {
        "bash",
        "c_sharp",
        "dockerfile",
        "go",
        "hcl",
        "help",
        "html",
        "http",
        "java",
        "javascript",
        "json",
        "lua",
        "markdown",
        "markdown_inline",
        "mermaid",
        "python",
        "query",
        "regex",
        "sql",
        "terraform",
        "tsx",
        "typescript",
        "vim",
        "yaml",
      }

      opts.rainbow = {
        enable = true,
        -- disable = { "jsx", "cpp" },
        -- Which query to use for finding delimiters
        query = "rainbow-parens",
        -- Highlight the entire buffer all at once
        strategy = require("ts-rainbow").strategy.global,
      }
    end,
  },
  {
    "HiPhish/nvim-ts-rainbow2",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
    event = "VeryLazy",
  },
}

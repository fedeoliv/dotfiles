return {
  {
    "williamboman/mason.nvim",
    event = "VeryLazy",
    opts = function(_, opts)
      table.insert(opts.ensure_installed, "prettierd")
      table.insert(opts.ensure_installed, "dockerfile-language-server")
      table.insert(opts.ensure_installed, "pyright")
      table.insert(opts.ensure_installed, "markdownlint")
      table.insert(opts.ensure_installed, "stylua")
      table.insert(opts.ensure_installed, "shfmt")
      table.insert(opts.ensure_installed, "terraform-ls")
      table.insert(opts.ensure_installed, "tflint")
    end,
  },
}

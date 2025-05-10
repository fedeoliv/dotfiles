return {
  "williamboman/mason.nvim",
  opts = {
    ensure_installed = {
      --lua
      "stylua",

      -- python
      "basedpyright",
      "ruff",
      "ruff-lsp",

      --java
      "jdtls",
      "java-debug-adapter",
      "checkstyle",
      "google-java-format",

      -- markdown
      "marksman",

      -- serialization formats
      "yaml-language-server",
      "lemminx",

      -- shell
      "shfmt",
    },
  },
}

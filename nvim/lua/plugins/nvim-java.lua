return {
  "nvim-java/nvim-java",
  config = false,
  event = "VeryLazy",
  ft = { "java" },
  dependencies = {
    {
      "neovim/nvim-lspconfig",
      opts = {
        inlay_hints = { enabled = false },
        servers = {
          -- Your JDTLS configuration goes here
          jdtls = {
            -- settings = {
            --   java = {
            --     configuration = {
            --       runtimes = {
            --         {
            --           name = "JavaSE-23",
            --           path = "/usr/local/sdkman/candidates/java/23-tem",
            --         },
            --       },
            --     },
            --   },
            -- },
          },
        },
        setup = {
          jdtls = function()
            -- Your nvim-java configuration goes here
            require("java").setup({
              root_markers = {
                "settings.gradle",
                "settings.gradle.kts",
                "pom.xml",
                "build.gradle",
                "mvnw",
                "gradlew",
                "build.gradle",
                "build.gradle.kts",
              },
              jdk = {
                auto_install = true,
                version = "21.0.2",
              },
            })
          end,
        },
      },
    },
  },
}

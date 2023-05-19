vim.opt_local.shiftwidth = 2
vim.opt_local.tabstop = 2
vim.opt_local.cmdheight = 2

local home = os.getenv("HOME")
WORKSPACE_PATH = home .. "/workspace/"
CONFIG = "mac"
--
-- local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")
-- local workspace_dir = WORKSPACE_PATH .. project_name
--
-- -- LSP
--
-- local jdtls = require("jdtls")
-- local bundles = {}
--
-- local extendedClientCapabilities = jdtls.extendedClientCapabilities
-- extendedClientCapabilities.resolveAdditionalTextEditsSupport = true
--
-- -- See `:help vim.lsp.start_client` for an overview of the supported `config` options.
-- local config = {
--   -- The command that starts the language server
--   -- See: https://github.com/eclipse/eclipse.jdt.ls#running-from-the-command-line
--   cmd = {
--     "java", -- or '/path/to/java11_or_newer/bin/java'
--
--     "-Declipse.application=org.eclipse.jdt.ls.core.id1",
--     "-Dosgi.bundles.defaultStartLevel=4",
--     "-Declipse.product=org.eclipse.jdt.ls.core.product",
--     "-Dlog.protocol=true",
--     "-Dlog.level=ALL",
--     "-javaagent:" .. home .. "/.local/share/nvim/language-servers/jdtls/lombok.jar",
--     "-Xms1g",
--     "--add-modules=ALL-SYSTEM",
--     "--add-opens",
--     "java.base/java.util=ALL-UNNAMED",
--     "--add-opens",
--     "java.base/java.lang=ALL-UNNAMED",
--
--     -- 💀
--     "-jar",
--     vim.fn.glob(
--       home
--         .. "/.local/share/nvim/language-servers/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar"
--     ),
--
--     "-configuration",
--     home .. "/.local/share/nvim/language-servers/jdtls/config_" .. CONFIG,
--
--     -- See `data directory configuration` section in the README
--     "-data",
--     workspace_dir,
--   },
--   on_attach = require("plugins.lsp.handlers").on_attach,
--   capabilities = require("plugins.lsp.handlers").capabilities,
--
--   -- This is the default if not provided, you can remove it. Or adjust as needed.
--   -- One dedicated LSP server & client will be started per unique root_dir
--   root_dir = require("jdtls.setup").find_root({ ".git", "mvnw", "gradlew", "pom.xml" }),
--
--   -- Here you can configure eclipse.jdt.ls specific settings
--   -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
--   -- or https://github.com/redhat-developer/vscode-java#supported-vs-code-settings
--   -- for a list of options
--   settings = {
--     java = {
--       -- jdt = {
--       --   ls = {
--       --     vmargs = "-XX:+UseParallelGC -XX:GCTimeRatio=4 -XX:AdaptiveSizePolicyWeight=90 -Dsun.zip.disableMemoryMapping=true -Xmx1G     -Xms100m"
--       --   }
--       -- },
--       eclipse = {
--         downloadSources = true,
--       },
--       configuration = {
--         updateBuildConfiguration = "interactive",
--       },
--       maven = {
--         downloadSources = true,
--       },
--       implementationsCodeLens = {
--         enabled = true,
--       },
--       referencesCodeLens = {
--         enabled = true,
--       },
--       references = {
--         includeDecompiledSources = true,
--       },
--       inlayHints = {
--         parameterNames = {
--           enabled = "all", -- literals, all, none
--         },
--       },
--       format = {
--         enabled = false,
--         -- settings = {
--         --   profile = "asdf"
--         -- }
--       },
--     },
--     signatureHelp = { enabled = true },
--     completion = {
--       favoriteStaticMembers = {
--         "org.hamcrest.MatcherAssert.assertThat",
--         "org.hamcrest.Matchers.*",
--         "org.hamcrest.CoreMatchers.*",
--         "org.junit.jupiter.api.Assertions.*",
--         "java.util.Objects.requireNonNull",
--         "java.util.Objects.requireNonNullElse",
--         "org.mockito.Mockito.*",
--       },
--     },
--     contentProvider = { preferred = "fernflower" },
--     extendedClientCapabilities = extendedClientCapabilities,
--     sources = {
--       organizeImports = {
--         starThreshold = 9999,
--         staticStarThreshold = 9999,
--       },
--     },
--     codeGeneration = {
--       toString = {
--         template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
--       },
--       useBlocks = true,
--     },
--   },
--
--   -- Language server `initializationOptions`
--   -- You need to extend the `bundles` with paths to jar files
--   -- if you want to use additional eclipse.jdt.ls plugins.
--   --
--   -- See https://github.com/mfussenegger/nvim-jdtls#java-debug-installation
--   --
--   -- If you don't plan on using the debugger or other eclipse.jdt.ls plugins you can remove this
--   init_options = {
--     bundles = bundles,
--   },
-- }
--
-- -- This starts a new client & server,
-- -- or attaches to an existing client & server depending on the `root_dir`.
-- jdtls.start_or_attach(config)

local status_ok, jdtls = pcall(require, "jdtls")
if not status_ok then
  return
end

local jdtls_path = vim.fn.stdpath("data") .. "/mason/packages/jdtls/"
local install_path = require("mason-registry").get_package("jdtls"):get_install_path()
local equinox_version = "1.6.400.v20210924-0641"

-- WORKSPACE_PATH = vim.fn.stdpath("data") .. "/workspace/"
if vim.fn.has("mac") == 1 then
  OS_NAME = "mac"
elseif vim.fn.has("unix") == 1 then
  OS_NAME = "linux"
elseif vim.fn.has("win32") == 1 then
  OS_NAME = "win"
else
  vim.notify("Unsupported OS", vim.log.levels.WARN, { title = "Jdtls" })
end

local root_markers = { ".git", "mvnw", "gradlew", "pom.xml", "build.gradle" }

local project_name = vim.fn.fnamemodify(vim.fn.getcwd(), ":p:h:t")

local workspace_dir = WORKSPACE_PATH .. project_name

local config = {
  cmd = {
    -- 💀
    "java", -- or '/path/to/java17_or_newer/bin/java'
    -- depends on if `java` is in your $PATH env variable and if it points to the right version.

    "-Declipse.application=org.eclipse.jdt.ls.core.id1",
    "-Dosgi.bundles.defaultStartLevel=4",
    "-Declipse.product=org.eclipse.jdt.ls.core.product",
    "-Dlog.protocol=true",
    "-Dlog.level=ALL",
    "-javaagent:" .. install_path .. "/lombok.jar",
    "-Xms1g",
    "--add-modules=ALL-SYSTEM",
    "--add-opens",
    "java.base/java.util=ALL-UNNAMED",
    "--add-opens",
    "java.base/java.lang=ALL-UNNAMED",
    -- 💀
    "-jar",
    vim.fn.glob(
      home
        .. "/.local/share/nvim/language-servers/jdtls/plugins/org.eclipse.equinox.launcher_1.6.400.v20210924-0641.jar"
    ),
    -- jdtls_path .. "plugins/org.eclipse.equinox.launcher_" .. equinox_version .. ".jar",
    -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^                                       ^^^^^^^^^^^^^^
    -- Must point to the                                                     Change this to
    -- eclipse.jdt.ls installation                                           the actual version
    -- 💀
    "-configuration",
    home .. "/.local/share/nvim/language-servers/jdtls/config_" .. CONFIG,
    -- ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^        ^^^^^^
    -- Must point to the                      Change to one of `linux`, `win` or `mac`
    -- eclipse.jdt.ls installation            Depending on your system.

    "-data",
    workspace_dir,
  },
  on_attach = require("plugins.lsp.handlers").on_attach,
  capabilities = require("plugins.lsp.handlers").capabilities,

  -- 💀
  -- This is the default if not provided, you can remove it. Or adjust as needed.
  -- One dedicated LSP server & client will be started per unique root_dir
  root_dir = require("jdtls.setup").find_root(root_markers),
}

-- local keymap = vim.keymap.set
--
-- keymap("n", "A-o", ":lua require'jdtls'.organize_imports()<cr>", { silent = true })
-- keymap("n", "crv", ":lua require'jdtls'.extract_variable()<cr>", { silent = true })
-- keymap("v", "crv", "<Esc>:lua require'jdtls'.extract_variable(true)<cr>", { silent = true })
-- keymap("n", "crc", ":lua require'jdtls'.extract_constant()<cr>", { silent = true })
-- keymap("v", "crc", "<Esc>:lua require'jdtls'.extract_constant(true)<cr>", { silent = true })
-- keymap("v", "crm", "<Esc>:lua require'jdtls'.extract_method(true)<cr>", { silent = true })
--
-- vim.cmd([[
-- command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_compile JdtCompile lua require('jdtls').compile(<f-args>)
-- command! -buffer -nargs=? -complete=custom,v:lua.require'jdtls'._complete_set_runtime JdtSetRuntime lua require('jdtls').set_runtime(<f-args>)
-- command! -buffer JdtUpdateConfig lua require('jdtls').update_project_config()
-- command! -buffer JdtJol lua require('jdtls').jol()
-- command! -buffer JdtBytecode lua require('jdtls').javap()
-- command! -buffer JdtJshell lua require('jdtls').jshell()
-- ]])

-- This starts a new client & server,
-- or attaches to an existing client & server depending on the `root_dir`.
jdtls.start_or_attach(config)

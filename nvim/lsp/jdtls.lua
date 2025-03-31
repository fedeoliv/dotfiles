local handlers = require("vim.lsp.handlers")

local env = {
  HOME = vim.loop.os_homedir(),
  XDG_CACHE_HOME = os.getenv("XDG_CACHE_HOME"),
  JDTLS_JVM_ARGS = os.getenv("JDTLS_JVM_ARGS"),
}

local function get_cache_dir()
  return env.XDG_CACHE_HOME and env.XDG_CACHE_HOME or env.HOME .. "/.cache"
end

local function get_jdtls_cache_dir()
  return get_cache_dir() .. "/jdtls"
end

local function get_jdtls_config_dir()
  return get_jdtls_cache_dir() .. "/config"
end

local function get_jdtls_workspace_dir()
  return get_jdtls_cache_dir() .. "/workspace"
end

local function get_jdtls_jvm_args()
  local args = {}
  for a in string.gmatch((env.JDTLS_JVM_ARGS or ""), "%S+") do
    local arg = string.format("--jvm-arg=%s", a)
    table.insert(args, arg)
  end
  return unpack(args)
end

local function on_textdocument_codeaction(err, actions, ctx)
  for _, action in ipairs(actions) do
    if action.command == "java.apply.workspaceEdit" then -- 'action' is Command in java format
      action.edit = fix_zero_version(action.edit or action.arguments[1])
    elseif type(action.command) == "table" and action.command.command == "java.apply.workspaceEdit" then -- 'action' is CodeAction in java format
      action.edit = fix_zero_version(action.edit or action.command.arguments[1])
    end
  end

  handlers[ctx.method](err, actions, ctx)
end

local function on_textdocument_rename(err, workspace_edit, ctx)
  handlers[ctx.method](err, fix_zero_version(workspace_edit), ctx)
end

local function on_workspace_applyedit(err, workspace_edit, ctx)
  handlers[ctx.method](err, fix_zero_version(workspace_edit), ctx)
end

-- Non-standard notification that can be used to display progress
local function on_language_status(_, result)
  local command = vim.api.nvim_command
  command("echohl ModeMsg")
  command(string.format('echo "%s"', result.message))
  command("echohl None")
end

return {
  cmd = {
    "jdtls",
    "-configuration",
    get_jdtls_config_dir(),
    "-data",
    get_jdtls_workspace_dir(),
    get_jdtls_jvm_args(),
  },
  filetypes = { "java" },
  root_markers = {
    "build.xml", -- Ant
    "pom.xml", -- Maven
    "mvnw", -- Maven
    "gradlew", -- Gradle
    "settings.gradle", -- Gradle
    "settings.gradle.kts", -- Gradle
  },
  single_file_support = true,
  init_options = {
    workspace = get_jdtls_workspace_dir(),
    jvm_args = {},
    os_config = nil,
  },
  handlers = {
    -- Due to an invalid protocol implementation in the jdtls we have to conform these to be spec compliant.
    -- https://github.com/eclipse/eclipse.jdt.ls/issues/376
    ["textDocument/codeAction"] = on_textdocument_codeaction,
    ["textDocument/rename"] = on_textdocument_rename,
    ["workspace/applyEdit"] = on_workspace_applyedit,
    ["language/status"] = vim.schedule_wrap(on_language_status),
  },
}

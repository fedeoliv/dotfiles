require "mason".setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗"
		}
	}
})


local language_servers = {
	"lua_ls",

	-- go
	"gopls",
	"golangci_lint_ls",

	-- typescript
	"ts_ls",

	-- python
	"basedpyright",
	"ruff",

	-- markdown
	"marksman",

	-- swift
	"sourcekit", -- not in mason-lspconfig

	-- xml
	"lemminx",
}

-- Additional tools: formatters, linters, etc.
local extra_tools = {
	"stylua",
	"goimports",
	"gci",
	"gofumpt"
}

local mlsp = require("mason-lspconfig")
local mason_supported = mlsp.get_available_servers()

local mason_supported_servers = vim.tbl_filter(function(server)
	return vim.tbl_contains(mason_supported, server)
end, language_servers)

mlsp.setup({
	ensure_installed = mason_supported_servers,
})

-- install formatters and linters via mason registry
local registry = require("mason-registry")

for _, tool in ipairs(extra_tools) do
	local ok, pkg = pcall(registry.get_package, tool)
	if not ok then
		vim.notify("Mason: Tool not found in registry: " .. tool, vim.log.levels.WARN)
	else
		if not pkg:is_installed() then
			vim.notify("Mason: Installing " .. tool .. "...", vim.log.levels.INFO)

			pkg:install():once("closed", function()
				if pkg:is_installed() then
					vim.notify("Mason: Successfully installed " .. tool, vim.log.levels.INFO)
				else
					vim.notify("Mason: Failed to install " .. tool, vim.log.levels.ERROR)
				end
			end)
		end
	end
end

vim.lsp.enable(language_servers)

vim.lsp.config('lua_ls', {
	on_init = function(client)
		if client.workspace_folders then
			local path = client.workspace_folders[1].name
			if
			    path ~= vim.fn.stdpath('config')
			    and (vim.uv.fs_stat(path .. '/.luarc.json') or vim.uv.fs_stat(path .. '/.luarc.jsonc'))
			then
				return
			end
		end

		client.config.settings.Lua = vim.tbl_deep_extend('force', client.config.settings.Lua, {
			runtime = {
				version = 'LuaJIT',
				path = {
					'lua/?.lua',
					'lua/?/init.lua',
				},
			},
			-- Make the server aware of Neovim runtime files
			workspace = {
				checkThirdParty = false,
				library = {
					vim.env.VIMRUNTIME
				}
			}
		})
	end,
	settings = {
		Lua = {}
	}
})

vim.api.nvim_create_autocmd('LspAttach', {
	callback = function(args)
		local client = assert(vim.lsp.get_client_by_id(args.data.client_id))

		if client:supports_method('textDocument/completion') then
			-- Optional: trigger autocompletion on EVERY keypress. May be slow!
			local chars = {}; for i = 32, 126 do table.insert(chars, string.char(i)) end

			client.server_capabilities.completionProvider.triggerCharacters = chars
			vim.lsp.completion.enable(true, client.id, args.buf, { autotrigger = true })
		end
	end,
})

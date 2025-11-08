-- TODO:
-- - git stuff
-- - diagnostics
require "config.options"
require "config.keymaps"
require "config.autocmds"

-- diagnostics
vim.diagnostic.config({
	float = { border = "single" },
	virtual_text = true,
})

vim.pack.add({
	-- core plugins
	{ src = "https://github.com/vague2k/vague.nvim" },
	{ src = "https://github.com/stevearc/oil.nvim" },
	{ src = "https://github.com/alexghergh/nvim-tmux-navigation", version = "main" },
	{ src = "https://github.com/nvim-mini/mini.surround" },
	{ src = "https://github.com/nvim-mini/mini.pairs" },
	{
		src = "https://github.com/nvim-treesitter/nvim-treesitter",
		version = "main",
		data = {
			run = function()
				vim.cmd("TSUpdate")
			end,
		},
	},
	-- picker
	{ src = "https://github.com/nvim-mini/mini.pick" },

	-- motions
	{ src = "https://github.com/nvim-mini/mini.move" },
	{ src = "https://github.com/chrisgrieser/nvim-spider" },

	-- lsp
	-- TODO: integrate mason with mason-lspconfig to auto install LSPs.
	-- vim.pack currently doesn't support dependencies.
	-- I don't wanna install another dependency as a workaround (e.g. plenary)
	{ src = "https://github.com/mason-org/mason.nvim" },

	-- completion
	-- TODO: integrate colorful-menu with blink or nvim-cmp
	{ src = "https://github.com/xzbdmw/colorful-menu.nvim" },

	-- aesthetics
	{ src = "https://github.com/sphamba/smear-cursor.nvim" },
	{ src = "https://github.com/karb94/neoscroll.nvim" },

	{ src = "https://github.com/nat-418/boole.nvim" }
})

vim.cmd("colorscheme vague")
vim.cmd [[set completeopt+=menuone,noselect,popup]]

require "config.lsp"

require("oil").setup({
	default_file_explorer = true,
	view_options = {
		show_hidden = true,
	},
	lsp_file_methods = {
		enabled = true,
		timeout_ms = 1000,
		autosave_changes = true,
	},
	float = {
		max_width = 0.7,
		max_height = 0.6,
		border = "rounded",
	},
})

local treesitter = require("nvim-treesitter")
local treesitter_packages = {
  "bash",
  "c",
  "comment", -- TODOs etc
  "ecma",
  "gitcommit",
  "gitignore",
  "go",
  "gomod",
  "gosum",
  "html",
  "html_tags",
  "javascript",
  "json",
  "jsx",
  "latex",
  "lua",
  "luadoc",
  "luap",
  "markdown",
  "markdown_inline",
  "matlab",
  "python",
  "query",
  "sql",
  "ssh_config",
  "todotxt",
  "todotxt",
  "toml",
  "typescript",
  "typescript",
  "typst",
  "vim",
  "vimdoc",
  "yaml"
}

-- Only install parsers that are missing
local to_install = {}
for _, lang in ipairs(treesitter_packages) do
  if not pcall(vim.treesitter.language.add, lang) then
    table.insert(to_install, lang)
  end
end

if #to_install > 0 then
  treesitter.install(to_install)
end

vim.treesitter.language.register("yaml", "yaml.docker-compose")
vim.treesitter.language.register("yaml", "yaml.github-action")
vim.api.nvim_create_autocmd("FileType", {
  pattern = treesitter_packages,
  callback = function() vim.treesitter.start() end,
})

require("nvim-tmux-navigation").setup({
	disable_when_zoomed = true,
})

-- motions
require('mini.move').setup({
	mappings = {
		-- move visual selection in Visual mode
		left = 'H',
		right = 'L',
		down = 'J',
		up = 'K',
	},
})
require("spider").setup {
	skipInsignificantPunctuation = true,
	consistentOperatorPending = false,
	subwordMovement = true,
	customPatterns = {},
}

require('mini.pick').setup()
require('mini.surround').setup()
require('mini.pairs').setup()

-- completion
require("colorful-menu").setup()

-- aesthetics
require('smear_cursor').setup()
require('neoscroll').setup()

require('boole').setup({
	mappings = {
		increment = '<C-a>',
		decrement = '<C-x>'
	},
	-- User defined loops
	additions = {},
	allow_caps_additions = {
		{ 'enable', 'disable' }
	}
})

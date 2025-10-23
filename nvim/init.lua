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
	{ src = "https://github.com/nvim-mini/mini.pick" },
	{ src = "https://github.com/nvim-mini/mini.surround" },
	{ src = "https://github.com/nvim-mini/mini.pairs" },
	{ src = "https://github.com/chrisgrieser/nvim-spider" },
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },

	-- lsp
	-- TODO: integrate mason with mason-lspconfig to auto install LSPs.
	-- vim.pack currently doesn't support dependencies.
	-- I don't wanna install another dependency as a workaround (e.g. plenary)
	{ src = "https://github.com/mason-org/mason.nvim" },

	-- animations
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

require("nvim-tmux-navigation").setup({
	disable_when_zoomed = true,
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

-- animations
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

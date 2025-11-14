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
	{ src = "https://github.com/vim-scripts/ReplaceWithRegister" },
	{ src = "https://github.com/iamcco/markdown-preview.nvim" },

	-- lsp
	-- TODO: integrate mason with mason-lspconfig to auto install LSPs.
	-- vim.pack currently doesn't support dependencies.
	-- I don't wanna install another dependency as a workaround (e.g. plenary)
	{ src = "https://github.com/mason-org/mason.nvim" },

	-- completion
	-- TODO: integrate colorful-menu with blink or nvim-cmp
	{ src = "https://github.com/xzbdmw/colorful-menu.nvim" },

	--git
	{ src = "https://github.com/lewis6991/gitsigns.nvim" },

	-- aesthetics
	{ src = "https://github.com/karb94/neoscroll.nvim" },
	{ src = "https://github.com/sphamba/smear-cursor.nvim" },

	--others
	{ src = "https://github.com/sitiom/nvim-numbertoggle" },
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

--git
require('gitsigns').setup({
	signs = {
		add = { text = "▎" },
		change = { text = "▎" },
		delete = { text = "" },
		topdelete = { text = "" },
		changedelete = { text = "▎" },
		untracked = { text = "▎" },
	},
	signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
	numhl = true,       -- Toggle with `:Gitsigns toggle_numhl`
	linehl = false,     -- Toggle with `:Gitsigns toggle_linehl`
	word_diff = false,  -- Toggle with `:Gitsigns toggle_word_diff`
	current_line_blame = true, -- Toggle with `:Gitsigns toggle_current_line_blame`
	current_line_blame_opts = {
		virt_text = true,
		virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
		delay = 1000,
		ignore_whitespace = false,
		virt_text_priority = 100,
	},
	watch_gitdir = {
		follow_files = true,
	},
	on_attach = function(buffer)
		local gs = package.loaded.gitsigns

		local function map(mode, l, r, desc)
			vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
		end

		-- stylua: ignore start
		map("n", "<leader>gp", gs.preview_hunk, "Preview hunk")
		map("n", "]h", gs.next_hunk, "Next Hunk")
		map("n", "[h", gs.prev_hunk, "Prev Hunk")
		map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
		map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
		map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
		map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
		map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
		map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
		map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
		map("n", "<leader>ghd", gs.diffthis, "Diff This")
		map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
		map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
	end,
})

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

-- markdown-preview
vim.fn["mkdp#util#install"]()
vim.g.mkdp_filetypes = { "markdown" }

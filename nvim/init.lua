vim.loader.enable()

-- TODO:
-- - git stuff
-- - diagnostics
require "config.options"
require "config.keymaps"
require "config.autocmds"

-- diagnostics
vim.diagnostic.config({
	virtual_text = {
		prefix = "●", -- can be a string or a function
		spacing = 2,
	},
	severity_sort = true,
	float = {
		border = "rounded",
		header = '',
	}
})

-- hooks must be defined before vim.pack.add()
vim.api.nvim_create_autocmd("PackChanged", {
	callback = function(ev)
		local name, kind = ev.data.spec.name, ev.data.kind
		if name == "nvim-treesitter" and kind == "update" then
			if not ev.data.active then vim.cmd.packadd("nvim-treesitter") end
			vim.cmd("TSUpdate")
		end
	end
})

vim.pack.add({
	-- core plugins
	"https://github.com/vague2k/vague.nvim",
	{ src = "https://github.com/alexghergh/nvim-tmux-navigation", version = "main" },
	"https://github.com/nvim-mini/mini.surround",
	"https://github.com/nvim-mini/mini.pairs",
	{ src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },

	-- picker
	"https://github.com/ibhagwan/fzf-lua",
	"https://github.com/elanmed/fzf-lua-frecency.nvim",

	-- motions
	"https://github.com/nvim-mini/mini.move",
	"https://github.com/chrisgrieser/nvim-spider",
	"https://github.com/iamcco/markdown-preview.nvim",

	-- lsp
	"https://github.com/mason-org/mason.nvim",
	"https://github.com/mason-org/mason-lspconfig.nvim",

	-- completion
	-- TODO: integrate colorful-menu with blink or nvim-cmp
	"https://github.com/xzbdmw/colorful-menu.nvim",

	-- git
	"https://github.com/lewis6991/gitsigns.nvim",
	"https://github.com/MunifTanjim/nui.nvim",
	"https://github.com/CoreyKaylor/diffbandit.nvim",

	-- aesthetics
	"https://github.com/karb94/neoscroll.nvim",
	"https://github.com/sphamba/smear-cursor.nvim",

	-- others
	"https://github.com/sitiom/nvim-numbertoggle",
	"https://github.com/nat-418/boole.nvim",
})

vim.cmd("colorscheme vague")

require "config.lsp"
require "config.treesitter"

require("nvim-tmux-navigation").setup({
	disable_when_zoomed = true,
})

-- picker
require("fzf-lua").setup({
	defaults = {
		file_icons = false,
	},
})

require('fzf-lua-frecency').setup()

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

-- require('mini.pick').setup()
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
			vim.keymap.set(mode, l, r, { buf = buffer, desc = desc })
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

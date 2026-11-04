local treesitter = require("nvim-treesitter")
local treesitter_packages = {
	"bash",
	"c",
	"comment", -- TODOs etc
	"gitignore",
	"go",
	"gomod",
	"gosum",
	"html",
	"html_tags",
	"javascript",
	"json",
	"jsx",
	"lua",
	"luadoc",
	"luap",
	"markdown",
	"markdown_inline",
	"python",
	"ssh_config",
	"toml",
	"typescript",
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
	callback = function()
		pcall(vim.treesitter.start)
	end,
})

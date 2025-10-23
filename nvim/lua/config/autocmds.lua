-- automated bullet lists 
vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		vim.opt_local.formatoptions:append("r") -- `<CR>` in insert mode
		vim.opt_local.formatoptions:append("o") -- `o` in normal mode
		vim.opt_local.comments = {
			"b:- [ ]",        -- tasks
			"b:- [x]",
			"b:*",            -- unordered list
			"b:-",
			"b:+",
		}
	end,
})

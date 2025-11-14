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

-- markdown preview
local function notify_done(msg)
	vim.schedule(function()
		vim.notify(msg, vim.log.levels.INFO)
	end)
end

local function install_and_build(path)
	vim.notify("Installing and building markdown-preview.nvim...")
	vim.system({ "yarn", "install" }, { cwd = path }, function()
		notify_done("markdown-preview yarn install done")
		vim.system({ "yarn", "run", "build" }, { cwd = path }, function()
			notify_done("markdown-preview yarn run build done")
		end)
	end)
end

vim.api.nvim_create_autocmd({ "PackChanged" }, {
	group = vim.api.nvim_create_augroup("MarkdownPreviewUpdated", { clear = true }),
	callback = function(args)
		local data = args.data
		if data.spec and data.spec.name == "markdown-preview.nvim" then
			if data.kind == "update" or data.kind == "install" then
				install_and_build(data.path)
			end
		end
	end,
})

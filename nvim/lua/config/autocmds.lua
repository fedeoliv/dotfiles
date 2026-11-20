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

-- dim files ignored by git in directory browser
local gitignored_ns = vim.api.nvim_create_namespace("directory_gitignored")

vim.api.nvim_set_hl(0, "DirectoryIgnored", {
	link = "Dimmed",
	default = true,
})

vim.api.nvim_create_autocmd("User", {
	pattern = "DirReadPost",
	callback = function(args)
		local buf = args.buf
		local dir = vim.api.nvim_buf_get_name(buf)
		local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, true)

		vim.api.nvim_buf_clear_namespace(buf, gitignored_ns, 0, -1)

		local result = vim.system({
			"git",
			"-C",
			dir,
			"check-ignore",
			"--stdin",
			"-z",
		}, {
			stdin = table.concat(lines, "\0") .. "\0",
		}):wait()

		-- No matches returns 1; other non-zero results mean git cannot inspect this directory.
		if result.code ~= 0 and result.code ~= 1 then
			return
		end

		local ignored = {}
		for _, name in ipairs(vim.split(result.stdout or "", "\0", {
			plain = true,
			trimempty = true,
		})) do
			ignored[name:gsub("/$", "")] = true
		end

		for row, line in ipairs(lines) do
			if ignored[line:gsub("/$", "")] then
				vim.api.nvim_buf_set_extmark(buf, gitignored_ns, row - 1, 0, {
					end_col = #line,
					hl_group = "DirectoryIgnored",
					priority = 110,
				})
			end
		end
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "directory",
	callback = function(args)
		local preview = require("config.dir.preview")
		vim.api.nvim_create_autocmd({ "CursorMoved", "BufWinLeave", "BufWipeout" }, {
			buf = args.buf,
			callback = function(event)
				if event.event ~= "CursorMoved" then
					preview.close(args.buf)
					return
				end
				preview.update(args.buf)
			end,
		})
	end,
})

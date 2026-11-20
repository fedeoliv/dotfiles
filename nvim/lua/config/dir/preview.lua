local M = {}
local previews = {}

function M.close(source_buf)
	local preview = previews[source_buf]
	if preview and vim.api.nvim_win_is_valid(preview.win) then
		vim.api.nvim_win_close(preview.win, true)
	end
	previews[source_buf] = nil
end

function M.update(source_buf)
	local preview = previews[source_buf]
	if not preview or not vim.api.nvim_win_is_valid(preview.win) then
		return
	end

	local dir = vim.api.nvim_buf_get_name(source_buf)
	local entry = vim.api.nvim_get_current_line():gsub("/$", "")
	local path = vim.fs.joinpath(dir, entry)
	local stat = vim.uv.fs_stat(path)
	local lines = {}

	if stat and stat.type == "file" then
		if stat.size <= 1024 * 1024 then
			lines = vim.fn.readfile(path, "", 300)
		else
			lines = { "[file too large to preview]" }
		end
	else
		lines = { "[no file preview]" }
	end

	vim.bo[preview.buf].modifiable = true
	vim.api.nvim_buf_set_lines(preview.buf, 0, -1, false, lines)
	vim.bo[preview.buf].modifiable = false
	vim.bo[preview.buf].filetype = vim.filetype.match({
		buf = preview.buf,
		filename = path,
	}) or ""
end

function M.toggle(source_buf)
	local current_preview = previews[source_buf]
	if current_preview and vim.api.nvim_win_is_valid(current_preview.win) then
		M.close(source_buf)
		return
	end
	previews[source_buf] = nil

	local preview_buf = vim.api.nvim_create_buf(false, true)
	local width = math.min(50, math.max(10, vim.o.columns - 10))
	local height = math.min(
		math.max(5, vim.o.lines - 6),
		math.max(1, vim.o.lines - 2)
	)
	local preview_win = vim.api.nvim_open_win(preview_buf, false, {
		relative = "editor",
		col = vim.o.columns - width - 2,
		row = 1,
		width = width,
		height = height,
		border = "rounded",
		style = "minimal",
		noautocmd = true,
	})

	vim.bo[preview_buf].buftype = "nofile"
	vim.bo[preview_buf].bufhidden = "wipe"
	vim.bo[preview_buf].swapfile = false
	vim.wo[preview_win].wrap = false

	previews[source_buf] = {
		buf = preview_buf,
		win = preview_win,
	}
	M.update(source_buf)
end

return M

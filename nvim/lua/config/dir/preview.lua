local M = {}
local previews = {}
local tty_path
local winsize_ready = false

local defaults = {
	keymap = "<C-p>", -- set to false to disable default directory keymap
	window = {
		max_width = 50,
		min_width = 10,
		min_height = 5,
		row = 1,
		margin_right = 2,
		margin_bottom = 6,
		border = "rounded",
		wrap = false,
	},
	text = {
		max_size = 1024 * 1024,
		max_lines = 300,
	},
	image = {
		enabled = true,
		max_size = 20 * 1024 * 1024,
		max_scale = 2,
		pad_x = 2,
		pad_y = 1,
		zindex = 49,
		fallback_cell_pixels = { width = 10, height = 22 },
	},
}

M.config = vim.deepcopy(defaults)

local function png_size(data)
	if data:sub(1, 8) ~= "\137PNG\r\n\26\n" or data:byte(13) ~= 0x49 or data:byte(14) ~= 0x48 then
		return
	end

	local function u32(offset)
		return data:byte(offset) * 0x1000000
			+ data:byte(offset + 1) * 0x10000
			+ data:byte(offset + 2) * 0x100
			+ data:byte(offset + 3)
	end

	local width, height = u32(17), u32(21)
	if width > 0 and height > 0 then
		return width, height
	end
end

local function resolve_tty()
	if tty_path ~= nil then
		return tty_path or nil
	end

	if vim.env.TMUX then
		local cmd = { "tmux", "display-message", "-p", "#{pane_tty}" }
		if vim.env.TMUX_PANE then
			table.insert(cmd, 3, "-t")
			table.insert(cmd, 4, vim.env.TMUX_PANE)
		end
		local res = vim.system(cmd, { text = true }):wait()
		local path = res.code == 0 and vim.trim(res.stdout or "") or ""
		if path ~= "" then
			tty_path = path
			return tty_path
		end
	end

	local ok_proc, proc = pcall(vim.api.nvim_get_proc, vim.fn.getpid())
	if ok_proc and proc and proc.ppid then
		local res = vim.system({ "ps", "-o", "tty=", "-p", tostring(proc.ppid) }, { text = true }):wait()
		local name = res.code == 0 and vim.trim(res.stdout or "") or ""
		if name ~= "" and name ~= "??" and name ~= "?" then
			tty_path = name:sub(1, 5) == "/dev/" and name or ("/dev/" .. name)
			return tty_path
		end
	end

	tty_path = false
end

local function cell_pixel_size()
	local ok, ffi = pcall(require, "ffi")
	local path = ok and resolve_tty() or nil
	if path then
		if not winsize_ready then
			pcall(
				ffi.cdef,
				[[
				struct nvim_preview_winsize {
					unsigned short ws_row;
					unsigned short ws_col;
					unsigned short ws_xpixel;
					unsigned short ws_ypixel;
				};
				int ioctl(int fd, unsigned long req, ...);
				int open(const char *path, int oflag);
				int close(int fd);
			]]
			)
			winsize_ready = true
		end

		local fd = ffi.C.open(path, 0)
		if fd >= 0 then
			local ws = ffi.new("struct nvim_preview_winsize[1]")
			local req = jit.os == "OSX" and 0x40087468 or 0x5413
			local rc = ffi.C.ioctl(fd, req, ws)
			ffi.C.close(fd)
			if rc == 0 and ws[0].ws_col > 0 and ws[0].ws_row > 0 and ws[0].ws_xpixel > 0 and ws[0].ws_ypixel > 0 then
				return ws[0].ws_xpixel / ws[0].ws_col, ws[0].ws_ypixel / ws[0].ws_row
			end
		end
	end

	local fallback = M.config.image.fallback_cell_pixels
	return fallback.width, fallback.height
end

local function float_config()
	local win_cfg = M.config.window
	local width = math.min(win_cfg.max_width, math.max(win_cfg.min_width, vim.o.columns - 10))
	local height = math.min(
		math.max(win_cfg.min_height, vim.o.lines - win_cfg.margin_bottom),
		math.max(1, vim.o.lines - 2)
	)
	return {
		relative = "editor",
		col = math.max(0, vim.o.columns - width - win_cfg.margin_right),
		row = win_cfg.row,
		width = width,
		height = height,
	}
end

local function clear_image(preview)
	if preview.image then
		vim.ui.img.del(preview.image)
		preview.image = nil
	end
end

function M.close(source_buf)
	local preview = previews[source_buf]
	if preview then
		clear_image(preview)
		if vim.api.nvim_win_is_valid(preview.win) then
			vim.api.nvim_win_close(preview.win, true)
		end
	end
	previews[source_buf] = nil
end

function M.resize(source_buf)
	local preview = previews[source_buf]
	if not preview or not vim.api.nvim_win_is_valid(preview.win) then
		return
	end

	vim.api.nvim_win_set_config(preview.win, float_config())
	M.update(source_buf)
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

	clear_image(preview)
	preview.path = path

	local img_cfg = M.config.image
	local txt_cfg = M.config.text

	-- Neovim 0.13's experimental vim.ui.img currently supports PNG images only.
	if stat and stat.type == "file" and path:lower():match("%.png$") then
		if not img_cfg.enabled then
			lines = { "[image preview disabled]" }
		elseif stat.size <= img_cfg.max_size then
			local data = vim.fn.readblob(path)
			local image_width, image_height = png_size(data)
			if not image_width then
				lines = { "[invalid PNG image]" }
			else
				vim.schedule(function()
					if
						previews[source_buf] ~= preview
						or preview.path ~= path
						or not vim.api.nvim_win_is_valid(preview.win)
					then
						return
					end

					vim.cmd.redraw()
					local pos = vim.fn.screenpos(preview.win, 1, 1)
					if pos.row <= 0 or pos.col <= 0 then
						return
					end

					local win_width = vim.api.nvim_win_get_width(preview.win)
					local win_height = vim.api.nvim_win_get_height(preview.win)
					local pad_x = math.min(img_cfg.pad_x, math.floor((win_width - 1) / 2))
					local pad_y = math.min(img_cfg.pad_y, math.floor((win_height - 1) / 2))
					local max_cols = math.max(1, win_width - pad_x * 2)
					local max_rows = math.max(1, win_height - pad_y * 2)
					local cell_w, cell_h = cell_pixel_size()

					-- WezTerm stretches when both width and height are set, so fit using real cell pixel dimensions.
					local scale = math.min(
						img_cfg.max_scale,
						(max_cols * cell_w) / image_width,
						(max_rows * cell_h) / image_height
					)
					local width = math.max(1, math.min(max_cols, math.floor((image_width * scale) / cell_w + 0.5)))
					local height = math.max(1, math.min(max_rows, math.floor((image_height * scale) / cell_h + 0.5)))

					preview.image = vim.ui.img.set(data, {
						row = pos.row + math.floor((win_height - height) / 2),
						col = pos.col + math.floor((win_width - width) / 2),
						width = width,
						height = height,
						zindex = img_cfg.zindex,
					})
				end)
			end
		else
			lines = { "[image too large to preview]" }
		end
	elseif stat and stat.type == "file" then
		if stat.size <= txt_cfg.max_size then
			lines = vim.fn.readfile(path, "", txt_cfg.max_lines)
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
	local preview_win = vim.api.nvim_open_win(
		preview_buf,
		false,
		vim.tbl_extend("force", float_config(), {
			border = M.config.window.border,
			style = "minimal",
			noautocmd = true,
		})
	)

	vim.bo[preview_buf].buftype = "nofile"
	vim.bo[preview_buf].bufhidden = "wipe"
	vim.bo[preview_buf].swapfile = false
	vim.wo[preview_win].wrap = M.config.window.wrap
	vim.wo[preview_win].winbar = ""

	previews[source_buf] = {
		buf = preview_buf,
		win = preview_win,
	}
	M.update(source_buf)
end

function M.setup(opts)
	M.config = vim.tbl_deep_extend("force", vim.deepcopy(defaults), opts or {})

	local group = vim.api.nvim_create_augroup("DirPreview", { clear = true })
	local function attach(buf)
		if M.config.keymap then
			vim.keymap.set("n", M.config.keymap, function()
				M.toggle(buf)
			end, {
				buf = buf,
				desc = "Toggle file preview",
			})
		end

		vim.api.nvim_create_autocmd({ "CursorMoved", "VimResized", "BufWinLeave", "BufWipeout" }, {
			group = group,
			buf = buf,
			callback = function(event)
				if event.event == "VimResized" then
					M.resize(buf)
				elseif event.event == "CursorMoved" then
					M.update(buf)
				else
					M.close(buf)
				end
			end,
		})
	end

	vim.api.nvim_create_autocmd("FileType", {
		group = group,
		pattern = "directory",
		callback = function(args)
			attach(args.buf)
		end,
	})

	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(buf) and vim.bo[buf].filetype == "directory" then
			attach(buf)
		end
	end
end

return M

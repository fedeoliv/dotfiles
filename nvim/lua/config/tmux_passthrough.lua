-- nvim 0.13 experimental vim.ui.img uses Kitty graphics and currently supports PNG only.
-- tmux does not interpret or forward Kitty APC graphics sequences by itself, so this
-- adapter wraps them in tmux's DCS passthrough format for the outer terminal.
-- requires tmux 3.3+ with `allow-passthrough on`
-- terminal must support the Kitty graphics protocol.

local M = {}
local enabled = false

local function pane_offset()
	local cmd = { "tmux", "display-message", "-p", "#{pane_top}\t#{pane_left}\t#{status}\t#{status-position}" }
	if vim.env.TMUX_PANE then
		table.insert(cmd, 3, "-t")
		table.insert(cmd, 4, vim.env.TMUX_PANE)
	end

	local res = vim.system(cmd, { text = true }):wait()
	if res.code ~= 0 or not res.stdout then
		return 0, 0
	end

	local top, left, status, pos = res.stdout:match("^(%d+)\t(%d+)\t([^\t\r\n]+)\t([^\t\r\n]+)")
	if not top then
		return 0, 0
	end

	local status_rows = (status ~= "off" and pos == "top") and (tonumber(status) or 1) or 0
	return (tonumber(top) or 0) + status_rows, tonumber(left) or 0
end

-- tmux consumes Kitty APC sequences unless they are wrapped in tmux DCS passthrough.
local function wrap_graphics_sequences(data)
	if not data:find("\27_G", 1, true) then
		return data
	end

	-- Translate Neovim pane-local cursor coordinates to outer-terminal coordinates.
	if data:find("\27%[%d+;%d+H") then
		local row_off, col_off = pane_offset()
		if row_off ~= 0 or col_off ~= 0 then
			data = (
				data:gsub("\27%[(%d+);(%d+)H", function(row, col)
					return string.format("\27[%d;%dH", tonumber(row) + row_off, tonumber(col) + col_off)
				end)
			)
		end
	end

	-- Keep cursor positioning and the Kitty command in the same outer-terminal write.
	local escaped = data:gsub("\27", "\27\27")
	return "\27Ptmux;" .. escaped .. "\27\\"
end

function M.enable()
	if not vim.env.TMUX or enabled then
		return
	end

	-- intercept nvim's terminal output and transform only writes with Kitty graphics
	local ui_send = vim.api.nvim_ui_send
	rawset(vim.api, "nvim_ui_send", function(data)
		return ui_send(wrap_graphics_sequences(data))
	end)
	enabled = true
end

return M

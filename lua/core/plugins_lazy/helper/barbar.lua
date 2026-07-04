local M = {}

local ggu = function() return require("_before.general_utils") end

--- Closes the current buffer or the tab (if only one buffer left)
function M.close_buffer_or_tab()
	local buf_count = #vim.fn.getbufinfo({ buflisted = 1 })
	local tab_count = vim.fn.tabpagenr("$")

	if buf_count == 1 then
		if tab_count == 1 then
			vim.cmd("q")
		else
			vim.cmd("tabclose")
		end
	else
		local ok, bufremove = pcall(require, "mini.bufremove")
		if ok then
			bufremove.delete(0, false)
		else
			vim.notify("mini.bufremove not available", vim.log.levels.ERROR)
		end
	end
end

--- Force delete the current buffer
function M.force_close_buffer()
	local ok, bufremove = pcall(require, "mini.bufremove")
	if ok then
		bufremove.delete(0, false)
	else
		vim.notify("mini.bufremove not available", vim.log.levels.ERROR)
	end
end

function M.goto_buffer(buf_num) vim.cmd("BufferGoto " .. buf_num) end

-- ========================== Buffer order API ======================

function M.get_current_buffer_state()
	local state = require("barbar.state")

	local snapshot = {
		buffers = {},
	}

	for i, bufnr in ipairs(state.buffers) do
		local path = vim.api.nvim_buf_get_name(bufnr)

		if path == "" then
			path = "[No Name]"
		end

		local data = state.data_by_bufnr and state.data_by_bufnr[bufnr] or {}

		snapshot.buffers[i] = {
			index = i,
			bufnr = bufnr,
			path = path, -- store full path
			pinned = data.pinned or false,
		}
	end

	return snapshot
end

local function write_json_file(path, json)
	local fd = assert(io.open(path, "w"))
	fd:write(json)
	fd:close()
end

function M.save_buff_order(path)
	local snapshot = M.get_current_buffer_state()
	local json = vim.json.encode(snapshot, { indent = "\t" })

	-- Hardcoded output file
	write_json_file(path, json)
end

local function read_json_file(path)
	local uv = vim.uv or vim.loop
	if not uv.fs_stat(path) then
		return nil, "File not found"
	end

	local lines = vim.fn.readfile(path)
	if not lines then
		return nil, "File not found or empty"
	end

	-- Join lines into a single string for JSON decoding
	local json_str = table.concat(lines, "\n")
	local ok, data = pcall(vim.json.decode, json_str)
	if not ok then
		return nil, "Failed to decode JSON: " .. tostring(data)
	end

	return data
end

function M.load_buff_order(path)
	local out = ggu().print_custom

	local snapshot, err = read_json_file(path)
	if not snapshot then
		out("Error :", err)
		return nil
	end

	if not snapshot.buffers then
		out("No buffers found in snapshot")
		return nil
	end

	local debug_print = true
	if debug_print then
		for i, buf in ipairs(snapshot.buffers) do
			local path_l = buf.path or "[No Path]"
			local pinned = buf.pinned and "pinned" or "unpinned"
			out(string.format("%02d | bufnr=%d | %s | %s", i, buf.bufnr or -1, path_l, pinned))
		end
	end

	return snapshot
end

function M.print_current_internal_state()
	local out = ggu().print_custom
	local state = require("barbar.state")
	out("\nInternal state\n")
	ggu().dump_table(state.buffers)
end

-- Strip a full snapshot to just a barbar-style buffer list
function M.strip_state(full_snapshot)
	if not full_snapshot or not full_snapshot.buffers then
		return {}
	end

	local stripped = {}
	for i, buf in ipairs(full_snapshot.buffers) do
		table.insert(stripped, buf.bufnr)
	end
	return stripped
end

--- Verify stripped state vs internal barbar state for format consistency
-- @param stripped table from M.strip_state
-- @param internal table from require("barbar.state").buffers
-- @return boolean true if format is consistent, false otherwise
function M.verify_format(stripped, internal)
	local out = ggu().print_custom

	-- Check that both are tables
	if type(stripped) ~= "table" or type(internal) ~= "table" then
		out("Warning: one of the states is not a table")
		return false
	end

	-- Check length
	if #stripped ~= #internal then
		out(string.format("Warning: length mismatch: stripped=%d, internal=%d", #stripped, #internal))
		return false
	end

	-- Check type of each entry
	for i = 1, #stripped do
		if type(stripped[i]) ~= "number" or type(internal[i]) ~= "number" then
			out(string.format("Warning: type mismatch at index %d: stripped=%s, internal=%s", i, type(stripped[i]), type(internal[i])))
			return false
		end
	end

	return true
end

function M.reorder_buffer_to_json(path)
	--
	local wanted_state = M.load_buff_order(path)
	local current_state = M.get_current_buffer_state()
	local out = ggu().print_custom

	local debug = false

	if debug then
		out("Current State\n")
		ggu().dump_table(current_state)
	end

	if debug then
		out("\nWanted State\n")
		ggu().dump_table(wanted_state)
	end

	local striped_wanted_state = M.strip_state(wanted_state)
	if debug then
		out("\nStripped Wanted State\n")
		ggu().dump_table(striped_wanted_state)
	end

	local super_internal_state = require("barbar.state")
	local internal_state = super_internal_state.buffers
	if debug then
		out("\nInternal state\n")
		ggu().dump_table(internal_state)
	end

	local works = M.verify_format(striped_wanted_state, internal_state)
	if not works then
		out("Didn't work, early exist\n")
		return
	end

	super_internal_state.buffers = striped_wanted_state
	if debug then
		out("\nInternal state After switch\n")
		ggu().dump_table(super_internal_state.buffers)
	end
end

return M

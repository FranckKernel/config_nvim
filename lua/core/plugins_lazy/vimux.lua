local uname = vim.loop.os_uname()
local is_windows = uname.sysname == "Windows_NT"

if is_windows then
	return {}
end

local uname = vim.loop.os_uname()
local is_windows = uname.sysname == "Windows_NT"

if is_windows then
	return {}
end

local keymap = vim.keymap.set

local function opts(desc)
	return {
		noremap = true,
		silent = true,
		desc = desc,
	}
end

return {
	{
		"preservim/vimux",
		lazy = true,

		init = function()
			-- Runner appearance
			vim.g.VimuxHeight = "35%"
			vim.g.VimuxOrientation = "h"
			vim.g.VimuxRunnerType = "pane"

			-- Runner behavior
			vim.g.VimuxUseNearest = 1
			vim.g.VimuxResetSequence = "C-u"
			vim.g.VimuxExpandCommand = 1
			vim.g.VimuxCloseOnExit = 0

			-- Prompt
			vim.g.VimuxPromptString = "Vimux> "

			-- Debugging
			vim.g.VimuxDebug = false
		end,

		keys = {
			-- Execute commands
			{
				"<leader>vp",
				"<cmd>VimuxPromptCommand<CR>",
				opts("Vimux: Prompt for command"),
			},
			{
				"<leader>vl",
				"<cmd>VimuxRunLastCommand<CR>",
				opts("Vimux: Run last command"),
			},

			-- Runner management
			{
				"<leader>vo",
				"<cmd>VimuxOpenRunner<CR>",
				opts("Vimux: Open runner"),
			},
			{
				"<leader>vq",
				"<cmd>VimuxCloseRunner<CR>",
				opts("Vimux: Close runner"),
			},
			{
				"<leader>vi",
				"<cmd>VimuxInspectRunner<CR>",
				opts("Vimux: Inspect runner"),
			},
			{
				"<leader>vz",
				"<cmd>VimuxZoomRunner<CR>",
				opts("Vimux: Zoom runner"),
			},

			-- Runner interaction
			{
				"<leader>vx",
				"<cmd>VimuxInterruptRunner<CR>",
				opts("Vimux: Interrupt command"),
			},
			{
				"<leader>vc",
				"<cmd>VimuxClearTerminalScreen<CR>",
				opts("Vimux: Clear terminal screen"),
			},
			{
				"<leader>vC",
				"<cmd>VimuxClearRunnerHistory<CR>",
				opts("Vimux: Clear runner history"),
			},
		},
	},
}

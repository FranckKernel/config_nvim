local hb = "core.plugins_lazy.helper.barbar"
-- helper barbar

return {
	"romgrk/barbar.nvim",
	dependencies = {
		"lewis6991/gitsigns.nvim", -- optional: for git status
		"nvim-tree/nvim-web-devicons", -- optional: for file icons
		-- "echasnovski/mini.bufremove", -- is loaded by doing a bufferclose. in helper
	},
	-- event = { "BufReadPre", "BufNewFile" }, -- Lazy-load at buffer read or new
	event = { "BufReadPre", "BufNewFile", "User PossessionSessionLoaded" }, -- Lazy-load at buffer read or new
	keys = {
		{
			"<leader>q",
			function() require(hb).close_buffer_or_tab() end,
			desc = "Close current buffer (And Tab if Empty)",
		},
		{
			"<leader>X",
			function() require(hb).force_close_buffer() end,
			desc = "Close Current Buffer (Only)",
		},
	},
	init = function()
		vim.g.barbar_auto_setup = false -- disable auto-setup so we can customize manually
	end,
	config = function()
		local barbar = require("barbar")
		barbar.setup({
			animation = true,
			insert_at_end = true,
			closable = true,
			highlight_alternate = true,
			highlight_inactive_file_icons = true,
			highlight_visible = true,
			icons = {
				buffer_index = true,
				buffer_close = "",
				modified = { button = "●" },
				button = "",
				preset = "default",
				separator_at_end = false,
				diagnostics = {
					[vim.diagnostic.severity.ERROR] = { enabled = true, icon = "" },
					[vim.diagnostic.severity.WARN] = { enabled = true, icon = "" },
					[vim.diagnostic.severity.INFO] = { enabled = true, icon = "" },
					[vim.diagnostic.severity.HINT] = { enabled = true, icon = "" },
				},
			},
			maximum_padding = 0,
			minimum_padding = 1,
			maximum_length = 30,
			minimum_length = 0,
			filter = function(buf, _) return vim.bo[buf].buftype ~= "terminal" end,
			sidebar_filetypes = {
				NvimTree = { text = "File Explorer", align = "center" },
				undotree = { text = "Undo History", align = "center" },
			},
			auto_hide = false,
		})

	end,
}

return {
	{
		"rolv-apneseth/tfm.nvim",
		lazy = true,
		ui = {
			border = "rounded",
			height = 1,
			width = 1,
			x = 0.5,
			y = 0.5,
		},

		keys = {

			{ "<leader>lf", function() require("tfm").open() end, desc = "Open lf (file manager)" },
			{ "<leader>rr", function() require("tfm").open() end, desc = "TFM" },
			{ "<leader>rv", function() require("tfm").open(nil, require("tfm").OPEN_MODE.split) end, desc = "TFM - horizontal split" },
			{ "<leader>rh", function() require("tfm").open(nil, require("tfm").OPEN_MODE.vsplit) end, desc = "TFM - vertical split" },
			{ "<leader>rt", function() require("tfm").open(nil, require("tfm").OPEN_MODE.tabedit) end, desc = "TFM - new tab" },

			{ "<leader>TT", ":Tfm<CR>", desc = "TFM" },
			{ "<leader>TH", ":TfmSplit<CR>", desc = "TFM - horizontal split" },
			{ "<leader>TV", ":TfmVsplit<CR>", desc = "TFM - vertical split" },
			{ "<leader>TE", ":TfmTabedit<CR>", desc = "TFM - new tab" },
		},
		config = function()
			require("tfm").setup({
				file_manager = "lf", -- Use "lf" as the file manager
				replace_netrw = true, -- Replace netrw entirely
				enable_cmds = false, -- Disable commands like Tfm, TfmSplit, etc.
			})
		end,
	},
}

return {
	{
		"jiaoshijie/undotree",
		dependencies = { "nvim-lua/plenary.nvim" },
		keys = {
			{
				"<space>u",
				function() require("undotree").toggle() end,
				desc = "Toggle undo tree",
			},
		},
		config = function()
			local undotree = require("undotree")
			undotree.setup({
				float_diff = true,
				layout = "left_bottom",
				position = "left",
				ignore_filetype = { "undotree", "undotreeDiff", "qf", "TelescopePrompt", "spectre_panel", "tsplayground" },
				window = {
					winblend = 30,
				},
				keymaps = {
					move_next = "k",
					move_prev = "i",
					move2parent = "gp",
					move_change_next = "K",
					move_change_prev = "I",
					action_enter = "<cr>",
					enter_diffbuf = "d",
					quit = "q",
				},
			})
		end,
	},
}

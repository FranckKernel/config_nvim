return {
	"folke/which-key.nvim",
	event = "VeryLazy",
	opts = {
		preset = "modern",
		delay = 300,
		win = {
			border = "rounded",
			padding = { 2, 3 },
			title = true,
			title_pos = "center",
		},
		layout = {
			width = { min = 25, max = 50 },
			spacing = 4,
		},
		icons = {
			mappings = true,
			colors = true,
			separator = "➜",
			group = " ",
		},
		plugins = {
			presets = {
				operators = true,
				motions = true,
				text_objects = true,
				windows = true,
				nav = true,
				z = true,
				g = true,
			},
		},
	},
	config = function(_, opts)
		require("which-key").setup(opts)

		-- ONLY add the groups you actually need to organize your keymaps
		-- These just create the visual grouping in the popup
		require("which-key").add({
			{ "<leader>f", group = "File" },
			{ "<leader>G", group = "Git" },
			{ "<leader>L", group = "LSP" },
			-- { "<leader>b", group = "Buffer" },
			-- etc. Only for groups you actually use
		})
	end,
}

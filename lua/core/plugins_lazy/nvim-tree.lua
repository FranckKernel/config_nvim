return {
	"nvim-tree/nvim-tree.lua",
	dependencies = { "nvim-tree/nvim-web-devicons" },
	keys = {
		{ "<leader>tt", "<cmd>NvimTreeToggle<cr>", { noremap = true, silent = true, desc = "Toggle NvimTree" } },
	},
	cmd = { "NvimTreeToggle", "NvimTreeFocus" }, -- lazy load when these commands are run
	config = function()
		local nvim_tree_config = require("core.dependancy_config.nvim-tree")
		nvim_tree_config.setup()
	end,
}

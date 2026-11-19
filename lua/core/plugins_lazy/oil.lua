return {
	"stevearc/oil.nvim",
	event = "VeryLazy",
	keys = {
		{
			"-",
			function() require("oil").open() end,
			desc = "Open parent directory",
		},
	},
	opts = {
		view_options = {
			show_hidden = true,
		},
	},
	config = function(_, opts)
		require("oil").setup(opts)

		local oil_open = function() require("oil").open() end
		vim.keymap.set("n", "-", oil_open, { desc = "Open parent directory" })
		vim.keymap.set("n", "+", ":Oil<CR>", { noremap = true, silent = true })
	end,
}

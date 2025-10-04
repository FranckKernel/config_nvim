return {
	"HawkinsT/pathfinder.nvim",
	lazy = true,
	keys = {
		{ "gf", function() require("pathfinder").gf() end, desc = "Enhanced go to file under cursor", mode = "n", noremap = true, silent = true },
		{
			"gF",
			function() require("pathfinder").gF() end,
			desc = "Enhanced go to file under cursor with line number",
			mode = "n",
			noremap = true,
			silent = true,
		},
		{
			"gx",
			function() require("pathfinder").gx() end,
			desc = "Navigate to the next URL or Git repo under cursor",
			mode = "n",
			noremap = true,
			silent = true,
		},
	},
	config = function()
		local keymap = vim.keymap
		local function opts(desc) return { noremap = true, silent = true, desc = desc } end

		keymap.set("n", "gf", function() require("pathfinder").gf() end, opts("Enhanced go to file under cursor"))
		keymap.set(
			"n",
			"gF",
			function() require("pathfinder").gF() end,
			opts("Enhanced go to file under cursor (with line number support) file.txt:12)")
		)
		keymap.set("n", "gx", function() require("pathfinder").gx() end, opts("Navigate to the next URL or Git repo under cursor"))

		vim.api.nvim_set_hl(0, "PathfinderDim", { fg = "#808080", bg = "none" })
		vim.api.nvim_set_hl(0, "PathfinderHighlight", { fg = "#DDDDDD", bg = "none" })
		vim.api.nvim_set_hl(0, "PathfinderNumberHighlight", { fg = "#00FF00", bg = "none" })
		vim.api.nvim_set_hl(0, "PathfinderColumnHighlight", { fg = "#FFFF00", bg = "none" })
		vim.api.nvim_set_hl(0, "PathfinderNextKey", { fg = "#FF00FF", bg = "none" })
		vim.api.nvim_set_hl(0, "PathfinderFutureKeys", { fg = "#BB00AA", bg = "none" })

		vim.keymap.set("n", "<leader>gf", require("pathfinder").select_file)
		vim.keymap.set("n", "<leader>gF", require("pathfinder").select_file_line)
		vim.keymap.set("n", "<leader>gx", require("pathfinder").select_url)
		vim.keymap.set("n", "<leader>gh", require("pathfinder").hover_description, {
			desc = "Pathfinder: Hover",
			silent = true,
		})
		vim.keymap.set("n", "<leader>gt", require("pathfinder").tmux_toggle, {
			desc = "Pathfinder: Toggle tmux Mode",
			silent = true,
		})
	end,
}

-- "https://www.google.com"

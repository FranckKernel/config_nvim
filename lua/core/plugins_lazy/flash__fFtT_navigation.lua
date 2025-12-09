local pre_config = require("_before.pre_config")

local w_jump = {}
local s_jump = {}
local use_s = true
local use_w = false
local ggu = function() return require("_before.general_utils") end

local keys = {
	{
		"wt",
		function() require("flash").toggle() end,
		mode = "n",
		desc = "toggle flash search",
	},
	{
		"wt",
		function() require("flash").treesitter() end,
		mode = { "n", "x", "o" },
		desc = "flash treesitter",
	},
	{
		"wo",
		function() require("flash").remote() end,
		mode = "o",
		desc = "remote flash",
	},
	{
		"ws",
		function() require("flash").treesitter_search() end,
		mode = { "o", "x" },
		desc = "treesitter search",
	},
}

if pre_config.word_ws then
	if use_w then
		ggu().print_custom("adding w")
		table.insert(keys, {
			"w",
			function() require("flash").jump() end,
			mode = { "n", "x", "o", "v" },
			desc = "flash jump (w)",
		})
	end
	if use_s then
		table.insert(keys, {
			"s",
			function() require("flash").jump() end,
			mode = { "n", "x", "o" },
			desc = "flash jump (s)",
		})
	end
end

return {
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		-- lazy = false,
		opts = {
			modes = {
				char = {
					enabled = true,
					jump_labels = true,
					multi_line = true,
					highlight = {
						matches = true,
						backdrop = false,
					},
					label = { after = { 0, 1 } },
				},
			},
		},
		keys = keys,
	},
}

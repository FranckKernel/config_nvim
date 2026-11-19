return {
	-- .ipynb <-> .py (percent format)
	{
		"GCBallesteros/jupytext.nvim",
		config = function()
			require("jupytext").setup({
				style = "percent",
				output_extension = "py",
				force_ft = "python",
			})
		end,
	},
	{
		"FranckKernel/jupynvim",
		build = function(plugin)
			local install = loadfile(plugin.dir .. "/lua/jupynvim/install.lua")()
			install.run(plugin)
		end,
		config = function()
			require("jupynvim").setup({
				-- Your configuration here
				log_level = "info",
				image_renderer = "chafa", -- "placeholder", "kitty", or "chafa"
				cellmode_keys = { up = "i", down = "k", edit = "h" },

				remote = {
					pynq = {
						host = "xilinx@192.168.2.99",
						core_path = "~/.local/bin/jupynvim-core", -- optional
					},
				},
			})

			vim.keymap.set("n", "<leader>px", "<cmd>JupynvimConnect pynq<CR>", {
				desc = "Connect to PYNQ board",
				silent = true,
			})
		end,
	},
}

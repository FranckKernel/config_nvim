return {
	"catppuccin/nvim",
	name = "catppuccin",
	lazy = false,
	priority = 1000,
	config = function()
		require("catppuccin").setup({
			flavour = "mocha",
			transparent_background = true,
			styles = {
				comments = { "italic" },
			},
			-- New float window controls (added in recent updates)
			float = {
				transparent = true, -- Force transparent floats
				solid = true, -- Disable solid borders
			},
			integrations = {
				telescope = {
					enabled = true,
					style = "nvchad", -- More transparent style
				},
				-- which_key = true,
			},
			custom_highlights = function(colors)
				return {
					-- Force transparency in all float elements
					NormalFloat = { bg = "NONE", fg = colors.text },
					FloatBorder = { bg = "None", fg = colors.blue },
					Pmenu = { bg = "None", fg = colors.blue },
					TelescopeNormal = { bg = "NONE" },
					TelescopeBorder = { bg = "NONE", fg = colors.blue },
					WhichKeyFloat = { bg = "NONE" },
					LazyNormal = { bg = "NONE" }, -- For Lazy.nvim
				}
			end,
		})

		vim.o.termguicolors = true
		-- vim.o.background = "dark"
		vim.cmd.colorscheme("catppuccin")

		local extra = false
		-- not needed
		if extra then
			-- Additional fixes for specific plugins
			vim.api.nvim_create_autocmd("ColorScheme", {
				pattern = "catppuccin",
				callback = function()
					vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
					vim.api.nvim_set_hl(0, "FloatBorder", { bg = "NONE", fg = "#89b4fa" })
				end,
			})
		end
	end,
}

-- {
--   base = "#1e1e2f",
--   blue = "#89b4fb",
--   crust = "#11111c",
--   flamingo = "#f2cdce",
--   green = "#a6e3a2",
--   lavender = "#b4beff",
--   mantle = "#181826",
--   maroon = "#eba0ad",
--   mauve = "#cba6f8",
--   overlay0 = "#6c7087",
--   overlay1 = "#7f849d",
--   overlay2 = "#9399b3",
--   peach = "#fab388",
--   pink = "#f5c2e8",
--   red = "#f38ba9",
--   rosewater = "#f5e0dd",
--   sapphire = "#74c7ed",
--   sky = "#89dcec",
--   subtext0 = "#a6adc9",
--   subtext1 = "#bac2df",
--   surface0 = "#313245",
--   surface1 = "#45475b",
--   surface2 = "#585b71",
--   teal = "#94e2d6",
--   text = "#cdd6f5",
--   yellow = "#f9e2b0"
-- }

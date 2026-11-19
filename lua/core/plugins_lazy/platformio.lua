local gu = require("_before.general_utils")

local function has_platformio_project()
	local project_root = gu.find_project_root()

	if project_root and vim.fn.filereadable(project_root .. "/platformio.ini") == 1 then
		vim.g.platformioRootDir = project_root
		return true
	end

	return false
end

has_platformio_project()

return {
	"anurag3301/nvim-platformio.lua",

	dependencies = {
		{ "nvim-telescope/telescope.nvim" },
		{ "nvim-telescope/telescope-ui-select.nvim" },
		{ "nvim-lua/plenary.nvim" },
		{ "folke/which-key.nvim" },
		{ "nvim-treesitter/nvim-treesitter" },
		{ "akinsho/toggleterm.nvim" },
	},

	cmd = {
		"Pioinit",
		"Piorun",
		"Piocmdh",
		"Piocmdf",
		"Piolib",
		"Piomon",
		"Piodebug",
		"Piodb",
		"PioLSP",
	},

	lazy = not has_platformio_project(),

	init = function()
		vim.g.pioConfig = {
			lsp = "ccls",
			clangd_source = "ccls",
			picker_backend = "auto",
			debug = true,

			menu_key = "<leader>pM",
			menu_name = "PlatformIO",

			menu_bindings = {
				{
					node = "item",
					desc = "[L]ist terminals",
					shortcut = "l",
					command = "PioTermList",
				},

				{
					node = "item",
					desc = "[T]erminal Core CLI",
					shortcut = "t",
					command = "Piocmdf",
				},

				{
					node = "menu",
					desc = "[G]eneral",
					shortcut = "g",
					items = {
						{
							node = "item",
							desc = "[B]uild",
							shortcut = "b",
							command = "Piocmdf run",
						},
						{
							node = "item",
							desc = "[U]pload",
							shortcut = "u",
							command = "Piocmdf run -t upload",
						},
						{
							node = "item",
							desc = "[M]onitor",
							shortcut = "m",
							command = "Piocmdh run -t monitor",
						},
						{
							node = "item",
							desc = "[C]lean",
							shortcut = "c",
							command = "Piocmdf run -t clean",
						},
						{
							node = "item",
							desc = "[F]ull clean",
							shortcut = "f",
							command = "Piocmdf run -t fullclean",
						},
						{
							node = "item",
							desc = "[D]evice list",
							shortcut = "d",
							command = "Piocmdf device list",
						},
					},
				},

				{
					node = "menu",
					desc = "[P]latform",
					shortcut = "p",
					items = {
						{
							node = "item",
							desc = "Build file [S]ystem",
							shortcut = "s",
							command = "Piocmdf run -t buildfs",
						},
						{
							node = "item",
							desc = "Program [S]ize",
							shortcut = "z",
							command = "Piocmdf run -t size",
						},
						{
							node = "item",
							desc = "[U]pload file system",
							shortcut = "u",
							command = "Piocmdf run -t uploadfs",
						},
						{
							node = "item",
							desc = "[E]rase Flash",
							shortcut = "e",
							command = "Piocmdf run -t erase",
						},
					},
				},

				{
					node = "menu",
					desc = "[D]ependencies",
					shortcut = "d",
					items = {
						{
							node = "item",
							desc = "[L]ist packages",
							shortcut = "l",
							command = "Piocmdf pkg list",
						},
						{
							node = "item",
							desc = "[O]utdated packages",
							shortcut = "o",
							command = "Piocmdf pkg outdated",
						},
						{
							node = "item",
							desc = "[U]pdate packages",
							shortcut = "u",
							command = "Piocmdf pkg update",
						},
					},
				},

				{
					node = "menu",
					desc = "[A]dvanced",
					shortcut = "a",
					items = {
						{
							node = "item",
							desc = "[T]est",
							shortcut = "t",
							command = "Piocmdf test",
						},
						{
							node = "item",
							desc = "[C]heck",
							shortcut = "c",
							command = "Piocmdf check",
						},
						{
							node = "item",
							desc = "[D]ebug",
							shortcut = "d",
							command = "Piocmdf debug",
						},
						{
							node = "item",
							desc = "Compilation Data[b]ase",
							shortcut = "b",
							command = "Piocmdf run -t compiledb",
						},
					},
				},

				{
					node = "menu",
					desc = "[R]emote",
					shortcut = "r",
					items = {
						{
							node = "item",
							desc = "Remote [U]pload",
							shortcut = "u",
							command = "Piocmdf remote run -t upload",
						},
						{
							node = "item",
							desc = "Remote [T]est",
							shortcut = "t",
							command = "Piocmdf remote test",
						},
						{
							node = "item",
							desc = "Remote [M]onitor",
							shortcut = "m",
							command = "Piocmdh remote run -t monitor",
						},
						{
							node = "item",
							desc = "Remote [D]evices",
							shortcut = "d",
							command = "Piocmdf remote device list",
						},
					},
				},
			},
		}
	end,

	config = function()
		local ok, platformio = pcall(require, "platformio")

		if ok then
			platformio.setup(vim.g.pioConfig)
		end

		local map = vim.keymap.set

		local function opts(desc)
			return {
				noremap = true,
				silent = true,
				desc = desc,
			}
		end

		map("n", "<leader>pi", "<cmd>Pioinit<CR>", opts("PlatformIO Init"))

		map("n", "<leader>pr", "<cmd>Piorun<CR>", opts("PlatformIO Run"))

		map("n", "<leader>ph", "<cmd>Piocmdh<CR>", opts("PlatformIO Command History"))

		map("n", "<leader>pf", "<cmd>Piocmdf<CR>", opts("PlatformIO Command Find"))

		map("n", "<leader>pl", "<cmd>Piolib<CR>", opts("PlatformIO Library"))

		map("n", "<leader>pm", "<cmd>Piomon<CR>", opts("PlatformIO Monitor"))

		map("n", "<leader>pd", "<cmd>Piodebug<CR>", opts("PlatformIO Debug"))

		map("n", "<leader>pb", "<cmd>Piodb<CR>", opts("PlatformIO Compilation Database"))
	end,
}

local M = {}

M.config = {
	cmd = { "ccls" },

	init_options = {
		cache = {
			directory = ".ccls-cache",
		},

		index = {
			threads = 8,
		},

		highlight = {
			lsRanges = true,
		},

		clang = {
			excludeArgs = { "-frounding-math" },
		},
	},

	filetypes = { "c", "cpp", "objc", "objcpp", "arduino", "ino" },

	root_dir = require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt", ".ccls", ".git"),

	on_init = function(client, bufnr)
		--
		print("Lsp ccls initiated")
		local lsp_helper = require("lsps.helper.lsp_config_helper")
		lsp_helper.add_keybinds()
	end,
	on_attach = function(client, bufnr)
		---
		print("C/C++ (ccls) LSP attached")
	end,
}

return M

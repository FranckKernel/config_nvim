local M = {}

M.config = {
	cmd = { "asm-lsp" },
	filetypes = { "asm", "s", "S", "inc" },
	root_dir = require("lspconfig.util").root_pattern(".git", ".asm-lsp.toml"),

	on_init = function(client, bufnr)
		print("Lsp asm-lsp initiated")

		local lsp_helper = require("lsps.helper.lsp_config_helper")
		lsp_helper.add_keybinds()
	end,
	on_attach = function(client, bufnr)
		--
		-- client.server_capabilities.completionProvider = nil
		print("ASM lsp attached")
	end,
}

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.inc",
	callback = function()
		vim.bo.filetype = "asm" -- or "nasm" if you want NASM-specific highlighting
	end,
})

return M

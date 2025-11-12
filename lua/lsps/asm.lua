local M = {}

M.config = {
	cmd = { "asm-lsp" },
	filetypes = { "asm", "s", "S", "inc" },
	root_dir = require("lspconfig.util").root_pattern(".git", ".asm-lsp.toml"),
	on_attach = function(client, bufnr)
		local lsp_helper = require("lsps.helper.lsp_config_helper")
		print("c lsp attached")
		lsp_helper.add_keybinds()
	end,
}

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
	pattern = "*.inc",
	callback = function()
		vim.bo.filetype = "asm" -- or "nasm" if you want NASM-specific highlighting
	end,
})

return M

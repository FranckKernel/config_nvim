-- lua/core/lsps/go.lua
M = {}

M.config = {
	cmd = { "gopls" },
	filetypes = { "go", "gomod", "gowork", "gotmpl" },
	root_dir = require("lspconfig.util").root_pattern("go.work", "go.mod", ".git"),
	-- settings = {
	-- 	gopls = {
	-- 		analyses = {
	-- 			unusedparams = true,
	-- 			unusedwrite = true,
	-- 			shadow = true,
	-- 		},
	-- 		staticcheck = true,
	-- 		gofumpt = true,
	-- 		usePlaceholders = true,
	-- 		completeUnimported = true,
	-- 		semanticTokens = true,
	-- 	},
	-- },
	on_attach = function(client, bufnr)
		-- your on_attach logic
		local lsp_helper = require("lsps.helper.lsp_config_helper")
		print("go lsp attached")
		lsp_helper.add_keybinds()
	end,
}

return M

-- lua/lsps/zig.lua

local M = {}

local ggu = function() return require("_before.general_utils") end

M.config = {
	cmd = { "zls" },
	filetypes = { "zig" },
	root_dir = require("lspconfig.util").root_pattern("build.zig", ".git"),
	single_file_support = true,
	settings = {
		zls = {
			enable_snippets = true,
			warn_style = false,

			enable_inlay_hints = true,
			inlay_hints_show_builtin = true,
			inlay_hints_show_parameter_name = true,
			inlay_hints_show_variable_type_hints = true,
			inlay_hints_show_struct_literal_field_type = true,
		},
	},

	on_attach = function(client, bufnr)
		-- your on_attach logic
		local lsp_helper = require("lsps.helper.lsp_config_helper")
		ggu().print_custom("Zig LSP Attached")
		lsp_helper.add_keybinds()
	end,
}

return M

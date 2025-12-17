-- lua/core/lsps/cpp.lua
-- Note the c23 fallback flags. If you have an oldass pc, need to change it

-- This file might be unneeded garbage. But, maybe it would be cool to split it idk
M = {}

M.config = {
	cmd = {
		"clangd",
		"--background-index",
		"--clang-tidy",
		"--completion-style=detailed",
		"--function-arg-placeholders",
		"--cross-file-rename",
		"--header-insertion=iwyu",
		"--log=verbose",
		"--query-driver=/opt/rocm/llvm/bin/*",
		"--fallback-style=llvm",
		-- "--experimental-modules-support",
	},
	init_options = {
		clangdFileStatus = true,
		usePlaceholders = true,
		completeUnimported = true,
		fallbackFlags = {
			-- Standard C/C++ flags (comment out OpenCL-specific ones)
			"-std=c23",
			"-x",
			"c", -- "-x c" force C
			-- "-std=c17",
			-- "-std=c++17",
			-- "-I/usr/local/include",  -- Common include paths
			-- Keep OpenCL flags only for actual OpenCL files
		},
	},
	filetypes = { "c", "h", "cpp", "objc", "objcpp" }, -- Removed "x" and "opencl"
	root_dir = require("lspconfig.util").root_pattern(
		"compile_commands.json",
		".clang-format",
		".clangd",
		"compile_flags.txt",
		"Makefile",
		"build.sh",
		".git"
	),
	settings = {
		clangd = {
			fallbackFlags = { "-std=c23" }, -- Changed from C++ to C standard
		},
	},
	on_attach = function(client, bufnr)
		local lsp_helper = require("lsps.helper.lsp_config_helper")
		print("cpp lsp attached")
		lsp_helper.add_keybinds()
	end,
}

return M

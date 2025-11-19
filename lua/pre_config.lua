-- Ensure PRE_CONFIG_FRANCK exists
_G.PRE_CONFIG_FRANCK = {}
PRE_CONFIG_FRANCK.use_bufferline = true

-- Java
PRE_CONFIG_FRANCK.useJavaLspConfig = false
PRE_CONFIG_FRANCK.useMyJavaDap = false
PRE_CONFIG_FRANCK.useNvimJdtls = false
PRE_CONFIG_FRANCK.useNvimJava = false

PRE_CONFIG_FRANCK.jdtls = PRE_CONFIG_FRANCK.useNvimJdtls
	and {
		"mfussenegger/nvim-jdtls",
		dependencies = {
			"mfussenegger/nvim-dap",
			"rcarriga/nvim-dap-ui",
		},
		ft = { "java" },
	}
	or {}

PRE_CONFIG_FRANCK.java = PRE_CONFIG_FRANCK.useNvimJava and { "nvim-java/nvim-java" } or {}

_G.general_utils_franck = {}

_G.general_utils_franck.find_project_root = function(debug)
	local buffer_path = vim.fn.expand("%:p")
	if buffer_path == "" then
		buffer_path = vim.fn.getcwd()
	end

	local buffer_dir = vim.fn.fnamemodify(buffer_path, ":h")

	local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
	local script_name = "find_project_root" .. (is_windows and ".exe" or "")
	local script_path

	if is_windows then
		script_path = vim.fn.stdpath("config") .. "\\" .. "scripts" .. "\\" .. script_name
	else
		script_path = vim.fn.stdpath("config") .. "/" .. "scripts" .. "/" .. script_name
	end


	if vim.fn.filereadable(script_path) ~= 1 then
		if debug then
			vim.schedule(function()
				vim.notify("❌ Project root finder binary not found:\n" .. script_path,
					vim.log.levels.ERROR)
			end)
		end
		return nil
	end

	local result = vim.system({ script_path, buffer_dir, "--verbose" }, { text = true }):wait()

	-- Collect stderr output from script
	if result.stderr and result.stderr ~= "" and debug then
		local stderr_msg = "🔧 [C++ stderr]\n" .. result.stderr
		vim.schedule(function() vim.notify(stderr_msg, vim.log.levels.DEBUG) end)
	end

	local root = vim.trim(result.stdout or "")
	local code = result.code or 1

	if code == 1 then
		if debug then
			vim.schedule(function() vim.notify("ℹ️ Project root fallback: using cwd", vim.log.levels.INFO) end)
		end
	elseif code ~= 0 then
		if debug then
			vim.schedule(function()
				vim.notify("❌ Project root script failed (exit " .. code .. ")", vim.log.levels
					.ERROR)
			end)
		end
		return nil
	end

	if root == "" or not vim.fn.isdirectory(root) then
		if debug then
			vim.schedule(function() vim.notify("⚠️ Invalid project root: '" .. root .. "'", vim.log.levels.WARN) end)
		end
		return nil
	end

	if #root > 256 then
		if debug then
			vim.schedule(function() vim.notify("⚠️ Project root too long\nroot = " .. root, vim.log.levels.WARN) end)
		end
		return nil
	end

	if root:find("[\n\r]") then
		if debug then
			vim.schedule(function() vim.notify("⚠️ Project root contains newlines\nroot = " .. root, vim.log.levels.WARN) end)
		end
		return nil
	end

	return root
end

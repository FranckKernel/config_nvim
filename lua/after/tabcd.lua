local gu = require("_before.general_utils")

vim.api.nvim_create_autocmd("TabEnter", {
	callback = function()
		local bufname = vim.api.nvim_buf_get_name(0) -- Get current buffer's full path
		local buftype = vim.api.nvim_buf_get_option(0, "buftype")
		local ft = vim.api.nvim_buf_get_option(0, "filetype")

		-- Skip empty buffers, special buffers, and DAP buffers
		if bufname == "" or buftype ~= "" or ft:match("^dap") then
			return
		end

		local file_dir = vim.fn.fnamemodify(bufname, ":h") -- Extract directory
		-- Safely change tab-local directory
		local ok, err = pcall(vim.cmd, "tcd " .. vim.fn.fnameescape(file_dir))
		if not ok then
			gu.print_custom("Failed to change tab directory: " .. err)
			return
		end

		local tapi = package.loaded["nvim-tree.api"]
		if tapi and tapi.tree and tapi.tree.change_root then
			tapi.tree.change_root(file_dir) -- Sync Nvim-Tree, if available
		end

		gu.print_custom("Changed tab directory to: " .. file_dir)
	end,
})

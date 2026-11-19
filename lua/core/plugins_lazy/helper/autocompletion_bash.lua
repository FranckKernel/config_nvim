local M = {}

local cache_file = vim.fn.stdpath("cache") .. "/bash_commands.txt"

-- RAM cache: parsed nvim-cmp completion entries.
local bash_commands = nil

-- Read Bash commands and update both caches.
function M.refresh()
	vim.notify("Refreshing Bash command cache...", vim.log.levels.INFO)

	local commands = vim.fn.systemlist({
		"bash",
		"-c",
		"compgen -c",
	})

	if vim.v.shell_error ~= 0 then
		vim.notify("Failed to generate Bash command cache.", vim.log.levels.ERROR)
		return false
	end

	-- Ensure cache directory exists.
	vim.fn.mkdir(vim.fn.stdpath("cache"), "p")

	-- Write to a temporary file, then replace the old cache.
	local temp_file = cache_file .. "." .. vim.fn.getpid()

	if vim.fn.writefile(commands, temp_file) ~= 0 then
		vim.notify("Failed to write Bash command cache.", vim.log.levels.ERROR)
		return false
	end

	if vim.fn.rename(temp_file, cache_file) ~= 0 then
		vim.fn.delete(temp_file)
		vim.notify("Failed to replace Bash command cache.", vim.log.levels.ERROR)
		return false
	end

	-- Update RAM cache.
	bash_commands = {}

	for _, cmd in ipairs(commands) do
		if cmd ~= "" then
			table.insert(bash_commands, {
				label = cmd,
			})
		end
	end

	vim.notify(string.format("Bash cache refreshed: %d commands.", #bash_commands), vim.log.levels.INFO)

	return true
end

-- Load from RAM, disk, or generate if no cache exists.
function M.get_commands()
	if bash_commands ~= nil then
		return bash_commands
	end

	if vim.fn.filereadable(cache_file) == 1 then
		bash_commands = {}

		for _, cmd in ipairs(vim.fn.readfile(cache_file)) do
			if cmd ~= "" then
				table.insert(bash_commands, {
					label = cmd,
				})
			end
		end

		return bash_commands
	end

	M.refresh()

	return bash_commands or {}
end

-- nvim-cmp source.
M.source = {
	complete = function(_, _, callback)
		-- Only provide commands for :!
		if vim.fn.getcmdline():sub(1, 1) ~= "!" then
			callback({
				items = {},
				isIncomplete = false,
			})
			return
		end

		callback({
			items = M.get_commands(),
			isIncomplete = false,
		})
	end,
}

return M

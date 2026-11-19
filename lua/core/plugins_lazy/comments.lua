-- Store current state
local current_comment = ";" -- default to NASM style

-- Function to toggle ASM comment character
function ToggleAsmComment()
	-- Determine the new comment character
	if current_comment == ";" then
		current_comment = "#"
	else
		current_comment = ";"
	end

	-- Make sure Comment.nvim is loaded
	local ft = require("Comment.ft")
	-- Apply to ASM filetypes
	ft.set("asm", current_comment .. "%s")
	ft.set("s", current_comment .. "%s")
	ft.set("S", current_comment .. "%s")

	print("ASM comment character set to: " .. current_comment)
end

return {
	-- "numToStr/Comment.nvim",
	"neovim-plugins/comment.nvim",
	branch = "fix/patch-treesitter",
	lazy = true,
	keys = {
		{ "gcc", mode = "n", desc = "Toggle comment line" },
		{ "gbc", mode = "n", desc = "Toggle block comment" },
		{ "gc", mode = { "n", "v" }, desc = "Comment operator" },
		{ "gb", mode = { "n", "v" }, desc = "Block comment operator" },
		{ "gco", mode = "n", desc = "Comment below" },
		{ "gcO", mode = "n", desc = "Comment above" },
		{ "gcA", mode = "n", desc = "Comment end of line" },
	},
	config = function()
		local comment = require("Comment")
		comment.setup()

		x = 5

		local ft = require("Comment.ft")
		-- For NASM/GAS style assembly, line comment is `;`
		ft.set("asm", ";%s")

		ft.set("systemd", "# %s")

		vim.keymap.set("n", "<leader>.a", ToggleAsmComment, { desc = "Toggle Asm comment from ; to #" })
	end,
}

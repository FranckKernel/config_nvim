local function opts(desc) return { noremap = true, silent = true, desc = desc } end
local keymap = vim.keymap

if false then
	keymap.set("n", "<C-k>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", opts("switch to a particular session"))
	keymap.set("n", "<C-k>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", opts("switch to a particular session"))
	keymap.set("n", "<M-h>", "<cmd>silent !tmux neww tmux-sessionizer -s 0<CR>", opts("Do session command 0 in special session"))
	keymap.set("n", "<M-x>", "<cmd>silent !tmux neww tmux-sessionizer -s 1<CR>", opts("Do session command 1 in special session"))
	keymap.set("n", "<M-b>", "<cmd>silent !tmux neww tmux-sessionizer -s 1<CR>", opts("Do session command 1 in special session"))
	keymap.set("n", "<M-c>", "<cmd>silent !tmux neww tmux-sessionizer -s 2<CR>", opts("Do session command 2 in special session"))
	keymap.set("n", "<M-n>", "<cmd>silent !tmux neww tmux-sessionizer -t Runner 0<CR>", opts("Do session command 0 in Runner Session"))
	keymap.set("n", "<M-t>", "<cmd>silent !tmux neww tmux-sessionizer -t Runner 1<CR>", opts("Do session command 1 in Runner Session"))
end

-- keymap.set("n", "<C-y>", "<cmd>silent !tmux new-window tmux-sessionizer<CR>", opts("switch to a particular session"))
-- keymap.set("n", "<M-h>", "<cmd>!tmux new-window tmux-sessionizer -s 0<CR>", opts("Do session command 0 in special session"))
-- keymap.set("n", "<M-x>", "<cmd>!tmux new-window tmux-sessionizer -s 1<CR>", opts("Do session command 1 in special session"))
-- keymap.set("n", "<M-b>", "<cmd>!tmux new-window tmux-sessionizer -s 1<CR>", opts("Do session command 1 in special session"))
-- keymap.set("n", "<M-c>", "<cmd>!tmux new-window tmux-sessionizer -s 2<CR>", opts("Do session command 2 in special session"))
-- keymap.set("n", "<M-n>", "<cmd>!tmux new-window tmux-sessionizer -t Runner 0<CR>", opts("Do session command 0 in Runner Session"))
-- keymap.set("n", "<M-t>", "<cmd>!tmux new-window tmux-sessionizer -t Runner 1<CR>", opts("Do session command 1 in Runner Session"))

--- This is meaningless if not running inside tmux.
--- Regular neovim not inside tmux can't use it. And tmux keybinds are already gonna be used

local function opts(desc) return { noremap = true, silent = true, desc = desc } end
local keymap = vim.keymap

keymap.set("n", "<C-k>", "<cmd>silent !tmux neww tmux-sessionizer<CR>", opts("switch to a particular session"))
keymap.set("n", "<M-h>", "<cmd>silent !tmux neww tmux-sessionizer -s 0<CR>", opts("Do session command 0 in special session"))
keymap.set("n", "<M-x>", "<cmd>silent !tmux neww tmux-sessionizer -s 1<CR>", opts("Do session command 1 in special session"))
keymap.set("n", "<M-b>", "<cmd>silent !tmux neww tmux-sessionizer -s 1<CR>", opts("Do session command 1 in special session"))
keymap.set("n", "<M-t>", "<cmd>silent !tmux neww tmux-sessionizer -s 2<CR>", opts("Do session command 2 in special session"))
keymap.set("n", "<M-n>", "<cmd>silent !tmux neww tmux-sessionizer -t Runner 0<CR>", opts("Do session command 0 in Runner Session"))
keymap.set("n", "<M-s>", "<cmd>silent !tmux neww tmux-sessionizer -t Runner 1<CR>", opts("Do session command 1 in Runner Session"))
-- These are for session commands, which i dont use. So learn what they are about.
-- They aren't about create or switchgint to session n

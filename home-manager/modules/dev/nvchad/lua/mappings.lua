require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", { desc = "CMD enter command mode" })
map("i", "jk", "<ESC>")

-- map({ "n", "i", "v" }, "<C-s>", "<cmd> w <cr>")

map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

map("v", "<C-j>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
map("v", "<C-k>", ":m '<-2<CR>gv=gv", { noremap = true, silent = true })

map('t', '<Esc>', '<C-\\><C-n>', { noremap = true, silent = true })

map("n", "J", "}", { noremap = true, silent = true })
map("n", "K", "{", { noremap = true, silent = true })

map("v", "J", "}", { noremap = true, silent = true })
map("v", "K", "{", { noremap = true, silent = true })

-- https://www.reddit.com/r/neovim/comments/10wru1c/comment/j7osls8/
map("n", "<A-h>", [[<cmd>vertical resize -5<cr>]])
map("n", "<A-l>", [[<cmd>vertical resize +5<cr>]])
map("n", "<A-j>", [[<cmd>horizontal resize -2<cr>]])
map("n", "<A-k>", [[<cmd>horizontal resize +2<cr>]])


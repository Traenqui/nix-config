vim.g.mapleader = " "
vim.g.localmapleader = ","

vim.keymap.set("i", "jk", "<ESC>", { desc = "Exit insert mode with jk" })
vim.keymap.set("i", "kj", "<ESC>", { desc = "Exit insert mode with kj" })

-- config tinkering
vim.keymap.set("n", "<space><space>x", "<cmd>source %<CR>")
vim.keymap.set("n", "<space>x", ":.lua<CR>")
vim.keymap.set("v", "<space>x", ":lua<CR>")

vim.keymap.set("n", "<S-Tab>", ":normal zs<CR>", { noremap = true, silent = true, desc = "edit: Toggle code folding" })
vim.keymap.set("n", "Y", "y$", { noremap = true, silent = true, desc = "edit: Yank text to EOL" })
vim.keymap.set("n", "D", "d$", { noremap = true, silent = true, desc = "edit: Delete text to EOL" })
vim.keymap.set("n", "n", "nzzzv", { noremap = true, silent = true, desc = "edit: Next search result" })
vim.keymap.set("n", "N", "Nzzzv", { noremap = true, silent = true, desc = "edit: Prev search result" })
vim.keymap.set("n", "<BS>", "^", { noremap = true, silent = true })

vim.keymap.set("n", "<ESC>", ":nohl<CR>", { desc = "edit: Clear search highlights" })

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv", { desc = "edit: Move this line down" })
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv", { desc = "edit: Move this line down" })
-- WINDOW
vim.keymap.set("n", "<C-h>", "<C-w>h", { noremap = true, silent = true, desc = "window: Focus left" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { noremap = true, silent = true, desc = "window: Focus right" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { noremap = true, silent = true, desc = "window: Focus down" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { noremap = true, silent = true, desc = "window: Focus up" })

vim.keymap.set("t", "<C-w>h", "<cmd>wincmd h<CR>", { noremap = true, desc = "window: Focus left" })
vim.keymap.set("t", "<C-w>l", "<cmd>wincmd l<CR>", { noremap = true, desc = "window: Focus right" })
vim.keymap.set("t", "<C-w>j", "<cmd>wincmd j<CR>", { noremap = true, desc = "window: Focus down" })
vim.keymap.set("t", "<C-w>k", "<cmd>wincmd k<CR>", { noremap = true, desc = "window: Focus up" })

vim.keymap.set("n", "<A-h>", "<cmd>vertical resize -3<CR>", { silent = true, desc = "window: Resize -3 vertically" })
vim.keymap.set("n", "<A-l>", "<cmd>vertical resize +3<CR>", { silent = true, desc = "window: Resize +3 vertically" })
vim.keymap.set("n", "<A-j>", "<cmd>resize -3<CR>", { silent = true, desc = "window: Resize -3 horizontally" })
vim.keymap.set("n", "<A-k>", "<cmd>resize +3<CR>", { silent = true, desc = "window: Resize +3 horizontally" })

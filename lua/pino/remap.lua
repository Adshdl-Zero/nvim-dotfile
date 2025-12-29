vim.g.mapleader = " "
vim.opt.guicursor = ""
vim.opt.number = true
vim.opt.relativenumber = true

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { desc = "Go to previous diagnostic" })

vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { desc = "Go to next diagnostic" })

vim.keymap.set("n", "<leader>fd", vim.diagnostic.open_float, { desc = "Show line diagnostics" })

vim.opt.scrolloff = 999
vim.opt.cursorline = true

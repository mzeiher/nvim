require("config.lazy")

vim.wo.relativenumber = true
vim.wo.cursorline = true
vim.o.scrolloff = 5

vim.api.nvim_set_keymap("n", "<leader>bd", ":bd<cr>", { silent = true, noremap = true, desc = "close buffer" })

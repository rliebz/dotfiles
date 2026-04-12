vim.pack.add({ "https://github.com/rliebz/nvim-clover" })

vim.keymap.set("n", "<leader>cu", vim.cmd.CloverUp)
vim.keymap.set("n", "<leader>cd", vim.cmd.CloverDown)
vim.keymap.set("n", "<leader>ct", vim.cmd.CloverToggle)

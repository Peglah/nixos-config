vim.keymap.set("n", "<leader>r", ":write<CR>:terminal luajit %<CR>", { buffer = true, desc = "Save and run Lua" })

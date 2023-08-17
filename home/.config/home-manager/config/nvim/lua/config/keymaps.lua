vim.keymap.set("n", "<Esc>", "<cmd>noh<cr>", { silent = true, desc = "Clear highlight" })

vim.keymap.set("n", "n", "nzzzv", { desc = "Move to next search result" })

vim.keymap.set("n", "<leader>o", "<cmd>setlocal spell spelllang=sv,en<CR>:set complete+=kspell<CR>", { desc = "Enable Spellcheck" })
vim.keymap.set("n", "<leader>d", "0f[lrxV/- [ <CR>kd/-DONE-<CR>p<cmd>noh<CR>", { desc = "Mark done and move to Done" })
vim.keymap.set("n", "<leader>.", '"=strftime("%F")<CR>Pa<CR><ESC>', { desc = "Insert date" })

-- Cursor does not jump back on yank
vim.keymap.set("v", "y", "ygv<Esc>", { desc = "Yank", remap = true })

-- Esc to exit terminal mode
vim.keymap.set('t', '<Esc>', '<C-\\><C-n>')

-- buffers
vim.keymap.set("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Prev buffer" })
vim.keymap.set("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader><leader>", "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
vim.keymap.set("n", "<leader>bb", "<cmd>e $MYVIMRC | cd %:p:h<cr>", { desc= "Edit init.lua" })
vim.keymap.set("n", "<leader>bd", "<cmd>bd<cr>", { desc = "Delete buffer" })
vim.keymap.set("n", "<leader>bs", "<cmd>split<cr>", { desc = "Open split" })
vim.keymap.set("n", "<leader>bv", "<cmd>vs<cr>", { desc = "Open vertical split" })

-- Change to Normal mode by pressing "jj" in quick succession
vim.keymap.set("i", "jj", "<esc>", { desc = "Change to Normal mode" })

-- Resize windows using <Ctrl + Arrow keys>
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Increase window width" })

-- Save and close buffer
vim.api.nvim_create_user_command('Wbd', 'write <bar> bdelete', {})
-- Save and source file
vim.api.nvim_create_user_command('Wso', 'write <bar> source', {})

-- Write as sudo using tee invocation
--vim.keymap.set("c", "w!!", "w !sudo tee > /dev/null %", { silent = true, desc = "Write as Sudo" })
vim.api.nvim_create_user_command("Wsu", "w !sudo tee > /dev/null %", {})

-- Function to increment boolean or number under cursor
function _G.IncrementValue()
  -- Get the word under the cursor
  local word = vim.fn.expand('<cword>')

  -- Check if the word is 'false', and increment it if so
  if word == 'false' then
    vim.api.nvim_command('normal! ciwtrue')
  elseif tonumber(word) then
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-a>', true, true, true), 'n', false)
  end
end

-- Function to decrement boolean or number under cursor
function _G.DecrementValue()
  -- Get the word under the cursor
  local word = vim.fn.expand('<cword>')

  -- Check if the word is 'true', and decrement it if so
  if word == 'true' then
    vim.api.nvim_command('normal! ciwfalse')
  elseif tonumber(word) then
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<C-x>', true, true, true), 'n', false)
  end
end

-- Map Ctrl-A and Ctrl-X to the functions
vim.api.nvim_set_keymap('n', '<C-a>', ':lua IncrementValue()<CR>', {noremap = true, silent=true})
vim.api.nvim_set_keymap('n', '<C-x>', ':lua DecrementValue()<CR>', {noremap = true, silent=true})

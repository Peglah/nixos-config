local autocmd = vim.api.nvim_create_autocmd
local augroup = function(name)
  return vim.api.nvim_create_augroup("augroup" .. name, { clear = true })
end

-- Save and load text folding
vim.cmd([[ autocmd BufWritePost * mkview ]])
vim.cmd([[ autocmd BufReadPost * silent! loadview ]])

autocmd("TextYankPost", {
  desc = "Highlight the yanked text for a specified time.",
  group = augroup("yank_highlight"),
  callback = function()
    vim.highlight.on_yank({ timeout = 250 }) -- Keep the highlight for 250ms after yanking.
  end,
})

-- Enable relative line numbers in the help
vim.cmd([[ autocmd FileType help setlocal relativenumber ]])

-- Disables automatic commenting on newline
vim.cmd([[ autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o ]])

-- Resize splits if window got resized
autocmd({ "VimResized" }, {
  callback = function()
    vim.cmd("tabdo wincmd =")
  end,
})

-- Disable semantic highlight
vim.api.nvim_create_autocmd("LspAttach", {
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    client.server_capabilities.semanticTokensProvider = nil
  end,
})

vim.api.nvim_create_autocmd("WinEnter", {
  callback = function()
    local floating = vim.api.nvim_win_get_config(0).relative ~= ""
    vim.diagnostic.config({
      virtual_text = floating,
      virtual_lines = not floating,
    })
  end,
})


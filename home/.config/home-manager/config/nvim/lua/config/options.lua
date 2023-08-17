local undodir = vim.fn.expand("~") .. "/.nvim_undo"
if not vim.fn.isdirectory(undodir) then
    vim.fn.mkdir(undodir, "", 0700)
end
vim.o.undodir = undodir
vim.o.undofile = true

vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- Suppress intro message
vim.opt.shortmess:append("I")
-- Set title to: filename [+=-] (path) - NVIM
vim.opt.title = true
-- Enables the window bar and determines its contents
vim.opt.winbar = "%f"
-- Enable line number and relative line numbers
vim.opt.relativenumber = true
-- Signs share colimns with line numbers
vim.o.signcolumn = "number"
-- Maximum width of text that is being inserted.
--vim.opt.textwidth = 80
-- Highlight column after 'textwidth'
--vim.opt.colorcolumn = '+1'
-- The last window will have a status line always and ONLY the last window
vim.opt.laststatus = 3
-- Hide mode since lualine handles this
vim.opt.showmode = false
-- Use system clipboard
vim.o.clipboard = 'unnamedplus'
-- Use clip if WSL
local f = io.open("/proc/version", "rb")
if f then
  local content = f:read("*all")
  f:close()

  if string.find(content, "microsoft") then
    vim.g.clipboard = {
      name = 'WslClipboard',
      copy = {
        ['+'] = 'clip.exe',
        ['*'] = 'clip.exe',
      },
      paste = {
        ['+'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
        ['*'] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
      },
      cache_enabled = 0,
    }
  end
end

-- Disable mouse
vim.opt.mouse={ i = false, n = false, v = false }
-- Enable autocompletion
vim.opt.wildmode = { 'longest:list', 'full' }
-- Finding files
vim.opt.path = vim.opt.path + ",**"
-- Set font
--vim.cmd([[ set guifont=FiraCode\ NFM:h12 ]], false)
-- Fancy colors
vim.opt.termguicolors = true
vim.opt.background = "dark"

-- Ignoring case in a pattern
vim.opt.ignorecase = true
-- Override the 'ignorecase' option if the search pattern contains upper case characters
vim.opt.smartcase = true

---- On pressing tab, insert 2 spaces
--vim.opt.expandtab = true
---- show existing tab with 2 spaces width
--vim.opt.tabstop = 2
--vim.opt.softtabstop = 2
---- when indenting with '>', use 2 spaces width
--vim.opt.shiftwidth = 2
-- Use a dialog when an operation has to be confirmed.
vim.opt.confirm = true
-- netrw - suppress the banner
vim.g.netrw_banner = 0
-- netrw - tree style listing
vim.g.netrw_liststyle = 3
-- netrw - show line numbers
vim.g.netrw_bufsettings = 'noma nomod nu nobl nowrap ro'

-- suppress colorschemes that are not used
vim.cmd([[ set wildignore+=zellner.vim,torte.vim,slate.vim,shine.vim,ron.vim,quiet.vim,peachpuff.vim,pablo.vim,murphy.vim,morning.vim,lunaperche.vim,koehler.vim,industry.vim,habamax.vim,evening.vim,elflord.vim,desert.vim,delek.vim,darkblue.vim,blue.vim ]])

-- indent-blankline
vim.api.nvim_set_hl(0, 'IndentBlanklineIndent1', { fg = vim.g.terminal_color_1, nocombine = true })
vim.api.nvim_set_hl(0, 'IndentBlanklineIndent2', { fg = vim.g.terminal_color_2, nocombine = true })
vim.api.nvim_set_hl(0, 'IndentBlanklineIndent3', { fg = vim.g.terminal_color_3, nocombine = true })
vim.api.nvim_set_hl(0, 'IndentBlanklineIndent4', { fg = vim.g.terminal_color_4, nocombine = true })
vim.api.nvim_set_hl(0, 'IndentBlanklineIndent5', { fg = vim.g.terminal_color_5, nocombine = true })
vim.api.nvim_set_hl(0, 'IndentBlanklineIndent6', { fg = vim.g.terminal_color_6, nocombine = true })

return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  config = function()

    local wk = require('which-key')
    wk.register({
      ['<leader>'] = { name = '+leader' },
      ['<leader>c'] = { name = '+ChatGPT' },
      ['<leader>cb'] = { name = '+Backseat' },
      ['<leader>f'] = { name = '+Telescope' },
      ['<leader>l'] = { name = '+Lazy' },
      ['<leader>m'] = { name = '+Minimap' },

      -- Lazy
      ['<leader>lh'] = { '<cmd>Lazy home<CR>', 'home' },
      ['<leader>li'] = { '<cmd>Lazy install<CR>', 'install' },
      ['<leader>lu'] = { '<cmd>Lazy update<CR>', 'update' },
      ['<leader>ls'] = { '<cmd>Lazy sync<CR>', 'sync' },
      ['<leader>lx'] = { '<cmd>Lazy clean<CR>', 'clean' },
      ['<leader>lc'] = { '<cmd>Lazy check<CR>', 'check' },
      ['<leader>ll'] = { '<cmd>Lazy log<CR>', 'log' },
      ['<leader>lr'] = { '<cmd>Lazy restore<CR>', 'restore' },
      ['<leader>lp'] = { '<cmd>Lazy profile<CR>', 'profile' },
      ['<leader>ld'] = { '<cmd>Lazy debug<CR>', 'debug' },
      ['<leader>l?'] = { '<cmd>Lazy help<CR>', 'help' },

      -- LSP
      ['K'] = { '<cmd>lua require("pretty_hover").hover()<cr>', 'Hover' },
      ['gd'] = { '<cmd>lua vim.lsp.buf.definition()<cr>', 'Goto Definition' },
      ['gD'] = { '<cmd>lua vim.lsp.buf.declaration()<cr>', 'Goto Declaration' },
      ['gi'] = { '<cmd>lua vim.lsp.buf.implementation()<cr>', 'Goto Implementation' },
      ['go'] = { '<cmd>lua vim.lsp.buf.type_definition()<cr>', 'Goto Type Definition' },
      ['gr'] = { '<cmd>lua vim.lsp.buf.references()<cr>', 'References' },
--      ['c-k'] = { '<cmd>lua vim.lsp.buf.signature_help()<cr>', 'Signature Help' }, -- should be only insert mode
      ['<F2>'] = { '<cmd>lua vim.lsp.buf.rename()<cr>', 'Rename' },
      ['<F4>'] = { '<cmd>lua vim.lsp.buf.code_action()<cr>', 'Code Action' },
      ['gl'] = { '<cmd>lua vim.diagnostic.open_float()<cr>', 'Line Diagnostics' },
      ['[d'] = { '<cmd>lua vim.diagnostic.goto_prev()<cr>', 'Previous Diagnostics' },
      [']d'] = { '<cmd>lua vim.diagnostic.goto_next()<cr>', 'Next Diagnostic' },
    })

    vim.o.timeout = true
    vim.o.timeoutlen = 1000

    require('which-key').setup({
      plugins = {
        marks = true, -- shows a list of your marks on ' and `
        registers = true, -- shows your registers on ' in NORMAL or <C-r> in INSERT mode
        spelling = {
          enabled = false, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
          suggestions = 20, -- how many suggestions should be shown in the list?
        },
        -- the presets plugin, adds help for a bunch of default keybindings in Neovim
        -- No actual key bindings are created
        presets = {
          operators = true, -- adds help for operators like d, y, ... and registers them for motion / text object completion
          motions = true, -- adds help for motions
          text_objects = true, -- help for text objects triggered after entering an operator
          windows = true, -- default bindings on <c-w>
          nav = true, -- misc bindings to work with windows
          z = true, -- bindings for folds, spelling and others prefixed with z
          g = true, -- bindings for prefixed with g
        },
      },
      -- add operators that will trigger motion and text object completion
      -- to enable all native operators, set the preset / operators plugin above
      operators = { gc = 'Comments' },
      key_labels = {
        -- override the label used to display some keys. It doesn't effect WK in any other way.
        -- For example:
        -- ['<space>'] = 'SPC',
        -- ['<cr>'] = 'RET',
        -- ['<tab>'] = 'TAB',
      },
      icons = {
        breadcrumb = '»', -- symbol used in the command line area that shows your active key combo
        separator = '➜', -- symbol used between a key and it's label
        group = '+', -- symbol prepended to a group
      },
      popup_mappings = {
        scroll_down = '<c-d>', -- binding to scroll down inside the popup
        scroll_up = '<c-u>', -- binding to scroll up inside the popup
      },
      window = {
        border = 'single', -- none, single, double, shadow
        position = 'bottom', -- bottom, top
        margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
        padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
        winblend = 0
      },
      layout = {
        height = { min = 4, max = 25 }, -- min and max height of the columns
        width = { min = 20, max = 50 }, -- min and max width of the columns
        spacing = 3, -- spacing between columns
        align = 'left', -- align columns left, center or right
      },
      ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
      hidden = { '<silent>', '<cmd>', '<Cmd>', '<CR>', 'call', 'lua', '^:', '^ '}, -- hide mapping boilerplate
      show_help = true, -- show help message on the command line when the popup is visible
      show_keys = true, -- show the currently pressed key and its label as a message in the command line
      triggers = 'auto', -- automatically setup triggers
      -- triggers = {'<leader>'} -- or specify a list manually
      triggers_blacklist = {
        -- list of mode / prefixes that should never be hooked by WhichKey
        -- this is mostly relevant for key maps that start with a native binding
        -- most people should not need to change this
        i = { 'j', 'k' },
        v = { 'j', 'k' },
      },
      -- disable the WhichKey popup for certain buf types and file types.
      -- Disabled by deafult for Telescope
      disable = {
        buftypes = {},
        filetypes = { 'TelescopePrompt' },
      },
    }) end
  }

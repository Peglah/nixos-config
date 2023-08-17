local copilot_indicator = function()
  local client = vim.lsp.get_active_clients({ name = "copilot" })[1]
  if client == nil then
    return ""
  end

  if vim.tbl_isempty(client.requests) then
    return "⠶" -- default icon whilst copilot is idle
  end

  local spinners = { "⣾", "⣽", "⣻", "⢿", "⡿", "⣟", "⣯", "⣷" }
  local ms = vim.loop.hrtime() / 1000000
  local frame = math.floor(ms / 120) % #spinners

  return spinners[frame + 1]
end

return {
  'nvim-lualine/lualine.nvim',
  dependencies = { 'nvim-tree/nvim-web-devicons', lazy = true },

  opts = {
    options = {
      globalstatus = true,
    },
    sections = {
      --lualine_a = {'mode'},
      --lualine_b = {'branch', 'diff', 'diagnostics'},
      --lualine_c = {'filename'},
      lualine_c = { copilot_indicator },
      --lualine_x = {'encoding', 'fileformat', 'filetype'},
      --lualine_y = {'progress'},
      lualine_y = {},
      --lualine_z = {'location'}
    },
    winbar = {
      lualine_a = { {
        'buffers',
        mode = 4,
        max_length = vim.o.columns * 2 / 3, }
      },
      lualine_x = { require("lsp-progress").progress },
      lualine_y = { {
        require('lazy.status').updates,
        cond = require('lazy.status').has_updates,
        color = { fg = '#FE8019' }, }
      },
      lualine_z = { { 'datetime', style = "%H:%M" }
      }
    }
  }
}

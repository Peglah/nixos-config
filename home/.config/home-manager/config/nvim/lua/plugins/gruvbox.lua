return {
  'ellisonleao/gruvbox.nvim', -- Theme
  lazy = false, -- make sure we load this during startup if it is your main colorscheme
  priority = 1000, -- make sure to load this before all the other start plugins
  -- setup must be called before loading the colorscheme

  config = function() require("gruvbox").setup({
    undercurl = true,
    underline = true,
    bold = true,
    italic = {
      strings = false,
      comments = false,
      operators = false,
      folds = false,
    },
    strikethrough = true,
    invert_selection = false,
    invert_signs = false,
    invert_tabline = false,
    invert_intend_guides = false,
    inverse = true, -- invert background for search, diffs, statuslines and errors
    contrast = '', -- can be 'hard', 'soft' or empty string
    palette_overrides = {},
    overrides = {
      Todo = { fg = '#ebdbb2', bg = '#282828', bold = true, italic = false },
    },
    dim_inactive = false,
    transparent_mode = false,

    pcall(function() vim.cmd('colorscheme gruvbox') end)
  }) end
}

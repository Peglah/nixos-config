return
  { 'folke/twilight.nvim',
  event = "User ColorSchemeLoad",

  config = function() require('twilight').setup() end
}

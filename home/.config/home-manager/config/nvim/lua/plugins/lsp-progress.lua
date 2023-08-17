return {
  'linrongbin16/lsp-progress.nvim',
  event = { 'VimEnter' },
  dependencies = { 'nvim-tree/nvim-web-devicons', lazy = true },
  config = function()
    require('lsp-progress').setup()
  end
}

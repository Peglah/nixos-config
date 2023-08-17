return {
  'nvim-treesitter/nvim-treesitter',
  version = false, -- last release is way too old and doesn't work on Windows
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },

  opts = {
    -- A list of parser names, or 'all'
    --  ensure_installed = { 'c', 'lua', 'rust' },
    ensure_installed = { 'markdown', 'lua', 'vim', 'vimdoc' },

    -- Install parsers synchronously (only applied to `ensure_installed`)
    sync_install = true,

    -- Automatically install missing parsers when entering buffer
    auto_install = true,

    highlight = {
      -- `false` will disable the whole extension
      enable = true,

      -- Setting this to true will run `:h syntax` and tree-sitter at the same time.
      -- Set this to `true` if you depend on 'syntax' being enabled (like for indentation).
      -- Using this option may slow down your editor, and you may see some duplicate highlights.
      -- Instead of true it can also be a list of languages
      additional_vim_regex_highlighting = false,
    },

    indent = {
      -- enable indentation
      enable = true
    },

    -- HiPhish/nvim-ts-rainbow2
    rainbow = {
      enable = true,
      hlgroups = {
        'GruvboxRed',
        'GruvboxYellow',
        'GruvboxBlue',
        'GruvboxOrange',
        'GruvboxGreen',
        'GruvboxPurple',
        'GruvboxAqua'
      },
    },
  },

  config = function(_, opts)
    require("nvim-treesitter.configs").setup(opts)
  end
}

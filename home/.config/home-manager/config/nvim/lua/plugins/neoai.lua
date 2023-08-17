return {
  "Bryley/neoai.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  enabled = vim.fn.getenv("OPENAI_API_KEY") ~= vim.NIL,
  cmd = {
    "NeoAI",
    "NeoAIOpen",
    "NeoAIClose",
    "NeoAIToggle",
    "NeoAIContext",
    "NeoAIContextOpen",
    "NeoAIContextClose",
    "NeoAIInject",
    "NeoAIInjectCode",
    "NeoAIInjectContext",
    "NeoAIInjectContextCode",
  },
  keys = {
    { "<leader>ct", "<cmd>NeoAIToggle<cr>", desc = "NeoAIToggle" },
    { "<leader>cc", "<cmd>NeoAI<cr>", desc = "NeoAI" },
  },

  opts = {
    -- Options go here
  },
}

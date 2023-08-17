return {
  "james1236/backseat.nvim",
  enabled = vim.fn.getenv("OPENAI_API_KEY") ~= vim.NIL,
  cmd = {
    'Backseat',
    'BackseatAsk' },
  keys = {
    { "<leader>cbb", "<cmd>Backseat<cr>", desc = "Backseat" },
    { "<leader>cbc", "<cmd>BackseatClear<cr>", desc = "BackseatClear" },
    { "<leader>cbl", "<cmd>BackseatClearLine<cr>", desc = "BackseatClearLine" }, },


  opts = {
    -- Alternatively, set the env var $OPENAI_API_KEY by putting "export OPENAI_API_KEY=sk-xxxxx" in your ~/.bashrc
    openai_api_key = vim.env.OPENAI_API_KEY, -- Get yours from platform.openai.com/account/api-keys
    openai_model_id = 'gpt-3.5-turbo', --gpt-4 (If you do not have access to a model, it says "The model does not exist")

    -- split_threshold = 100,
    -- additional_instruction = "Respond snarkily", -- (GPT-3 will probably deny this request, but GPT-4 complies)
    -- highlight = {
    --     icon = '', -- ''
    --     group = 'Comment',
  }
}

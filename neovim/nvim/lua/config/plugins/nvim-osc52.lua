return {
  "ojroques/nvim-osc52",
  cond = function()
    return vim.env.SSH_CONNECTION ~= nil
  end,
  config = function()
    local osc52 = require("osc52")

    osc52.setup {}

    vim.keymap.set("n", "<leader>y", osc52.copy_operator, { expr = true, desc = "Yank to macOS clipboard" })
    vim.keymap.set("v", "<leader>y", osc52.copy_visual, { desc = "Yank to macOS clipboard" })
  end,
}


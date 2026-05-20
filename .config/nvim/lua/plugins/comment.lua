return {
  "numToStr/Comment.nvim",
  keys = {
    { "<C-_>", mode = "n", desc = "Toggle comment line" },
    { "<C-_>", mode = "v", desc = "Toggle comment selection" },
  },
  config = function(_, opts)
    require("Comment").setup(opts)
    local api = require("Comment.api")
    vim.keymap.set("n", "<C-_>", api.toggle.linewise.current, { desc = "Toggle comment line" })
    vim.keymap.set("v", "<C-_>", function()
      vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, false, true), "x", false)
      api.toggle.linewise(vim.fn.visualmode())
    end, { desc = "Toggle comment selection" })
  end,
}

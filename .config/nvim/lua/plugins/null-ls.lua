return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvimtools/none-ls-extras.nvim",
  },
  ft = "go",
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.goimports.with({
          extra_args = { "-tabwidth", "4", "-tabs" },
        }),
      },
    })
  end,
}

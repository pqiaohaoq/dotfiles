return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvimtools/none-ls-extras.nvim",
  },
  ft = { "go", "python" },
  config = function()
    local null_ls = require("null-ls")

    null_ls.setup({
      sources = {
        null_ls.builtins.formatting.goimports.with({
          extra_args = { "-tabwidth", "4", "-tabs" },
        }),
        null_ls.builtins.formatting.black,
      },
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "go",
      callback = function()
        vim.bo.expandtab = false
        vim.bo.shiftwidth = 4
        vim.bo.tabstop = 4
      end,
    })

    vim.api.nvim_create_autocmd("FileType", {
      pattern = "python",
      callback = function()
        vim.bo.expandtab = true
        vim.bo.shiftwidth = 4
        vim.bo.tabstop = 4
      end,
    })
  end,
}

return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvimtools/none-ls-extras.nvim",
  },
  ft = { "go", "python" },
  config = function()
    local null_ls = require("null-ls")
    local formatting_group = vim.api.nvim_create_augroup("formatting", { clear = true })

    null_ls.setup({
      on_attach = function(client, bufnr)
        if client.supports_method("textDocument/formatting") then
          vim.api.nvim_clear_autocmds({ buffer = bufnr, group = formatting_group })
          vim.api.nvim_create_autocmd("BufWritePre", {
            buffer = bufnr,
            group = formatting_group,
            callback = function()
              vim.lsp.buf.format({ bufnr = bufnr })
            end,
          })
        end
      end,
      sources = {
        null_ls.builtins.formatting.goimports.with({
          extra_args = { "-tabwidth", "4", "-tabs" },
        }),
        require("none-ls.diagnostics.ruff"),
        require("none-ls.formatting.ruff_format").with({
          extra_args = { "--line-length=150" },
        }),
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

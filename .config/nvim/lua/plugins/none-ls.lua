return {
  "nvimtools/none-ls.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  ft = { "go" }, -- 仅在打开 Go 文件时加载
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
          -- 从 go.mod 动态读取模块路径，自动区分本地包
          extra_args = function()
            local gomod = vim.fn.findfile("go.mod", ".;")
            if gomod == "" then
              return {}
            end
            for line in io.lines(gomod) do
              local module = line:match("^module%s+(.+)$")
              if module then
                return { "-local", module }
              end
            end
            return {}
          end,
        }),
      },
    })
  end,
}

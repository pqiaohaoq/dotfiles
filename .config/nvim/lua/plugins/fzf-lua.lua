return {
  "ibhagwan/fzf-lua",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    require("fzf-lua").setup({
      files = {
        cmd = "fd",
        fd_opts = "--hidden --exclude=.git --type=f",
      },
      grep = {
        cmd = "rg",
        args = "--hidden --no-ignore-vcs --line-number --column",
        silent = true,
        actions = {
          ["default"] = function(selected, opts)
            for _, s in ipairs(selected) do
              local file, line, col = s:match("^([^:]+):(%d+):(%d+):")
              if file and line then
                vim.cmd("tabedit " .. file)
                vim.api.nvim_win_set_cursor(0, { tonumber(line), tonumber(col or 0) })
              else
                vim.cmd("tabedit " .. s)
              end
            end
          end,
        },
      },
      lsp = {
        jump1 = true,
        actions = {
          ["default"] = function(selected, opts)
            for _, s in ipairs(selected) do
              local file, line, col = s:match("^([^:]+):(%d+):(%d+):")
              if file and line then
                vim.cmd("tabedit " .. file)
                vim.api.nvim_win_set_cursor(0, { tonumber(line), tonumber(col or 0) })
              else
                vim.cmd("tabedit " .. s)
              end
            end
          end,
        },
      },
      defaults = {
        file_icons = false,
        git_icons = false,
      },
      actions = {
        files = {
          ["default"] = function(selected, opts)
            for _, s in ipairs(selected) do
              vim.cmd("tabedit " .. s)
            end
          end,
        },
      },
    })
    vim.keymap.set("n", "<Leader>ff", "<cmd>FzfLua files<cr>")
    vim.keymap.set("n", "<Leader>fr", "<cmd>FzfLua live_grep<cr>")
  end,
}

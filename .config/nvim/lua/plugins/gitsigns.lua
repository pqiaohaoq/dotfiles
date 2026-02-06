return {
  "lewis6991/gitsigns.nvim",
  config = function()
    require("gitsigns").setup({
      signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "-" },
        topdelete = { text = "^" },
        changedelete = { text = "~" },
      },
      signcolumn = true,
      current_line_blame = true,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 1000,
        ignore_whitespace = false,
      },
      current_line_blame_formatter = "<author>, <author_time:%Y/%m/%d %H:%M:%S> - <summary>",
    })
    vim.keymap.set("n", "]g", function() require("gitsigns").next_hunk() end)
    vim.keymap.set("n", "[g", function() require("gitsigns").prev_hunk() end)
    vim.keymap.set("n", "<Leader>gt", "<cmd>Gitsigns setqflist<cr>")
    vim.keymap.set("n", "<Leader>gd", "<cmd>Gitsigns diffthis<cr>")
  end,
}

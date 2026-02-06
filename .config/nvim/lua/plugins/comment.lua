return {
  "numToStr/Comment.nvim",
  config = function()
    require("Comment").setup({
      mappings = {
        basic = false,
        extra = false,
      },
      padding = true,
      sticky = true,
      ignore = "^$",
      toggler = {
        line = "gcc",
        block = "gbc",
      },
      opleader = {
        line = "gc",
        block = "gb",
      },
      pre_hook = nil,
      post_hook = nil,
    })
    local comment_key = vim.loop.os_uname().sysname == "Darwin" and "<D-/>" or "<C-_>"
    vim.keymap.set("n", comment_key, function()
      return vim.fn.mode() == "n" and "<Plug>(comment_toggle_linewise_current)" or "<Plug>(comment_toggle_linewise_current)"
    end, { expr = true })
    vim.keymap.set("v", comment_key, "<Plug>(comment_toggle_linewise_visual)")
  end,
}

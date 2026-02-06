return {
  "easymotion/vim-easymotion",
  config = function()
    vim.g.EasyMotion_do_mapping = 0
    vim.g.EasyMotion_smartcase = 1
    vim.keymap.set("n", "s", "<Plug>(easymotion-s)")
    vim.keymap.set("n", "<Leader><Leader>w", "<Plug>(easymotion-bd-w)")
  end,
}

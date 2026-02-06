require("config.lazy")

vim.opt.number = true
vim.opt.backup = false
vim.opt.writebackup = false
vim.opt.swapfile = false
vim.opt.wrap = true
vim.opt.linebreak = true
vim.opt.syntax = "on"
vim.opt.cursorline = true
vim.opt.termguicolors = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.smartindent = true
vim.opt.autoindent = true
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.hlsearch = true
vim.opt.mouse = "a"
vim.opt.clipboard = "unnamedplus"
vim.opt.showmode = true
vim.opt.showcmd = false
vim.opt.wildmenu = true
vim.opt.scrolloff = 8
vim.opt.sidescrolloff = 8
vim.opt.signcolumn = "yes"
vim.opt.showmatch = true
vim.opt.splitright = true
vim.opt.splitbelow = true
vim.opt.updatetime = 100
vim.opt.timeoutlen = 500
vim.opt.encoding = "utf-8"
vim.opt.fileencoding = "utf-8"

vim.keymap.set("n", "]t", "<cmd>tabnext<cr>")
vim.keymap.set("n", "[t", "<cmd>tabprevious<cr>")
vim.keymap.set("n", "<Leader>t1", "<cmd>tabfirst<cr>")
vim.keymap.set("n", "<Leader>t2", "2gt")
vim.keymap.set("n", "<Leader>t3", "3gt")
vim.keymap.set("n", "<Leader>t4", "4gt")
vim.keymap.set("n", "<Leader>t5", "5gt")
vim.keymap.set("n", "<Leader>t6", "6gt")
vim.keymap.set("n", "<Leader>t7", "7gt")
vim.keymap.set("n", "<Leader>t8", "8gt")
vim.keymap.set("n", "<Leader>t9", "9gt")

vim.keymap.set("n", "H", "<C-w>h")
vim.keymap.set("n", "J", "<C-w>j")
vim.keymap.set("n", "K", "<C-w>k")
vim.keymap.set("n", "L", "<C-w>l")

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<Leader>k", vim.lsp.buf.hover)

vim.keymap.set("n", "gd", function() require("fzf-lua").lsp_definitions() end)
vim.keymap.set("n", "gr", function() require("fzf-lua").lsp_references() end)
vim.keymap.set("n", "gy", function() require("fzf-lua").lsp_typedefs() end)
vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename)

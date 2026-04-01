-- Git blame 浮窗
vim.keymap.set("n", "<Leader>gb", function()
  local file = vim.fn.expand("%:p")
  local line = vim.api.nvim_win_get_cursor(0)[1]
  local blame = vim.fn.systemlist(string.format("git blame -L %d,%d -- %s", line, line, vim.fn.shellescape(file)))
  if vim.v.shell_error ~= 0 then
    vim.notify(blame[1] or "git blame failed", vim.log.levels.ERROR)
    return
  end
  local commit = blame[1]:match("^(%x+)")
  local author = blame[1]:match("%((.-)%s+%d")
  local date = blame[1]:match("%d%d%d%d%-%d%d%-%d%d")
  local lines = { string.format("%s %s %s", commit:sub(1, 7), author or "", date or "") }
  if commit and #commit >= 7 then
    local msg = vim.fn.systemlist(string.format("git log --format=%%B -1 %s", commit))
    if vim.v.shell_error == 0 then
      for _, m in ipairs(msg) do
        if m ~= "" then
          table.insert(lines, m)
        end
      end
    end
  end
  local buf = vim.api.nvim_create_buf(false, true)
  vim.api.nvim_buf_set_lines(buf, 0, -1, false, lines)
  vim.api.nvim_buf_set_option(buf, "bufhidden", "wipe")
  local width = math.max(unpack(vim.tbl_map(function(l) return #l end, lines)))
  local height = #lines
  vim.api.nvim_open_win(buf, false, {
    relative = "editor",
    row = math.floor((vim.o.lines - height) / 2),
    col = math.floor((vim.o.columns - width) / 2),
    width = width,
    height = height,
    style = "minimal",
    border = "rounded",
  })
  vim.cmd(string.format(
    "autocmd CursorMoved,CursorMovedI,WinLeave <buffer> ++once lua vim.api.nvim_buf_delete(%d, { force = true })",
    buf
  ))
end, { desc = "Git blame float" })

-- Git hunk 跳转
vim.keymap.set("n", "]g", function()
  require("gitsigns").next_hunk()
end, { desc = "Next git hunk" })

vim.keymap.set("n", "[g", function()
  require("gitsigns").prev_hunk()
end, { desc = "Prev git hunk" })

-- 诊断跳转
vim.keymap.set("n", "]d", function()
  vim.diagnostic.jump({ count = 1, float = true })
end, { desc = "Next diagnostic" })

vim.keymap.set("n", "[d", function()
  vim.diagnostic.jump({ count = -1, float = true })
end, { desc = "Prev diagnostic" })

-- Neo-tree
vim.keymap.set("n", "<Leader>e", "<Cmd>Neotree toggle<CR>", { desc = "Toggle neo-tree" })
vim.keymap.set("n", "<Leader>fe", "<Cmd>Neotree focus<CR>", { desc = "Focus neo-tree" })

-- LSP 重命名
vim.keymap.set("n", "<Leader>rn", vim.lsp.buf.rename, { desc = "Rename symbol" })

-- LSP 跳转
vim.keymap.set("n", "gd", vim.lsp.buf.definition, { desc = "Go to definition" })
vim.keymap.set("n", "gy", vim.lsp.buf.type_definition, { desc = "Go to type definition" })
vim.keymap.set("n", "gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
vim.keymap.set("n", "gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
vim.keymap.set("n", "gr", vim.lsp.buf.references, { desc = "Go to references" })

-- 窗口移动
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "Move to below window" })
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "Move to above window" })
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

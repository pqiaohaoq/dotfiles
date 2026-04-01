-- 行号
vim.opt.number = true -- 显示行号

-- 备份/swap
vim.opt.backup = false -- 禁用备份文件（~后缀）
vim.opt.writebackup = false -- 写入时禁用备份
vim.opt.swapfile = false -- 禁用 .swp 文件
vim.opt.undofile = true -- 持久化撤销历史，存储在 ~/.local/state/nvim/undo/

-- 换行
vim.opt.wrap = false -- 长行不自动折行显示
vim.opt.linebreak = true -- 若 wrap 开启，在单词边界处折行（不断词）

-- 缩进
vim.opt.tabstop = 4 -- Tab 键显示为 4 个空格宽度
vim.opt.shiftwidth = 4 -- 缩进层级为 4 个空格
vim.opt.expandtab = true -- 按 Tab 插入空格而非 \t
vim.opt.smartindent = true -- 基于 { } 等结构自动缩进
vim.opt.autoindent = true -- 新行继承上一行的缩进

-- 搜索
vim.opt.ignorecase = true -- 搜索默认忽略大小写
vim.opt.smartcase = true -- 搜索词包含大写字母时区分大小写
vim.opt.incsearch = true -- 输入时实时跳转到匹配位置
vim.opt.hlsearch = true -- 高亮所有搜索结果

-- 编辑体验
vim.opt.mouse = "a" -- 启用鼠标支持
vim.opt.clipboard = "unnamedplus" -- 系统剪贴板共享
vim.opt.termguicolors = true -- 24 位真彩色（主题必需）
vim.opt.cursorline = true -- 高亮当前所在行
vim.opt.scrolloff = 8 -- 光标距屏幕顶/底至少保留 8 行
vim.opt.sidescrolloff = 8 -- 光标距屏幕左/右至少保留 8 列
vim.opt.signcolumn = "no" -- 关闭左侧标记列
vim.opt.updatetime = 250 -- 触发 CursorHold 事件的时间（ms）
vim.opt.timeoutlen = 500 -- Leader 后等待后续按键的超时（ms）
vim.opt.splitright = true -- :vsplit 在右侧打开新窗口
vim.opt.splitbelow = true -- :split 在下方打开新窗口
vim.opt.showmode = false -- 不显示模式提示（由状态栏插件替代）
vim.opt.completeopt = "menu,menuone,noselect" -- 补全：弹出菜单、不自动选中
vim.opt.wildmenu = true -- 命令行 Tab 补全增强
vim.opt.encoding = "utf-8" -- 内部编码
vim.opt.fileencoding = "utf-8" -- 文件编码

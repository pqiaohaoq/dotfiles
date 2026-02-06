local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

vim.g.mapleader = " "

require("lazy").setup({
  {
    "shaunsingh/nord.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("nord").set()
    end,
  },
  {
    "junegunn/vim-easy-align",
    config = function()
      vim.keymap.set("x", "ga", "<Plug>(EasyAlign)")
      vim.keymap.set("n", "ga", "<Plug>(EasyAlign)")
    end,
  },
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
    },
    config = function()
      require("neo-tree").setup({
        close_if_last_window = false,
        popup_border_style = "rounded",
        enable_git_status = true,
        enable_diagnostics = false,
        open_files_do_not_replace_types = { "terminal", "trouble", "qf" },
        sort_case_insensitive = true,
        default_component_configs = {
          container = { enable_character_fade = true },
          indent = { indent_size = 2, padding = 1 },
          icon = { enabled = false },
          name = { trailing_slash = false, use_git_status_colors = true },
          git_status = {
            symbols = {
              added = "+",
              modified = "*",
              deleted = "-",
              renamed = "→",
              untracked = "?",
              ignored = "!",
              staged = "s",
            }
          },
        },
        filesystem = {
          follow_current_file = { enabled = true },
          hijack_netrw_behavior = "open_default",
          use_libuv_file_watcher = false,
          window = {
            position = "left",
            mappings = {
              ["s"] = "open_split",
              ["v"] = "open_vsplit",
              ["t"] = "open_tabnew",
            },
          },
        },
      })
      vim.keymap.set("n", "<Space>e", "<cmd>Neotree toggle<cr>")
    end,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "nord",
          component_separators = { left = "", right = "" },
          section_separators = { left = "", right = "" },
          disabled_filetypes = { "neo-tree" },
          globalstatus = false,
        },
        sections = {
          lualine_a = { { "branch", icon = "" } },
          lualine_b = { { "filename", path = 1, icon = "" } },
          lualine_c = {},
          lualine_x = { { "encoding", icon = "" } },
          lualine_y = { { function() return string.format("%d:%d/%d", vim.fn.line("."), vim.fn.col("."), vim.fn.line("$")) end, icon = "" } },
          lualine_z = { { "diagnostics", icons_enabled = false } },
        },
        inactive_sections = {
          lualine_a = {},
          lualine_b = { { "filename", path = 1, icon = "" } },
          lualine_c = {},
          lualine_x = {},
          lualine_y = { { function() return string.format("%d:%d/%d", vim.fn.line("."), vim.fn.col("."), vim.fn.line("$")) end, icon = "" } },
          lualine_z = {},
        },
      })
    end,
  },
  {
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
      vim.keymap.set("n", "<Space>ff", "<cmd>FzfLua files<cr>")
      vim.keymap.set("n", "<Space>fr", "<cmd>FzfLua live_grep<cr>")
    end,
  },
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "→",
            package_uninstalled = "✗",
          },
        },
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "gopls", "clangd", "bashls" },
        handlers = {
          function(server_name)
            vim.lsp.enable(server_name)
          end,
        },
      })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      vim.lsp.config("gopls", {
        settings = {
          gopls = {
            analyses = {
              unusedparams = true,
            },
            staticcheck = true,
            gofumpt = true,
          },
        },
      })

      vim.lsp.config("clangd", {})

      vim.lsp.config("bashls", {})

      vim.lsp.enable("gopls")
      vim.lsp.enable("clangd")
      vim.lsp.enable("bashls")

      vim.api.nvim_create_autocmd("LspAttach", {
        group = vim.api.nvim_create_augroup("UserLspConfig", {}),
        callback = function(ev)
          vim.bo[ev.buf].omnifunc = "v:lua.vim.lsp.omnifunc"
        end,
      })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
    },
    config = function()
      local cmp = require("cmp")

      cmp.setup({
        mapping = cmp.mapping.preset.insert({
          ["<CR>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.confirm({ select = true })
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "path" },
        }, {
          { name = "buffer" },
        }),
      })
    end,
  },
  {
    "folke/trouble.nvim",
    config = function()
      require("trouble").setup({
        use_diagnostic_signs = false,
      })
      vim.keymap.set("n", "<Space>d", "<cmd>TroubleToggle document_diagnostics<cr>")
    end,
  },
  {
    "nvimtools/none-ls.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvimtools/none-ls-extras.nvim",
    },
    ft = "go",
    config = function()
      local null_ls = require("null-ls")

      null_ls.setup({
        sources = {
          null_ls.builtins.formatting.goimports,
        },
        on_attach = function(client, bufnr)
          if client.supports_method("textDocument/formatting") then
            vim.api.nvim_create_autocmd("BufWritePre", {
              buffer = bufnr,
              callback = function()
                vim.lsp.buf.format({ timeout_ms = 2000 })
              end,
            })
          end
        end,
      })
    end,
  },
  {
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
  },
  {
    "easymotion/vim-easymotion",
    config = function()
      vim.g.EasyMotion_do_mapping = 0
      vim.g.EasyMotion_smartcase = 1
      vim.keymap.set("n", "s", "<Plug>(easymotion-s)")
      vim.keymap.set("n", "<Leader><Leader>w", "<Plug>(easymotion-bd-w)")
    end,
  },
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    dependencies = { "nvim-cmp" },
    config = function()
      require("nvim-autopairs").setup({})
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
})

vim.opt.number = true              -- 显示绝对行号
vim.opt.backup = false             -- 不创建备份文件
vim.opt.writebackup = false        -- 不创建写备份
vim.opt.swapfile = false           -- 不创建交换文件
vim.opt.wrap = true                -- 自动换行
vim.opt.linebreak = true           -- 在单词边界换行
vim.opt.syntax = "on"              -- 语法高亮
vim.opt.cursorline = true          -- 高亮当前行
vim.opt.termguicolors = true       -- 启用真彩色
vim.opt.tabstop = 4                -- tab 宽度
vim.opt.shiftwidth = 4             -- 自动缩进宽度
vim.opt.expandtab = true           -- 用空格替代 tab
vim.opt.smartindent = true         -- 智能缩进
vim.opt.autoindent = true          -- 自动缩进
vim.opt.ignorecase = true          -- 忽略大小写
vim.opt.smartcase = true           -- 智能大小写（有大写字母时区分）
vim.opt.incsearch = true           -- 增量搜索
vim.opt.hlsearch = true            -- 高亮搜索结果
vim.opt.mouse = "a"                -- 启用鼠标
vim.opt.clipboard = "unnamedplus"  -- 使用系统剪贴板
vim.opt.showmode = true            -- 显示模式
vim.opt.showcmd = false            -- 不显示命令
vim.opt.wildmenu = true            -- 命令行补全增强
vim.opt.scrolloff = 8              -- 上下留 8 行
vim.opt.sidescrolloff = 8          -- 左右留 8 列
vim.opt.signcolumn = "yes"         -- 显示符号列
vim.opt.showmatch = true           -- 括号匹配高亮
vim.opt.splitright = true          -- 垂直分屏在右侧
vim.opt.splitbelow = true          -- 水平分屏在下方
vim.opt.updatetime = 100           -- 更新时间（毫秒）
vim.opt.timeoutlen = 500           -- 键映射超时
vim.opt.encoding = "utf-8"         -- 内部编码
vim.opt.fileencoding = "utf-8"     -- 文件编码

vim.keymap.set("n", "]t", "<cmd>tabnext<cr>")
vim.keymap.set("n", "[t", "<cmd>tabprevious<cr>")
vim.keymap.set("n", "<Space>t1", "<cmd>tabfirst<cr>")
vim.keymap.set("n", "<Space>t2", "2gt")
vim.keymap.set("n", "<Space>t3", "3gt")
vim.keymap.set("n", "<Space>t4", "4gt")
vim.keymap.set("n", "<Space>t5", "5gt")
vim.keymap.set("n", "<Space>t6", "6gt")
vim.keymap.set("n", "<Space>t7", "7gt")
vim.keymap.set("n", "<Space>t8", "8gt")
vim.keymap.set("n", "<Space>t9", "9gt")

vim.keymap.set("n", "H", "<C-w>h")
vim.keymap.set("n", "J", "<C-w>j")
vim.keymap.set("n", "K", "<C-w>k")
vim.keymap.set("n", "L", "<C-w>l")

vim.keymap.set("n", "[d", vim.diagnostic.goto_prev)
vim.keymap.set("n", "]d", vim.diagnostic.goto_next)
vim.keymap.set("n", "<Space>k", vim.lsp.buf.hover)

vim.keymap.set("n", "gd", function() require("fzf-lua").lsp_definitions() end)
vim.keymap.set("n", "gr", function() require("fzf-lua").lsp_references() end)
vim.keymap.set("n", "gy", function() require("fzf-lua").lsp_typedefs() end)
vim.keymap.set("n", "<Space>rn", vim.lsp.buf.rename)
vim.keymap.set("n", "<Space>do", vim.diagnostic.open_float)

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
-- example using a list of specs with the default options
vim.g.mapleader = " " -- make sure to set `mapleader` before lazy so your mappings are correct

require("lazy").setup({
	opts = {colorscheme = "gruvbox",},
	{"ellisonleao/gruvbox.nvim", lazy = false, priority = 1000, },
  "folke/which-key.nvim",
  { "folke/neoconf.nvim", cmd = "Neoconf" },
  "folke/neodev.nvim",
  "vim-airline/vim-airline",
  "vim-airline/vim-airline-themes",
  -- neotree文件树
  {
  "nvim-neo-tree/neo-tree.nvim",
  cmd = "Neotree",
  keys = {
    {
      "<leader>fe",
      function()
        require("neo-tree.command").execute({ toggle = true, dir = require("lazyvim.util").get_root() })
      end,
      desc = "Explorer NeoTree (root dir)",
    },
    {
      "<leader>fE",
      function()
        require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
      end,
      desc = "Explorer NeoTree (cwd)",
    },
    { "<leader>e", "<leader>fe", desc = "Explorer NeoTree (root dir)", remap = true },
    { "<leader>E", "<leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
  },
  deactivate = function()
    vim.cmd([[Neotree close]])
  end,
  init = function()
    vim.g.neo_tree_remove_legacy_commands = 1
    if vim.fn.argc() == 1 then
      local stat = vim.loop.fs_stat(vim.fn.argv(0))
      if stat and stat.type == "directory" then
        require("neo-tree")
      end
    end
  end,
  opts = {
    filesystem = {
      bind_to_cwd = false,
      follow_current_file = true,
    },
    window = {
      mappings = {
        ["<space>"] = "none",
      },
    },
  },
},
{
    "nvim-neorg/neorg",
    -- lazy-load on filetype  {
    "cshuaimin/ssr.nvim",
    -- init is always executed during startup, but doesn't load the plugin yet.
    init = function()
      vim.keymap.set({ "n", "x" }, "<leader>cR", function()
        -- this require will automatically load the plugin
        require("ssr").open()
      end, { desc = "Structural Replace" })
    end,
  },
  -- 用于符号对齐，格式化代码使用
  "godlygeek/tabular",
  -- coc
  {"neoclide/coc.nvim", branch = "release"},
  --高亮光标下边的单词
  "RRethy/vim-illuminate",
-- UI美化
{ "stevearc/dressing.nvim", event = "VeryLazy" },
})


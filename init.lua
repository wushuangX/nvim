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
  "vim-airline/vim-airline-themes",  -- 自动切换输入法
  "h-hg/fcitx.nvim",
  -- git集成
  "lewis6991/gitsigns.nvim",
  -- 模糊搜索
  { "nvim-telescope/telescope.nvim", dependencies = {"nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons", "BurntSushi/ripgrep" ,"sharkdp/fd", "nvim-treesitter/nvim-treesitter"}},

  -- neotree文件树
  {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies= { 
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",},
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
  -- 修改nvim的通知栏，ui美化
  "rcarriga/nvim-notify",
})


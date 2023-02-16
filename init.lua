if vim.g.vscode then
	vim.g.mapleader = "," -- make sure to set `mapleader` before lazy so your mappings are correct
else
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
	vim.g.mapleader = "," -- make sure to set `mapleader` before lazy so your mappings are correct
	-- 以上为安装lazy.nvim需要的

	-- utf8
	vim.g.encoding = "UTF-8"
	vim.o.fileencoding = "utf-8"
	-- jkhl 移动时光标周围保留8行
	vim.o.scrolloff = 5
	vim.o.sidescrolloff = 5
	-- 使用相对行号
	vim.wo.number = true
	vim.wo.relativenumber = true
	-- 高亮所在行
	vim.wo.cursorline = true
	-- 显示左侧图标指示列
	vim.wo.signcolumn = "yes"
	-- 右侧参考线，超过表示代码太长了，考虑换行
	vim.wo.colorcolumn = "80"
	-- 空格替代tab
	vim.o.expandtab = true
	vim.bo.expandtab = true
	vim.o.tabstop = 4
	vim.o.shiftwidth = 4
	-- 搜索大小写不敏感，除非包含大写
	vim.o.ignorecase = true
	vim.o.smartcase = true
	-- 搜索不要高亮
	vim.o.hlsearch = false
	-- 边输入边搜索
	vim.o.incsearch = true
	-- 当文件被外部程序修改时，自动加载
	vim.o.autoread = true
	vim.bo.autoread = true
	-- 允许隐藏被修改过的buffer
	vim.o.hidden = true
	-- 鼠标支持
	vim.o.mouse = ""
	-- smaller updatetime
	vim.o.updatetime = 300
	-- split window 从下边和右边出现
	vim.o.splitbelow = true
	vim.o.splitright = true
	-- 样式
	vim.o.background = "dark"
	vim.o.termguicolors = true
	vim.opt.termguicolors = true
	-- 永远显示 tabline
	vim.o.showtabline = 2
	-- python虚拟环境设置
	vim.g.python2_host_prog = "/home/yu/.pyenv/versions/neovim2/bin/python"
	vim.g.python3_host_prog = "/home/yu/.pyenv/versions/neovim3/bin/python"

	require("lazy").setup({
		opts = { colorscheme = "gruvbox" },
		{
			"ellisonleao/gruvbox.nvim",
			lazy = false,
			priority = 1000,
			config = function()
				vim.cmd([[colorscheme gruvbox]])
			end,
		},
		-- 撤销树
		{
			"mbbill/undotree",
			config = function()
				vim.keymap.set({ "n" }, "<leader>u", [[:UndotreeToggle<CR><C-w><C-w>]])
			end,
		},
		-- 查看按键映射
		{
			"folke/which-key.nvim",
			config = function()
				vim.o.timeout = true
				vim.o.timeoutlen = 300
				require("which-key").setup({
					-- your configuration comes here
					-- or leave it empty to use the default settings
					-- refer to the configuration section below
				})
			end,
		},
		-- 代码片段
		"rafamadriz/friendly-snippets",
		{ "folke/neoconf.nvim", cmd = "Neoconf" },
		"folke/neodev.nvim",
		-- 动画插件
		{
			"echasnovski/mini.nvim",
			version = "*",
			config = function()
				require("mini.pairs").setup() --自动配对括号
				require("mini.animate").setup()
				require("mini.surround").setup()
				require("mini.comment").setup()
				require("mini.tabline").setup()
				require("mini.indentscope").setup()
				require("mini.move").setup()
			end,
		},
		--{ 'echasnovski/mini.pairs', version = "*" },
		-- notice 美化
		{
			"folke/noice.nvim",
			event = "VeryLazy",
		},
		-- 替代airline的底栏插件
		{ "nvim-lualine/lualine.nvim", opts = { theme = "gruvbox" } },
		"lukas-reineke/indent-blankline.nvim",
		-- 开始界面
		{
			"goolord/alpha-nvim",
			event = "VimEnter",
			opts = function()
				local dashboard = require("alpha.themes.dashboard")
				local logo = [[
	    ██╗      █████╗ ███████╗██╗   ██╗██╗   ██╗██╗███╗   ███╗          Z
	    ██║     ██╔══██╗╚══███╔╝╚██╗ ██╔╝██║   ██║██║████╗ ████║      Z    
	    ██║     ███████║  ███╔╝  ╚████╔╝ ██║   ██║██║██╔████╔██║   z       
	    ██║     ██╔══██║ ███╔╝    ╚██╔╝  ╚██╗ ██╔╝██║██║╚██╔╝██║ z         
	    ███████╗██║  ██║███████╗   ██║    ╚████╔╝ ██║██║ ╚═╝ ██║
	    ╚══════╝╚═╝  ╚═╝╚══════╝   ╚═╝     ╚═══╝  ╚═╝╚═╝     ╚═╝
	    ]]

				dashboard.section.header.val = vim.split(logo, "\n")
				dashboard.section.buttons.val = {
					dashboard.button("f", " " .. " Find file", ":Telescope find_files <CR>"),
					dashboard.button("n", " " .. " New file", ":ene <BAR> startinsert <CR>"),
					dashboard.button("r", " " .. " Recent files", ":Telescope oldfiles <CR>"),
					dashboard.button("g", " " .. " Find text", ":Telescope live_grep <CR>"),
					dashboard.button("c", " " .. " Config", ":e $MYVIMRC <CR>"),
					dashboard.button("l", "鈴" .. " Lazy", ":Lazy<CR>"),
					dashboard.button("q", " " .. " Quit", ":qa<CR>"),
				}
				for _, button in ipairs(dashboard.section.buttons.val) do
					button.opts.hl = "AlphaButtons"
					button.opts.hl_shortcut = "AlphaShortcut"
				end
				dashboard.section.footer.opts.hl = "Type"
				dashboard.section.header.opts.hl = "AlphaHeader"
				dashboard.section.buttons.opts.hl = "AlphaButtons"
				dashboard.opts.layout[1].val = 8
				return dashboard
			end,
			config = function(_, dashboard)
				-- close Lazy and re-open when the dashboard is ready
				if vim.o.filetype == "lazy" then
					vim.cmd.close()
					vim.api.nvim_create_autocmd("User", {
						pattern = "AlphaReady",
						callback = function()
							require("lazy").show()
						end,
					})
				end

				require("alpha").setup(dashboard.opts)

				vim.api.nvim_create_autocmd("User", {
					pattern = "LazyVimStarted",
					callback = function()
						local stats = require("lazy").stats()
						local ms = (math.floor(stats.startuptime * 100 + 0.5) / 100)
						dashboard.section.footer.val = "⚡ Neovim loaded "
							.. stats.count
							.. " plugins in "
							.. ms
							.. "ms"
						pcall(vim.cmd.AlphaRedraw)
					end,
				})
			end,
		},

		-- treesitter高亮插件
		{
			"nvim-treesitter/nvim-treesitter",
			version = false, -- last release is way too old and doesn't work on Windows
			build = ":TSUpdate",
			event = { "BufReadPost", "BufNewFile" },
			dependencies = { "p00f/nvim-ts-rainbow" },
			keys = {
				{ "<c-space>", desc = "Increment selection" },
				{ "<bs>", desc = "Schrink selection", mode = "x" },
			},
			---@type TSConfig
			opts = {
				highlight = { enable = true },
				indent = { enable = true },
				context_commentstring = { enable = true, enable_autocmd = false },
				ensure_installed = {
					"bash",
					"help",
					"html",
					"javascript",
					"json",
					"lua",
					"markdown",
					"markdown_inline",
					"python",
					"query",
					"regex",
					"tsx",
					"typescript",
					"vim",
					"yaml",
					"toml",
					"julia",
				},
				incremental_selection = {
					enable = true,
					keymaps = {
						init_selection = "<C-space>",
						node_incremental = "<C-space>",
						scope_incremental = "<nop>",
						node_decremental = "<bs>",
					},
				},
				rainbow = {
					enable = true,
					-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
					extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
					max_file_lines = nil, -- Do not enable for files with more than n lines, int
					-- colors = {}, -- table of hex strings
					-- termcolors = {} -- table of colour name strings
				},
			},
			---@param opts TSConfig
			config = function(_, opts)
				require("nvim-treesitter.configs").setup(opts)
			end,
		},
		-- 自动切换输入法
		"h-hg/fcitx.nvim",
		-- git集成
		{ "lewis6991/gitsigns.nvim" },
		-- 模糊搜索
		{
			"nvim-telescope/telescope.nvim",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"nvim-tree/nvim-web-devicons",
				"nvim-treesitter/nvim-treesitter",
			},
			config = function()
				local builtin = require("telescope.builtin")
				vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
				vim.keymap.set("n", "<leader>fg", builtin.live_grep, {})
				vim.keymap.set("n", "<leader>fb", builtin.buffers, {})
				vim.keymap.set("n", "<leader>fh", builtin.help_tags, {})
			end,
		},

		-- neotree文件树
		{
			"nvim-neo-tree/neo-tree.nvim",
			dependencies = {
				"nvim-lua/plenary.nvim",
				"nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
				"MunifTanjim/nui.nvim",
			},
			cmd = "Neotree",
			keys = {
				{
					"<leader>fE",
					function()
						require("neo-tree.command").execute({ toggle = true, dir = vim.loop.cwd() })
					end,
					desc = "Explorer NeoTree (cwd)",
				},
				{ "<leader>e", "<leader>fE", desc = "Explorer NeoTree (cwd)", remap = true },
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
		-- 替换内容
		{
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
		{
			"neoclide/coc.nvim",
			branch = "release",
			config = function()
				-- coc配置
				-- coc插件列表
				vim.g.coc_global_extensions = {
					"coc-pyright",
					"coc-translator",
					"coc-prettier",
					"coc-vimlsp",
					"coc-julia",
					"coc-json",
					"coc-markmap",
					"coc-sumneko-lua",
					"coc-clangd",
					"coc-rust-analyzer",
					"coc-toml",
					"coc-pydocstring",
					"@yaegassy/coc-volar",
					"@yaegassy/coc-volar-tools",
				}
				-- Some servers have issues with backup files, see #649
				vim.opt.backup = false
				vim.opt.writebackup = false

				-- Having longer updatetime (default is 4000 ms = 4s) leads to noticeable
				-- delays and poor user experience
				vim.opt.updatetime = 300

				-- Always show the signcolumn, otherwise it would shift the text each time
				-- diagnostics appeared/became resolved
				vim.opt.signcolumn = "yes"

				local keyset = vim.keymap.set
				-- Autocomplete
				function _G.check_back_space()
					local col = vim.fn.col(".") - 1
					return col == 0 or vim.fn.getline("."):sub(col, col):match("%s") ~= nil
				end

				-- Use Tab for trigger completion with characters ahead and navigate
				-- NOTE: There's always a completion item selected by default, you may want to enable
				-- no select by setting `"suggest.noselect": true` in your configuration file
				-- NOTE: Use command ':verbose imap <tab>' to make sure Tab is not mapped by
				-- other plugins before putting this into your config
				local opts = { silent = true, noremap = true, expr = true, replace_keycodes = false }
				keyset(
					"i",
					"<TAB>",
					'coc#pum#visible() ? coc#pum#next(1) : v:lua.check_back_space() ? "<TAB>" : coc#refresh()',
					opts
				)
				keyset("i", "<S-TAB>", [[coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"]], opts)

				-- Make <CR> to accept selected completion item or notify coc.nvim to format
				-- <C-g>u breaks current undo, please make your own choice
				keyset(
					"i",
					"<cr>",
					[[coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"]],
					opts
				)

				-- Use <c-j> to trigger snippets
				keyset("i", "<c-j>", "<Plug>(coc-snippets-expand-jump)")
				-- Use <c-space> to trigger completion
				keyset("i", "<c-space>", "coc#refresh()", { silent = true, expr = true })

				-- Use `[g` and `]g` to navigate diagnostics
				-- Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
				keyset("n", "[g", "<Plug>(coc-diagnostic-prev)", { silent = true })
				keyset("n", "]g", "<Plug>(coc-diagnostic-next)", { silent = true })

				-- GoTo code navigation
				keyset("n", "gd", "<Plug>(coc-definition)", { silent = true })
				keyset("n", "gy", "<Plug>(coc-type-definition)", { silent = true })
				keyset("n", "gi", "<Plug>(coc-implementation)", { silent = true })
				keyset("n", "gr", "<Plug>(coc-references)", { silent = true })

				-- Use K to show documentation in preview window
				function _G.show_docs()
					local cw = vim.fn.expand("<cword>")
					if vim.fn.index({ "vim", "help" }, vim.bo.filetype) >= 0 then
						vim.api.nvim_command("h " .. cw)
					elseif vim.api.nvim_eval("coc#rpc#ready()") then
						vim.fn.CocActionAsync("doHover")
					else
						vim.api.nvim_command("!" .. vim.o.keywordprg .. " " .. cw)
					end
				end
				keyset("n", "K", "<CMD>lua _G.show_docs()<CR>", { silent = true })

				-- Highlight the symbol and its references on a CursorHold event(cursor is idle)
				vim.api.nvim_create_augroup("CocGroup", {})
				vim.api.nvim_create_autocmd("CursorHold", {
					group = "CocGroup",
					command = "silent call CocActionAsync('highlight')",
					desc = "Highlight symbol under cursor on CursorHold",
				})

				-- Symbol renaming
				keyset("n", "<leader>rn", "<Plug>(coc-rename)", { silent = true })

				-- Formatting selected code
				keyset("x", "<leader>f", "<Plug>(coc-format-selected)", { silent = true })
				keyset("n", "<leader>f", "<Plug>(coc-format-selected)", { silent = true })

				-- Setup formatexpr specified filetype(s)
				vim.api.nvim_create_autocmd("FileType", {
					group = "CocGroup",
					pattern = "typescript,json",
					command = "setl formatexpr=CocAction('formatSelected')",
					desc = "Setup formatexpr specified filetype(s).",
				})

				-- Update signature help on jump placeholder
				vim.api.nvim_create_autocmd("User", {
					group = "CocGroup",
					pattern = "CocJumpPlaceholder",
					command = "call CocActionAsync('showSignatureHelp')",
					desc = "Update signature help on jump placeholder",
				})

				-- Apply codeAction to the selected region
				-- Example: `<leader>aap` for current paragraph
				local opts = { silent = true, nowait = true }
				keyset("x", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)
				keyset("n", "<leader>a", "<Plug>(coc-codeaction-selected)", opts)

				-- Remap keys for apply code actions at the cursor position.
				keyset("n", "<leader>ac", "<Plug>(coc-codeaction-cursor)", opts)
				-- Remap keys for apply code actions affect whole buffer.
				keyset("n", "<leader>as", "<Plug>(coc-codeaction-source)", opts)
				-- Remap keys for applying codeActions to the current buffer
				keyset("n", "<leader>ac", "<Plug>(coc-codeaction)", opts)
				-- Apply the most preferred quickfix action on the current line.
				keyset("n", "<leader>qf", "<Plug>(coc-fix-current)", opts)

				-- Remap keys for apply refactor code actions.
				keyset("n", "<leader>re", "<Plug>(coc-codeaction-refactor)", { silent = true })
				keyset("x", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })
				keyset("n", "<leader>r", "<Plug>(coc-codeaction-refactor-selected)", { silent = true })

				-- Run the Code Lens actions on the current line
				keyset("n", "<leader>cl", "<Plug>(coc-codelens-action)", opts)

				-- Map function and class text objects
				-- NOTE: Requires 'textDocument.documentSymbol' support from the language server
				keyset("x", "if", "<Plug>(coc-funcobj-i)", opts)
				keyset("o", "if", "<Plug>(coc-funcobj-i)", opts)
				keyset("x", "af", "<Plug>(coc-funcobj-a)", opts)
				keyset("o", "af", "<Plug>(coc-funcobj-a)", opts)
				keyset("x", "ic", "<Plug>(coc-classobj-i)", opts)
				keyset("o", "ic", "<Plug>(coc-classobj-i)", opts)
				keyset("x", "ac", "<Plug>(coc-classobj-a)", opts)
				keyset("o", "ac", "<Plug>(coc-classobj-a)", opts)

				-- Remap <C-f> and <C-b> to scroll float windows/popups
				---@diagnostic disable-next-line: redefined-local
				local opts = { silent = true, nowait = true, expr = true }
				keyset("n", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
				keyset("n", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)
				keyset("i", "<C-f>", 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(1)<cr>" : "<Right>"', opts)
				keyset("i", "<C-b>", 'coc#float#has_scroll() ? "<c-r>=coc#float#scroll(0)<cr>" : "<Left>"', opts)
				keyset("v", "<C-f>", 'coc#float#has_scroll() ? coc#float#scroll(1) : "<C-f>"', opts)
				keyset("v", "<C-b>", 'coc#float#has_scroll() ? coc#float#scroll(0) : "<C-b>"', opts)

				-- Use CTRL-S for selections ranges
				-- Requires 'textDocument/selectionRange' support of language server
				keyset("n", "<C-s>", "<Plug>(coc-range-select)", { silent = true })
				keyset("x", "<C-s>", "<Plug>(coc-range-select)", { silent = true })

				-- Add `:Format` command to format current buffer
				vim.api.nvim_create_user_command("Format", "call CocAction('format')", {})

				-- " Add `:Fold` command to fold current buffer
				vim.api.nvim_create_user_command("Fold", "call CocAction('fold', <f-args>)", { nargs = "?" })

				-- Add `:OR` command for organize imports of the current buffer
				vim.api.nvim_create_user_command(
					"OR",
					"call CocActionAsync('runCommand', 'editor.action.organizeImport')",
					{}
				)

				-- Add (Neo)Vim's native statusline support
				-- NOTE: Please see `:h coc-status` for integrations with external plugins that
				-- provide custom statusline: lightline.vim, vim-airline
				vim.opt.statusline:prepend("%{coc#status()}%{get(b:,'coc_current_function','')}")

				-- Mappings for CoCList
				-- code actions and coc stuff
				---@diagnostic disable-next-line: redefined-local
				local opts = { silent = true, nowait = true }
				-- Show all diagnostics
				keyset("n", "<space>a", ":<C-u>CocList diagnostics<cr>", opts)
				-- Manage extensions
				keyset("n", "<space>e", ":<C-u>CocList extensions<cr>", opts)
				-- Show commands
				keyset("n", "<space>c", ":<C-u>CocList commands<cr>", opts)
				-- Find symbol of current document
				keyset("n", "<space>o", ":<C-u>CocList outline<cr>", opts)
				-- Search workspace symbols
				keyset("n", "<space>s", ":<C-u>CocList -I symbols<cr>", opts)
				-- Do default action for next item
				keyset("n", "<space>j", ":<C-u>CocNext<cr>", opts)
				-- Do default action for previous item
				keyset("n", "<space>k", ":<C-u>CocPrev<cr>", opts)
				-- Resume latest coc list
				keyset("n", "<space>p", ":<C-u>CocListResume<cr>", opts)
				-- coc配置结束
				-- Mappings for coc-translator
				keyset("n", "<leader>t", "<Plug>(coc-translator-p)")
				keyset("v", "<leader>t", "<Plug>(coc-translator-pv)")
			end,
		},
		--高亮光标下边的单词
		"RRethy/vim-illuminate",
		-- UI美化
		{ "stevearc/dressing.nvim", event = "VeryLazy" },
		-- 修改nvim的通知栏，ui美化
		{
			"rcarriga/nvim-notify",
			keys = {
				{
					"<leader>un",
					function()
						require("notify").dismiss({ silent = true, pending = true })
					end,
					desc = "Delete all Notifications",
				},
			},
			opts = {
				timeout = 3000,
				max_height = function()
					return math.floor(vim.o.lines * 0.75)
				end,
				max_width = function()
					return math.floor(vim.o.columns * 0.75)
				end,
			},
		},
		-- 修改nvim的命令栏，美化ui
		{
			"folke/noice.nvim",
			event = "VeryLazy",
			opts = {
				lsp = {
					override = {
						["vim.lsp.util.convert_input_to_markdown_lines"] = true,
						["vim.lsp.util.stylize_markdown"] = true,
					},
				},
				presets = {
					bottom_search = true,
					command_palette = true,
					long_message_to_split = true,
				},
			},
			keys = {
				{
					"<S-Enter>",
					function()
						require("noice").redirect(vim.fn.getcmdline())
					end,
					mode = "c",
					desc = "Redirect Cmdline",
				},
				{
					"<leader>snl",
					function()
						require("noice").cmd("last")
					end,
					desc = "Noice Last Message",
				},
				{
					"<leader>snh",
					function()
						require("noice").cmd("history")
					end,
					desc = "Noice History",
				},
				{
					"<leader>sna",
					function()
						require("noice").cmd("all")
					end,
					desc = "Noice All",
				},
				{
					"<c-f>",
					function()
						if not require("noice.lsp").scroll(4) then
							return "<c-f>"
						end
					end,
					silent = true,
					expr = true,
					desc = "Scroll forward",
					mode = { "i", "n", "s" },
				},
				{
					"<c-b>",
					function()
						if not require("noice.lsp").scroll(-4) then
							return "<c-b>"
						end
					end,
					silent = true,
					expr = true,
					desc = "Scroll backward",
					mode = { "i", "n", "s" },
				},
			},
		},
		-- 自动替换两边的符号，例如括号等
		-- "tpope/vim-surround",
		-- Tagbar
		{ "majutsushi/tagbar" },
		-- Markdown支持
		"plasticboy/vim-markdown",
		{
			"iamcco/markdown-preview.nvim",
			build = function()
				vim.fn["mkdp#util#install"]()
			end,
			config = function()
				vim.g.mkdp_auto_start = true
				vim.g.mkdp_theme = "dark"
			end,
		},
		"mzlogin/vim-markdown-toc",
		"dhruvasagar/vim-table-mode",
		{
			"img-paste-devs/img-paste.vim",
			config = function()
				vim.g.mdip_imgdir = "pic"
				vim.g.mdip_imgname = "image"
				vim.keymap.set("n", "<C-p>", ":call mdip#MarkdownClipboardImage()<CR>")
			end,
		},
		{ "gcmt/wildfire.vim" },
		{
			"folke/todo-comments.nvim",
			dependencies = { "folke/trouble.nvim", "nvim-lua/plenary.nvim" },
			config = function()
				vim.keymap.set("n", "]t", function()
					require("todo-comments").jump_next()
				end, { desc = "Next todo comment" })

				vim.keymap.set("n", "[t", function()
					require("todo-comments").jump_prev()
				end, { desc = "Previous todo comment" })

				-- You can also specify a list of valid jump keywords

				vim.keymap.set("n", "]t", function()
					require("todo-comments").jump_next({ keywords = { "ERROR", "WARNING" } })
				end, { desc = "Next error/warning todo comment" })
			end,
		},
		{
			"folke/trouble.nvim",
			dependencies = { "nvim-tree/nvim-web-devicons" },
			config = function()
				vim.keymap.set("n", "<leader>xx", "<cmd>TroubleToggle<cr>", { silent = true, noremap = true })
				vim.keymap.set(
					"n",
					"<leader>xw",
					"<cmd>TroubleToggle workspace_diagnostics<cr>",
					{ silent = true, noremap = true }
				)
				vim.keymap.set(
					"n",
					"<leader>xd",
					"<cmd>TroubleToggle document_diagnostics<cr>",
					{ silent = true, noremap = true }
				)
				vim.keymap.set("n", "<leader>xl", "<cmd>TroubleToggle loclist<cr>", { silent = true, noremap = true })
				vim.keymap.set("n", "<leader>xq", "<cmd>TroubleToggle quickfix<cr>", { silent = true, noremap = true })
				vim.keymap.set("n", "gR", "<cmd>TroubleToggle lsp_references<cr>", { silent = true, noremap = true })
			end,
		},
		{ "github/copilot.vim" },
		{ "easymotion/vim-easymotion" },
	})
end

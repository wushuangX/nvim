"显示行号
set nu
set rnu
set cursorline
set scrolloff=5
set mouse=
autocmd vimenter * nested colorscheme gruvbox
silent! call repeat#set("\<Plug>MyWonderfulMap", v:count)
let g:airline_theme='deus'
let g:coc_global_extensions = ['coc-webview', 'coc-python',  'coc-pyright', 'coc-translator', 'coc-snippets', 'coc-prettier', 'coc-highlight', 'coc-git', 'coc-explorer', 'coc-actions', 'coc-julia', 'coc-json', 'coc-markmap', 'coc-sumneko-lua', 'coc-stylua', 'coc-clangd']
"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
nmap <C-k> <Plug>coc-float-jump
function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call ShowDocumentation()<CR>

function! ShowDocumentation()
  if CocAction('hasProvider', 'hover')
    call CocActionAsync('doHover')
  else
    call feedkeys('K', 'in')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList

" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-j> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<c-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<c-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
imap <C-j> <Plug>(coc-snippets-expand-jump)

" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)

" coc的目录管理插件
:nmap <space>e <Cmd>CocCommand explorer<CR>

" 目录管理软件的配置 nerdtree
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
" markdown
" markdown自动隐藏关闭
let g:vim_markdown_conceal = 0
" table自动插入
let g:table_mode_corner='|'
" markdown图片粘贴插件设置
"设置默认储存文件夹。这里表示储存在当前文档所在文件夹下的'pic'文件夹下，相当于 ./pic/
let g:mdip_imgdir = 'pic' 
"设置默认图片名称。当图片名称没有给出时，使用默认图片名称
let g:mdip_imgname = 'image'
"设置快捷键，个人喜欢 Ctrl+p 的方式，比较直观
autocmd FileType markdown nnoremap <silent> <C-p> :call mdip#MarkdownClipboardImage()<CR>

" set to 1, nvim will open the preview window after entering the markdown buffer
" default: 0
let g:mkdp_auto_start = 1

" set to 1, the nvim will auto close current preview window when change
" from markdown buffer to another buffer
" default: 1
let g:mkdp_auto_close = 1

" set to 1, the vim will refresh markdown when save the buffer or
" leave from insert mode, default 0 is auto refresh markdown as you edit or
" move the cursor
" default: 0
let g:mkdp_refresh_slow = 0

" set to 1, the MarkdownPreview command can be use for all files,
" by default it can be use in markdown file
" default: 0
let g:mkdp_command_for_global = 0

" set to 1, preview server available to others in your network
" by default, the server listens on localhost (127.0.0.1)
" default: 0
let g:mkdp_open_to_the_world = 0

" use custom IP to open preview page
" useful when you work in remote vim and preview on local browser
" more detail see: https://github.com/iamcco/markdown-preview.nvim/pull/9
" default empty
let g:mkdp_open_ip = ''

" specify browser to open preview page
" for path with space
" valid: `/path/with\ space/xxx`
" invalid: `/path/with\\ space/xxx`
" default: ''
let g:mkdp_browser = ''

" set to 1, echo preview page url in command line when open preview page
" default is 0
let g:mkdp_echo_preview_url = 0

" a custom vim function name to open preview page
" this function will receive url as param
" default is empty
let g:mkdp_browserfunc = ''

" options for markdown render
" mkit: markdown-it options for render
" katex: katex options for math
" uml: markdown-it-plantuml options
" maid: mermaid options
" disable_sync_scroll: if disable sync scroll, default 0
" sync_scroll_type: 'middle', 'top' or 'relative', default value is 'middle'
"   middle: mean the cursor position alway show at the middle of the preview page
"   top: mean the vim top viewport alway show at the top of the preview page
"   relative: mean the cursor position alway show at the relative positon of the preview page
" hide_yaml_meta: if hide yaml metadata, default is 1
" sequence_diagrams: js-sequence-diagrams options
" content_editable: if enable content editable for preview page, default: v:false
" disable_filename: if disable filename header for preview page, default: 0
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0,
    \ 'toc': {}
    \ }

" use a custom markdown style must be absolute path
" like '/Users/username/markdown.css' or expand('~/markdown.css')
let g:mkdp_markdown_css = ''

" use a custom highlight style must absolute path
" like '/Users/username/highlight.css' or expand('~/highlight.css')
let g:mkdp_highlight_css = ''

" use a custom port to start server or empty for random
let g:mkdp_port = '9090'

" preview page title
" ${name} will be replace with the file name
let g:mkdp_page_title = '「${name}」'

" recognized filetypes
" these filetypes will have MarkdownPreview... commands
let g:mkdp_filetypes = ['markdown']

" set default theme (dark or light)
" By default the theme is define according to the preferences of the system
let g:mkdp_theme = 'dark'

" Create markmap from the whole file
nmap <Leader>m <Plug>(coc-markmap-create)
" Create markmap from the selected lines
vmap <Leader>m <Plug>(coc-markmap-create-v)
command! -range=% Markmap CocCommand markmap.create <line1> <line2>

" Create default mappings
let g:NERDCreateDefaultMappings = 1 

" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1

" Use compact syntax for prettified multi-line comments
let g:NERDCompactSexyComs = 1

" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'left'

" Set a language to use its alternate delimiters by default
let g:NERDAltDelims_java = 1

" Add your own custom formats or override the defaults
let g:NERDCustomDelimiters = { 'c': { 'left': '/**','right': '*/' } }

" Allow commenting and inverting empty lines (useful when commenting a region)
let g:NERDCommentEmptyLines = 1

" Enable trimming of trailing whitespace when uncommenting
let g:NERDTrimTrailingWhitespace = 1
" Enable NERDCommenterToggle to check all selected lines is commented or not 
let g:NERDToggleCheckAllLines = 1

" " 用vim执行matlab代码
" function! DoRemote(arg)
"   UpdateRemotePlugins
" endfunction

noremap <expr> <F7> LaTeXtoUnicode#Toggle()
noremap! <expr> <F7> LaTeXtoUnicode#Toggle()

" julia
" 按?查询文档
autocmd FileType julia nmap <buffer> ? <Plug>(JuliaDocPrompt)
" 按leader fb可以转换函数的形式
noremap <Leader>fb :call julia#toggle_function_blockassign()<CR>
hi link juliaParDelim Delimiter
hi link juliaSemicolon Operator
hi link juliaFunctionCall Identifier
"
" nnoremap <silent> K :call LanguageClient_textDocument_hover()<CR>
" nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
" nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>

let g:jukit_shell_cmd = 'julia-1.7'
"    - Specifies the command used to start a shell in the output split. Can also be an absolute path. Can also be any other shell command, e.g. `R`, `julia`, etc. (note that output saving is only possible for ipython)
let g:jukit_terminal = ''
"   - Terminal to use. Can be one of '', 'kitty', 'vimterm', 'nvimterm' or 'tmux'. If '' is given then will try to detect terminal
let g:jukit_auto_output_hist = 0
"   - If set to 1, will create an autocmd with event `CursorHold` to show saved ipython output of current cell in output-history split. Might slow down (n)vim significantly, you can use `set updatetime=<number of milliseconds>` to control the time to wait until CursorHold events are triggered, which might improve performance if set to a higher number (e.g. `set updatetime=1000`).
let g:jukit_use_tcomment = 0
"   - Whether to use tcomment plugin (https://github.com/tomtom/tcomment_vim) to comment out cell markers. If not, then cell markers will simply be prepended with `g:jukit_comment_mark`
let g:jukit_comment_mark = '#'
"   - See description of `g:jukit_use_tcomment` above
let g:jukit_mappings = 1
"   - If set to 0, none of the default function mappings (as specified further down) will be applied

highlight jukit_cellmarker_colors guifg=#1d615a guibg=#1d615a ctermbg=22 ctermfg=22
let g:jukit_highlight_markers = 1
"    - Whether to highlight cell markers or not. You can specify the colors of cell markers by putting e.g. `highlight jukit_cellmarker_colors guifg=#1d615a guibg=#1d615a ctermbg=22 ctermfg=22` with your desired colors in your (neo)vim config. Make sure to define this highlight *after* loading a colorscheme in your (neo)vim config
let g:jukit_enable_textcell_bg_hl = 1
"    - Whether to highlight background of textcells. You can specify the color by putting `highlight jukit_textcell_bg_colors guibg=#131628 ctermbg=0` with your desired colors in your (neo)vim config. Make sure to define this highlight group *after* loading a colorscheme in your (neo)vim config.
let g:jukit_enable_textcell_syntax = 1
"    - Whether to enable markdown syntax highlighting in textcells
let g:jukit_text_syntax_file = $VIMRUNTIME . '/syntax/' . 'markdown.vim'
"    - Syntax file to use for textcells. If you want to define your own syntax matches inside of text cells, make sure to include `containedin=textcell`.
let g:jukit_hl_ext_enabled = '*'
"    - String or list of strings specifying extensions for which the relevant highlighting autocmds regarding marker-highlighting, textcell-highlighting, etc. will be created. For example, `let g:jukit_hl_extensions=['py', 'R']` will enable the defined highlighting options for `.py` and `.R` files. Use `let g:jukit_hl_extensions=*` to enable them for all files and `let g:jukit_hl_extensions=''` to disable them completely

let g:jukit_in_style = 2
"    - Number between 0 and 4. Defines how the input-code should be represented in the IPython shell. One of 5 different styles can be chosen, where style 0 is the default IPython style for the IPython-`%paste` command
let g:jukit_max_size = 20
"    - Max Size of json containing saved output in MiB. When the output history json gets too large, certain jukit operations can get slow, thus a max size is specified. Once the max size is reached, you'll be asked to delete some of the saved outputs (using e.g. jukit#cells#delete_outputs - see function explanation further down) before further output can be saved.
let g:jukit_show_prompt = 0
"    - Whether to show (1) or hide (0) the previous ipython prompt after code is sent to the ipython shell

" IF AN IPYTHON SHELL COMMAND IS USED:
let g:jukit_save_output = 1
"    - Whether to save ipython output or not. This is the default value if an ipython shell command is used.

let g:jukit_clean_outhist_freq = 60 * 10
"    - Frequency in seconds with which to delete saved ipython output (including cached überzug images) of cells which are not present anymore. (After executing a cell of a buffer for the first time in a session, a CursorHold autocmd is created for this buffer which checks whether the last time obsolete output got deleted was more than `g:jukit_clean_outhist_freq` seconds ago, and if so, deletes all saved output of cells which are not present in the buffer anymore from the output-history-json)

let g:jukit_savefig_dpi = 150
"    - Value for `dpi` argument for matplotlibs `savefig` function
let g:jukit_mpl_block = 1
"    - If set to 0, then `plt.show()` will by default be executed as if `plt.show(block=False)` was specified
let g:jukit_custom_backend = -1
"    - Custom matplotlib backend to use

" You can define a custom split layout as a dictionary, the default is:
let g:jukit_layout = {
    \'split': 'horizontal',
    \'p1': 0.6, 
    \'val': [
        \'file_content',
        \{
            \'split': 'vertical',
            \'p1': 0.6,
            \'val': ['output', 'output_history']
        \}
    \]
\}

" this results in the following split layout:
"  ______________________________________
" |                      |               |
" |                      |               |
" |                      |               |
" |                      |               |
" |                      |     output    |
" |                      |               |
" |                      |               |
" |    file_content      |               |
" |                      |_______________|
" |                      |               |
" |                      |               |
" |                      | output_history|
" |                      |               |
" |                      |               |
" |______________________|_______________|
"
" The positions of all 3 split windows must be defined in the dictionary, even if 
" you don't plan on using the output_history split.
"
" dictionary keys:
" 'split':  Split direction of the two splits specified in 'val'. Either 'horizontal' or 'vertical'
" 'p1':     Proportion of the first split specified in 'val'. Value must be a float with 0 < p1 < 1
" 'val':    A list of length 2 which specifies the two splits for which to apply the above two options.
"           One of the two items in the list must be a string and one must be a dictionary in case of
"           the 'outer' dictionary, while the two items in the list must both be strings in case of
"           the 'inner' dictionary.
"           The 3 strings must be different and can be one of: 'file_content', 'output', 'output_history'
"
" To not use any layout, specify `let g:jukit_layout=-1`


" let g:jukit_hist_use_ueberzug = 1
" "   - Set to 1 to use Überzug to display saved outputs instead of an ipython split window
" let g:jukit_ueberzug_use_cached = 1
" "   - Whether to cache created images of saved outputs. If set to 0, will convert saved outputs to png from scratch each time. Note that this will make displaying saved outputs significantly slower. 
" let g:jukit_ueberzug_pos = [0.25, 0.25, 0.4, 0.6]
" "   - position and dimension of Überzug window WITH output split present - [x, y, width, height]. Use `:call jukit#ueberzug#set_default_pos()` to modify/visualize.
" let g:jukit_ueberzug_pos_noout = [0.25, 0.25, 0.4, 0.6]
" "   - position and dimension of Überzug window WITHOUT output split present - [x, y, width, height]. Use `:call jukit#ueberzug#set_default_pos()` to modify/visualize.
" let g:jukit_kill_ueberzug_on_focus_lost = 1
" "   - whether to kill ueberzug when the focus to neovim is lost (detecting focus might only work on neovim). if set to 0, the ueberzug image keeps being displayed even when neovim loses focus (e.g. when switching tabs in terminal).
" 
" let g:jukit_ueberzug_border_color = get(g:, 'jukit_ueberzug_border_color', 'blue')
" "   - border color of Überzug images
" let g:jukit_ueberzug_theme = 'dark'
" "   - choose dark or light theme for markdown cells
" let g:jukit_ueberzug_term_hw_ratio = -1
" "   - this is relevant in case the shown ueberzug image is cut off horizontally. In that case, the determined width/height ratio of your terminal cells is determined incorrectly. A value of -1 means the ratio should be determined automatically. A ratio of 2.2 is used by default if the ratio can't be determined automatically. If you get a cut off image, try setting this parameter and vary the values around 2.0 (e.g. `let g:jukit_ueberzug_term_hw_ratio = 2.3` or `let g:jukit_ueberzug_term_hw_ratio = 1.9`) until the image is displayed correctly to determine your needed ratio.
" let g:jukit_ueberzug_python_cmd = 'python3'
" "   - path to python3 executable for which the überzug requirements (beautifulsoup4, pillow, ueberzug) are installed. By default it just uses the python3 command found in your environment. If you started an output split in a virtual environment, make sure that you either have all the requirements in the virtual requirements or set the absolute path to the python3 command.
" let g:jukit_ueberzug_jupyter_cmd = 'jupyter'
" "   - path to jupyter executable. By default it just uses the jupyter command found in your environment. If you started an output split in a virtual environment, make sure that you either have jupyter installed in that environment or set the absolute path to the python3 command.
" let g:jukit_ueberzug_cutycapt_cmd = 'cutycapt'
" "   - path to cutycapt executable
" let g:jukit_ueberzug_imagemagick_cmd = 'convert'
" "   - path to imagemagick (`convert` command) executable


call plug#begin() 
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" 的vim主题
Plug 'morhetz/gruvbox'
" 左侧显示git
Plug 'airblade/vim-gitgutter'
" 底栏
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" 多光标
Plug 'terryma/vim-multiple-cursors'
" 重复上一个命令
Plug 'tpope/vim-repeat'
" 代码注释反注释
Plug 'preservim/nerdcommenter'
" 高亮光标下单词
Plug 'RRethy/vim-illuminate'
"模糊文件搜索
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" markdown支持
Plug 'plasticboy/vim-markdown'
Plug 'godlygeek/tabular'
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'mzlogin/vim-markdown-toc', { 'for': ['gitignore', 'markdown'] }
Plug 'dhruvasagar/vim-table-mode'
" markdown粘贴图片插件
Plug 'ferrine/md-img-paste.vim'
" " 代码格式整理
Plug 'Chiel92/vim-autoformat'
"彩虹括号
Plug 'luochen1990/rainbow'
let g:rainbow_active = 1
" 可视化缩进
Plug 'Yggdroot/indentLine'
" 回车可以智能选择文字的插件
Plug 'gcmt/wildfire.vim'
" 自动替换两边的符号，例如括号等
Plug 'tpope/vim-surround'
" 自动输入成对的括号等
Plug 'jiangmiao/auto-pairs'
" 文件管理插件
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
" 翻译相关的设置，coc-translator
" NOTE: do NOT use `nore` mappings
" popup
nmap <Leader>t <Plug>(coc-translator-p)
vmap <Leader>t <Plug>(coc-translator-pv)
" echo
nmap <Leader>e <Plug>(coc-translator-e)
vmap <Leader>e <Plug>(coc-translator-ev)
" replace
nmap <Leader>r <Plug>(coc-translator-r)
vmap <Leader>r <Plug>(coc-translator-rv)


" 按ga符号来按符号对齐
Plug 'junegunn/vim-easy-align'

" 提供炫酷的顶条
Plug 'mg979/vim-xtabline'

" julia 相关的插件
Plug 'JuliaEditorSupport/julia-vim', {'for': 'julia'}
Plug 'autozimu/LanguageClient-neovim', {'branch': 'next', 'do': 'zsh install.sh'}
" Plug 'roxma/nvim-completion-manager'
" jupyter插件
Plug 'luk400/vim-jukit', {'for': ['julia', 'python', 'json']}
" 多语言的高亮等
Plug 'sheerun/vim-polyglot'
call plug#end()

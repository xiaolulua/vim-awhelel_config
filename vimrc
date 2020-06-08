""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"支持中文
"设置读入文件时尝试采用的编码类型
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936,big5,utf16,shift-jis,latin1
"设置输出到终端时采用的编码类型
set termencoding=utf-8
"设置vim内部使用的字符编码
set encoding=utf-8
"设置帮助文档语言
set helplang=cn
"设置脚本使用的字符编码
scriptencoding utf-8
"用户创建新文件使用的文本格式
set fileformats=unix,dos
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"设置窗口标题
"主机名 文件路径 最后一次修改时间
set title
set titlestring=
set titlestring+=%(%{hostname()}\ \ %)
set titlestring+=%(%{expand('%:p')}\ \ %)
set titlestring+=%{strftime('%Y-%m-%d\ %H:%M',getftime(expand('%')))}
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"忽略某些文件和文件夹
set wildignore+=*.o,*.obj,*.bin,*.dll,*.exe
set wildignore+=*/.git/*,*/.svn/*,*/__pycache__/*,*/build/**
set wildignore+=*.pyc
set wildignore+=*.DS_Store
set wildignore+=*.aux,*.bbl,*.blg,*.brf,*.fls,*.fdb_latexmk,*.synctex.gz,*.pdf
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"当处理未保存的或只读的文件时,弹出提示
set confirm
"设置文件撤销功能
if !has('nvim')
	if !isdirectory($HOME . "/.local/vim/undo")
		call mkdir($HOME . "/.local/vim/undo", "p", 0700)
	endif
	set undodir=~/.local/vim/undo
endif
set undofile
"返回到文件最后一次更改的位置
augroup resume_edit_position
    autocmd!
    autocmd BufReadPost *
        \ if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit'
        \ | execute "normal! g`\"zvzz"
        \ | endif
augroup END
"文件不是utf8格式就弹出提示信息
augroup non_utf8_file_warn
    autocmd!
    autocmd BufRead * if &fileencoding != 'utf-8' && expand('%:e') != 'gz'
                \ | unsilent echomsg 'File not in UTF-8 format!' | endif
augroup END

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"选择主题
"colorscheme molokai
"设置不与vi兼容
set nocompatible
"不再显示乌干达的提示
set shortmess=atI
"在屏幕最后一行显示命令行
set showcmd
"设置命令行的行数
set cmdheight=1
"如果cmd补全有多余一个补全,列出所有的匹配并在最长公共子串没有改变长度的情况下,下次使用第一个匹配补全
set wildmode=longest:full
"命令行补全以增强模式运行
set wildmenu
"不要在cmd的那一栏中显示模式,因为vim-airline会显示它GGGGG
"set noshowmode
"设置开启256色
set t_Co=256
"设置历史记录条数
set history=1000
"在切换buffer时,自动保存当前文件
set autowrite
"若文件被外部改变,vim自动读取文件
set autoread
"设置自定义的leader
let mapleader=','

"在切换buffer时自动切换vim工作目录,设置此选项可能会使某些插件出问题,建议使用提供的映射
"set autochdir
"设置映射把工作目录改变到当前光标所在buffer对应的文件路径下
nnoremap <silent> <leader>cd :lcd %:p:h<CR>:pwd<CR>

"打开文件类型检测
filetype plugin indent on
"设置系统剪切板
set clipboard+=unnamedplus
"设置插入模式下paste和nopaste切换的快捷键<F12>,这样在粘贴代码的时候就不会出现格式混乱的问题
set pastetoggle=<F12>
"禁止可视响铃和错误声音响铃
set novisualbell noerrorbells
"设置去掉响声
set vb t_vb=
"禁止vim生成备份文件
set nobackup
"不创建swapfile
set noswapfile
"设置等待键盘映射完成的时间
set timeoutlen=800
"多少毫秒之后还没有写入把交换文件写入磁盘
set updatetime=2000
"关掉两个默认开启但是用不到的插件
let g:loaded_netrwPlugin = 1
let g:loaded_2html_plugin = 1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"继承前一行的缩进方式,适用于多行注释
set autoindent
"特别针对C语言语法自动缩进
set cindent
"设置显示行号
set number
"vim内部的终端不显示行号和相对行号
if exists("##TermOpen")
	augroup term_settings
		autocmd!
		autocmd TermOpen * setlocal norelativenumber nonumber
		autocmd TermOpen * startinsert
	augroup END
endif
"数字选项设置,只有光标所在的窗口且不是插入模式才会显示相对行号
augroup number_toggle
	autocmd!
	autocmd BufEnter,FocusGained,InsertLeave,WinEnter * if &number | set relativenumber | endif
	autocmd BufLeave,FocusLost,InsertEnter,WinLeave * if &number | set norelativenumber | endif
augroup END

"语法高亮打开
syntax enable
"使用vim缺省值的语法着色覆盖自己的语法着色
"syntax on
"设置在多少列之后不再进行高亮着色
set synmaxcol=300
"更加准确的高亮着色
augroup accurate_syn_highlight
	autocmd!
	autocmd BufEnter * :syntax sync fromstart
augroup END
"光标移动到buffer顶部和底部的时候保持3距离
set scrolloff=5
"设置突出显示当前行
set cursorline
"不使用高亮光标的所在列
set nocursorcolumn
"在第80列设置一个列标尺
set colorcolumn=80
"设置光标线文字可以隐藏的模式
set concealcursor=nc
"设置markdown文本每行的最长文本长度
augroup text_file_width
	autocmd!
	autocmd BufNewFile,BufRead *.md,*.MD,*.markdown setlocal textwidth=79
augroup END
"显示空格和Tab
set list
"设置tab和拖尾空格的样式
set listchars=tab:\|\ ,extends:❯,precedes:❮,nbsp:+,trail:-
"设定行首tab颜色为256色中的123号色
highlight LeaderTab ctermfg=123
match LeaderTab /^\t/
"设置Tab长度为4个空格,自动缩进长度为4个空格
"当文件类型为py文件时,tab用4个空格代替
autocmd FileType * set tabstop=4|set shiftwidth=4|set noexpandtab
autocmd FileType python set tabstop=4|set shiftwidth=4|set expandtab
set softtabstop=4
"将缩进对齐到shiftwidth的倍数值
set shiftround
"让箭头键可以跳到下一行,也可以加上,h,l,但是官方不建议那么做
"开启normal或visual模式下的backspace键空格键,左右方向键,insert或replace模式下的左方向键,右方向键的跳行功能
set whichwrap+=<,>,b,s,[,]
"设置退格键可用,还有一种设置为"indent,eol,start",不太了解这种设置
set backspace=2
"设置自动换行
set wrap
"设置为整词换行
set linebreak
"设置回绕行开头的字符
set showbreak=↪
"虚拟编辑对可视化块编辑很有帮助
set virtualedit=block
"在连接行或格式化文本时,不要在句号后加两个空格
set nojoinspaces
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"设置打开折叠
set foldenable
"设置折叠方式为根据语法进行折叠,除了C++和C之外的其他格式均按照缩进进行折叠
"C++和C语言按照语法进行折叠
autocmd FileType * set foldmethod=indent
autocmd FileType c,cpp set foldmethod=syntax
"设置折叠区域的宽度,缺省值为0
set foldcolumn=0
"设置折叠层数
set foldlevel=10
"填充折叠行和垂直分割线的字符
set fillchars=fold:\ ,vert:\|
"普通模式下空格键折叠关闭和打开(若该行折叠则展开,若该行展开则折叠)
nnoremap <space> za
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"显示括号匹配
set showmatch
set matchtime=2
"扩展括号匹配
set matchpairs+=<:>
"插入模式设置括号和双引号自动补全,若设置了set paste,则补全不可用
inoremap ( ()<ESC>i
inoremap [ []<ESC>i
inoremap { {}<ESC>i
inoremap ' ''<ESC>i
inoremap " ""<ESC>i
inoremap () ()<ESC>a
inoremap [] []<ESC>a
inoremap {} {}<ESC>a
inoremap '' ''<ESC>a
inoremap "" ""<ESC>a
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"设置光标的样式
let &t_SI.="\e[5 q" "SI = INSERT mode
let &t_SR.="\e[4 q" "SR = REPLACE mode
let &t_EI.="\e[1 q" "EI = NORMAL mode (ELSE)
"  1 -> blinking block
"  2 -> solid block
"  3 -> blinking underscore
"  4 -> solid underscore
"  5 -> blinking vertical bar
"  6 -> solid vertical bar
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"总是显示状态栏
set laststatus=2
"显示光标当前位置
set ruler
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"搜索高亮
set hlsearch
"搜索逐渐高亮
set incsearch
"搜索到文件尾会回卷到文件首
set wrapscan
"搜索忽略大小写,但是当有大写字符时会大小写敏感
set ignorecase smartcase
"在命令行模式下,不使用smartcase
if exists("##CmdLineEnter")
	augroup dynamic_smartcase
		autocmd!
		autocmd CmdLineEnter : set nosmartcase
		autocmd CmdLineLeave : set smartcase
	augroup END
endif

"普通模式 移除尾部空格
function! StripTrailingWhitespaces() abort
	let l:save = winsaveview()
	keeppatterns %s/\v\s+$//e
	call winrestview(l:save)
endfunction
nnoremap <silent> <leader><Space> :call StripTrailingWhitespaces()<CR>
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"设置Vim的补全菜单的行为,此处不知为何加入longest总是会崩溃,所以不加了
set completeopt=menu,menuone
set completeopt-=preview
"补全弹出菜单显示项目的最大数目
set pumheight=15
if exists("&pumblend")
	set pumblend=5
endif
"设置complete扫描的缓冲区
set complete+=kspell complete-=w complete-=b complete-=u complete-=t
"设置拼写检查的语言
set spelllang=en,cjk
"对多字节字符提供支持,例如CJK,正确的处理中文字符的折行和拼接
set formatoptions+=mM
"(~)是一个运算符,因此必须在'e'或'w'之后
set tildeop
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"我们不再需要在普通和可视模式下按shift键就可以进入命令模式
nnoremap ; :
xnoremap ; :
"普通模式 更加快速的打开命令行窗口
nnoremap q; q:
"插入模式 更加快速的推出键(插入的粘贴模式或正在使用中文输入下此快捷方式不可用)
inoremap <silent> jk <ESC>
"插入模式 下把一个单词中的所有字母全部变为大写
inoremap <silent> <C-u> <ESC>viwUea
"插入模式 下把一个单词的首字母变为大写
inoremap <silent> <C-t> <ESC>b~lea
"普通模式 下在当前光标下方或上方插入字符
nnoremap <leader>p m`o<ESC>p``
nnoremap <leader>P m`O<ESC>p``

"普通模式 快速保存文件
nnoremap <silent> <leader>w :update<CR>
"普通模式 如果文件被修改了就保存,总是退出
nnoremap <silent> <leader>q :x<CR>
"普通模式 退出已经打开的所有缓冲区
nnoremap <silent> <leader>Q :qa<CR>

"普通模式 在location list和quickfix list中浏览
nnoremap [l :lprevious<CR>zv
nnoremap ]l :lnext<CR>zv
nnoremap [L :lfirst<CR>zv
nnoremap ]L :llaiiiiiiist<CR>zv
nnoremap [q :cprevious<CR>zv
nnoremap ]q :cnext<CR>zv
nnoremap [Q :cfirst<CR>zv
nnoremap ]Q :clast<CR>zv

"普通模式 打开locationlist和关闭locationlist
nnoremap <leader>lo :lopen<CR>
nnoremap <leader>lc :lclose<CR>

"普通模式 关闭location list和quickfix list
nnoremap <silent> \x :windo lclose <bar> cclose<CR>
"普通模式 关闭一个缓冲区并选择另外一个缓冲区,但不关闭缓冲区的窗口,仍然保留分屏
"由于我们设置了autowrite,在切换缓冲区的时候,会自动保存对关闭的缓冲区中文档的修改
nnoremap <silent> \d :bprevious <bar> bdelete #<CR>
"普通模式 代码搜索结果显示的高亮开关
nnoremap <silent><expr> <Leader>hl (&hls && v:hlsearch ? ':nohls' : ':set hls')."\n"
"普通模式 在当前行的上一行或下一行插入一个空白行
nnoremap <expr> OO 'm`' . v:count1 . 'O<Esc>``'
nnoremap <expr> oo 'm`' . v:count1 . 'o<Esc>``'
"普通模式 在当前字符处(当前光标后方)插入一个空格
nnoremap <silent> <Space><Space> a<Space><ESC>h
"普通模式 从当前光标位置复制到行尾
nnoremap Y y$
"普用模式 拷贝整个区域(全选)
nnoremap <silent><leader>y :%y<CR>
"普通模式 基于物理行(物理行即你眼睛所看到的vim中显示的包括自动换行的行)进行移动
nnoremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
nnoremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')
nnoremap <silent> ^ g^
nnoremap <silent> 0 g0
"可视模式 下的行尾不包括行尾空格符
xnoremap $ g_
"普通模式 下使用leader和TAB自动跳到匹配的成对的另外一个字符
nnoremap <leader><Tab> %
"普通模式和可视模式下跳转到行首或者行末
nnoremap H ^
xnoremap H ^
nnoremap L g_
xnoremap L g_
"在可视模式下不需要退出可视模式就可以实现行的缩进的更改
xnoremap < <gv
xnoremap > >gv
"普通模式 重新选择已经被粘贴上的文本
nnoremap <leader>v `[V`]
"可视模式 在选定区域进行搜索
vnoremap / :<C-U>call feedkeys('/\%>'.(line("'<")-1).'l\%<'.(line("'>")+1)."l")<CR>
"普通模式和可视模式 查找并替换,使用方法:查找字符/替换字符
nnoremap <C-H> :%s/
xnoremap <C-H> :s/
"使用<ESC>退出vim中的内建终端
if exists(":tnoremap")
	tnoremap <ESC>   <C-\><C-n>
endif
"插入模式和普通模式 设置<F11>为拼写检查开关
nnoremap <silent> <F11> :set spell!<cr>
inoremap <silent> <F11> <C-O>:set spell!<cr>
"插入模式 使用shift+tab减少一行的缩进
inoremap <S-Tab> <ESC><<i
"普通模式 关闭搜索的高亮显示
if maparg('<C-L>', 'n') ==# ''
	nnoremap <silent> <C-L> :nohlsearch<C-R>=has('diff')?'<Bar>diffupdate':''<CR><CR><C-L>
endif
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"设置窗口分割
"在下方打开文件分割出新窗口 :sv<filename>
"在右侧打开文件分割出新窗口 :vs<filename>

set splitbelow
set splitright

"普通模式 使用Alt加方向键切换分割窗口
"Alt-Down   切换到下方的分割窗口
"Alt-Up     切换到上方的分割窗口
"Alt-Right  切换到右侧的分割窗口
"Alt-Left   切换到左侧的分割窗口
nnoremap <silent> <M-Down> <C-W><C-J>
nnoremap <silent> <M-Up> <C-W><C-K>
nnoremap <silent> <M-Right> <C-W><C-L>
nnoremap <silent> <M-Left> <C-W><C-H>

"普通模式 使用<Shift>来控制窗口大小
"窗口高度-
"窗口高度+
"窗口宽度+
"窗口宽度-
nnoremap <silent> <S-Down> <C-W><C-->
nnoremap <silent> <S-Up> <C-W><C-+>
nnoremap <silent> <S-Right> <C-W><C->>
nnoremap <silent> <S-Left> <C-W><C-<>

"插入模式 回车即选中当前项
inoremap <expr> <CR>    pumvisible()?"\<C-y>":"\<CR>"

"插入模式 Ctrl键和j,k键也可以用来选择补全菜单的内容
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<Up>"
"插入模式 上下左右键的行为 会显示其他信息
inoremap <expr> <Down>     pumvisible() ? "\<C-n>" : "\<Down>"
inoremap <expr> <Up>       pumvisible() ? "\<C-p>" : "\<Up>"
inoremap <expr> <PageDown> pumvisible() ? "\<PageDown>\<C-p>\<C-n>" : "\<PageDown>"
inoremap <expr> <PageUp>   pumvisible() ? "\<PageUp>\<C-p>\<C-n>" : "\<PageUp>"

"离开插入模式后,自动关闭预览窗口
autocmd InsertLeave,CompleteDone * if pumvisible() == 0|pclose|endif
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""


"让vim配置变更立即生效
autocmd BufWritePost $MYVIMRC source $MYVIMRC


call plug#begin('~/.vim/plugged')
Plug 'Valloric/YouCompleteMe'
call plug#end()

"""""""""""""""""""""""""""""""YCM"""""""""""""""""""""""""""""""""
"ycm配置配置文件路径,这是YouCompleteMe自带的,补充完整路径即可
let g:ycm_global_ycm_extra_conf='~/.vim/plugged/YouCompleteMe/third_party/ycmd/.ycm_extra_conf.py'

"从第2个键入字符就开始罗列匹配项
let g:ycm_min_num_of_chars_for_completion=2
"YCM白名单,当filetype符合白名单中的filetype时,打开YCM,
let g:ycm_filetype_whitelist={'vim':1,'c':1,'cpp':1,'python':1,'bash':1,'zsh':1,'make':1}

"在原有基础上增加语义触发补全,输入两个字母即可
let g:ycm_semantic_triggers =  {'c,cpp,python,bash,zsh,make':['re!\w{2}']}

"打开诊断提示符和错误警告行高亮提示,默认全都是打开的
"let g:ycm_show_diagnostics_ui = 1
"let g:ycm_enable_diagnostic_signs = 1
"let g:ycm_enable_diagnostic_highlighting = 1

"YcmErrorSign,YcmErrorLine,YcmErrorSection
"YCM错误标记
let g:ycm_error_symbol="✗"
"YcmWarningSign,YcmWarningLine,YcmWarningSection
"YCM警告标记
let g:ycm_warning_symbol="⚠"

"在输入注释时提供补全
let g:ycm_complete_in_comments=1
"在输入字符串时提供补全
let g:ycm_complete_in_strings=1
"字符串和注释中的文字也将作为补全信息,默认不打开此功能
"let g:ycm_collect_identifiers_from_comments_and_strings=1
"基于标签引擎开启YCM补全
let g:ycm_collect_identifiers_from_tags_files=1
"语法关键字补全
let g:ycm_seed_identifiers_with_syntax=1

"设置补全预览,默认不打开此功能(A)
"let g:ycm_add_preview_to_completeopt = 1
"在选择完补全选项后,预览窗口将会自动关闭(B),A和B要么同时打开要么同时关闭,关闭即注释掉
"let g:ycm_autoclose_preview_window_after_completion=1

let g:ycm_key_list_select_completion=['<Down>']
let g:ycm_key_list_previous_completion=['<Up>']

"关闭补全菜单,当与UtilSnips有冲突时,这个选项比较有用,默认为['<C-y>']
"let g:ycm_key_list_stop_completion = ['<C-y>']

"(普通,可视,选择,操作符等待)手动完成激活语义补全组合按键,原本是ctrl+space,现在改为ctrl+z
let g:ycm_key_invoke_completion='<C-z>'
noremap <C-z> <NOP>

"关闭加载ycm_extra_conf.py提示
let g:ycm_confirm_extra_conf=0

"禁止缓存匹配项,每次都重新生成缓存,防止YCM与omni缓存出现不兼容的情况
let g:ycm_cache_omnifunc=0

"普通模式重新检查语义,获取最新语法警告错误提示信息
nnoremap <F5> :YcmForceCompileAndDiagnostics<CR>
"普通模式 快捷键跳转到声明和定义
nnoremap <leader>gc :YcmCompleter GoToDeclaration<CR>
nnoremap <leader>gf :YcmCompleter GoToDefinition<CR>
nnoremap <leader>gg :YcmCompleter GoToDefinitionElseDeclaration<CR>
"""""""""""""""""""""""""""""""YCM"""""""""""""""""""""""""""""""""





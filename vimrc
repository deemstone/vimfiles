"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Maintainer: jicheng.li <deemstone at gmail.com>
" 
" Content
" 1. Vundle
" 2. Basic
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 1. Vundle 管理插件
" https://github.com/gmarik/Vundle.vim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'
" file navigator
Plugin 'Command-T'
Plugin 'ctrlp.vim'
Plugin 'The-NERD-tree'
" for javascript
Plugin 'jshint.vim'
Plugin 'jsbeautify'
Plugin 'Tabular'
Plugin 'snipMate'
" syntx"
Plugin 'mustache/vim-mustache-handlebars'
"Plugin 'coffee.vim'
" others
Plugin 'preview'

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 2. Basic 编辑器基本配置:行号/缩进/语法加亮...
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible
set history=400
if has('mouse')
  set mouse=a
endif
set backspace=indent,eol,start
set ruler		"右下角显示光标位置
set showcmd		"右下角现实敲入的命令
set showmatch   "显示括号对应
set incsearch	"实时搜索
set hidden    "Lusty需要这样的"

"格式化 formate
map Q gq
inoremap <C-U> <C-G>u<C-U>

if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

if has("autocmd")
  filetype plugin indent on
  augroup vimrcEx
  au!
  autocmd FileType text setlocal textwidth=78
  autocmd BufReadPost *
    \ if line("'\"") > 1 && line("'\"") <= line("$") |
    \   exe "normal! g`\"" |
    \ endif
  augroup END
else
  set autoindent		" always set autoindenting on
endif " has("autocmd")

if !exists(":DiffOrig")
  command DiffOrig vert new | set bt=nofile | r # | 0d_ | diffthis
		  \ | wincmd p | diffthis
endif

" Platform
function! MySys()
	if has("win32") || has("win64")
    	return "windows"
	elseif has("mac")
		return "mac"
	else
    	return "linux"
  	endif
endfunction

"if MySys() == 'mac' || MySys() == 'linux'
	"set shell=/bin/bash\ -l
"endif

set encoding=utf-8
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936

" Move Backup Files to ~/.vim/backups/
set backupdir=~/.vim/backups
set directory=~/.vim/backups
set nobackup 
set nowritebackup 

set shiftwidth=4
set tabstop=4
set expandtab  " space代替tab输入
set nowrap
set wildmenu
set matchpairs=(:),{:},[:],<:>
set whichwrap=b,s,<,>,[,]
set foldmethod=indent

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 软件界面配置
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("gui_running") || has("gui_macvim")
	colorscheme yytextmate
	let g:colors_name="yytextmate"
else
	colorscheme evening
endif

if MySys() == "mac"
	""set guifont=Courier:h11
	""set guifontwide=SimHei:h11
elseif MySys() == "linux"
	set guifont=Monospace
endif

set anti
set linespace=2 
set number
set numberwidth=4
set equalalways
set guitablabel=%t

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" filetype and syntax
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
let g:javascript_enable_domhtmlcss=1
let g:xml_use_xhtml = 1 "for xml.vim

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MacVim
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
if has("gui_macvim")

	set columns=171
	set lines=58
	winpos 52 42 

	let macvim_skip_cmd_opt_movement = 1
	let macvim_hig_shift_movement = 1

	set fuopt=maxvert,maxhorz

	set transparency=8
	set guioptions-=T "egmrt
	"set guioptions+=b 
	set guioptions-=l
	set guioptions-=L
	set guioptions-=r
	set guioptions-=R
	
	macm File.New\ Tab						key=<D-T>
	macm File.Save<Tab>:w					key=<D-s>
	macm File.Save\ As\.\.\.<Tab>:sav		key=<D-S>
	macm Edit.Undo<Tab>u					key=<D-z> action=undo:
	macm Edit.Redo<Tab>^R					key=<D-Z> action=redo:
	macm Edit.Cut<Tab>"+x					key=<D-x> action=cut:
	macm Edit.Copy<Tab>"+y					key=<D-c> action=copy:
	macm Edit.Paste<Tab>"+gP				key=<D-v> action=paste:
	macm Edit.Select\ All<Tab>ggVG			key=<D-A> action=selectAll:
	macm Window.Toggle\ Full\ Screen\ Mode	key=<D-F>
	macm Window.Select\ Next\ Tab			key=<D-}>
	macm Window.Select\ Previous\ Tab		key=<D-{>
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" autocmd
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

autocmd! bufwritepost .vimrc source ~/.vimrc
autocmd! bufwritepost vimrc source ~/.vimrc

"let g:jslint_neverAutoRun=1
let g:jslint_command = 'jsl'
let g:jslint_command_options = '-nofilelisting -nocontext -conf ~/.jsl.conf -nosummary -nologo -process'
map <F5> :call JavascriptLint()<cr>

"autocmd BufRead * :lcd! %:p:h

" filetype
"autocmd BufNewFile,BufRead *.vm setlocal ft=html

""autocmd BufNewFile,BufRead *.{tpl} set filetype=html
" language support
autocmd FileType python setlocal expandtab shiftwidth=4 tabstop=4 softtabstop=4 textwidth=79
autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2

" for AutoComplPop
autocmd FileType html setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags

" NERDTree dont fold
autocmd FileType nerdtree setlocal foldmethod=marker


"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" commands
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! GetMySession(spath, ssname)
	if a:ssname == 0
		let a:sname = ""
	else
		let a:sname = "-".a:ssname
	endif
	execute "source $".a:spath."/session".a:sname.".vim"
	execute "rviminfo $".a:spath."/session".a:sname.".viminfo"
	execute "echo \"Load Success\: $".a:spath."/session".a:sname.".vim\""
endfunction

function! SetMySession(spath, ssname)
	if a:ssname == 0
		let a:sname = ""
	else
		let a:sname = "-".a:ssname
	endif
	execute "cd $".a:spath
	execute "mksession! $".a:spath."/session".a:sname.".vim"
	execute "wviminfo! $".a:spath."/session".a:sname.".viminfo"
	execute "echo \"Save Success\: $".a:spath."/session".a:sname.".vim\""
endfunction
" load session from path
command! -nargs=+ LOAD call GetMySession(<f-args>) 
" save session
command! -nargs=+ SAVE call SetMySession(<f-args>) 


" for make & debug

function! QFSwitch() " toggle quickfix window
	redir => ls_output
		execute ':silent! ls'
	redir END

	let exists = match(ls_output, "[Quickfix List")
	if exists == -1
		execute ':copen'
	else
		execute ':cclose'
	endif
endfunction

function! MyMake()
	exe 'call ' . b:myMake . '()'
endfunction

function! MyLint()
	exe 'call ' . b:myLint . '()'
endfunction

function! MyDebug()
	exe 'call ' . b:myDebug . '()'
endfunction

function! MySetBreakPoint()
	exe 'call ' . b:mySetBreakPoint . '()'
endfunction

function! MySetLog()
	exe 'call ' . b:mySetLog. '()'
endfunction

function! MyRemoveBreakPoint()
	exe 'call ' . b:myRemoveBreakPoint . '()'
endfunction

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" map
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let mapleader=","
let g:mapleader=","

map <silent> <leader>rc :tabe ~/.vim/vimrc<cr>
map <leader>q :q<cr>

" for make & debug
"noremap <F2> <ESC>:call MyLint()<CR>
"noremap <F3> :call MyDebug()<CR>
"noremap <F4> :call MyMake()<CR>
"noremap <F5> <ESC>:call QFSwitch()<CR>
"noremap <F6> :call MySetBreakPoint()<CR>
"noremap <F7> :call MySetLog()<CR>
"noremap <F8> :call MyRemoveBreakPoint()<CR>


nmap <tab> 		v>
nmap <s-tab> 	v<
vmap <tab> 		>gv 
vmap <s-tab> 	<gv

" map cmd to ctrl
if MySys() == "mac"
	map <D-y> <C-y>
	map <D-e> <C-e>
	map <D-f> <C-f>
	map <D-b> <C-b>
	map <D-u> <C-u>
	map <D-d> <C-d>
	map <D-w> <C-w>
	map <D-r> <C-r>
	map <D-o> <C-o>
	map <D-i> <C-i>
	map <D-g> <C-g>
	map <D-a> <C-a>
	map <D-]> <C-]>
	cmap <D-d> <C-d>
	imap <D-e> <C-e>
	imap <D-y> <C-y>
endif

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" plugin setting
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" bufExplorer setting
"let g:bufExplorerSortBy='mru'
"let g:bufExplorerSplitRight=0        " Split left.
"let g:bufExplorerSplitVertical=1     " Split vertically.
"let g:bufExplorerSplitVertSize = 30  " Split width
"let g:bufExplorerUseCurrentWindow=1  " Open in new window.
"let g:bufExplorerMaxHeight=25
"let g:bufExplorerResize=1
"autocmd BufWinEnter \[Buf\ List\] setl nonumber

" é»˜è®¤é”®æ˜ å°„ <leader>bv :VSBufExplorer
"

" tasklist
"nmap <silent> <leader>tl :TaskList<CR>


" taglists setting
"nmap <silent> <leader>tg :TlistToggle<CR>
"let Tlist_Use_SingleClick=1
"Tlist_Process_File_Always=1
"let Tlist_File_Fold_Auto_Close=1
"let Tlist_Exit_OnlyWindow = 1
"let Tlist_Show_Menu=1
"let Tlist_GainFocus_On_ToggleOpen=1
"let Tlist_Close_OnSelect=1
"let Tlist_Compact_Format=1
"let Tlist_Use_Right_Window = 1
"let Tlist_WinWidth = 30
"let Tlist_Inc_Winwidth = 0

"let g:tlist_javascript_settings = 'javascript;f:function;c:class;o:object;m:method;s:string;a:array;n:constant'

" winManager setting
"let g:winManagerWindowLayout="BufExplorer,FileExplorer|taglist" 
"let g:winManagerWidth = 30
"let g:defaultExplorer = 0
"nmap <silent> <leader>wm :WMToggle<cr> 

" netrw setting
"let g:netrw_winsize = 30
"nmap <silent> <leader>fe :Sexplore!<cr>

" NERDTree setting
nmap <silent> <leader>nt :NERDTree<cr>

" Most Recently Used (MRU)
"nmap <silent> <leader>r :MRU<cr>

" FuzzyFinder setting
"nmap <leader>fb :FuzzyFinderBuffer<cr>
"nmap <leader>ff	:FuzzyFinderFile<cr>
"nmap <leader>fd	:FuzzyFinderDir<cr>
"nmap <leader>fe	:FuzzyFinderMruFile<cr>
"nmap <leader>fc	:FuzzyFinderMruCmd<cr>
"nmap <leader>fm	:FuzzyFinderBookmark<cr>
""nmap <leader>ft	:FuzzyFinderTag<cr>
"nmap <leader>ft	:FuzzyFinderTaggedFile<cr>
"nmap <leader>fb :FufBuffer<cr>
"nmap <leader>ff :FufFile<cr>
"nmap <leader>fd :FufDir<cr>
"nmap <leader>fa :FufBookmark<cr>



"let NERDCreateDefaultMappings=0
"let NERDShutUp=1
"let g:NERDCommenterLeader="<leader>n" " change NERD_commenter.vim

"let VCSCommandSVKExec='disabled no such executable'

" Use neocomplcache.
"let g:NeoComplCache_EnableAtStartup = 1
"" Use smartcase.
"let g:NeoComplCache_SmartCase = 1
"" Use camel case completion.
"let g:NeoComplCache_EnableCamelCaseCompletion = 1
"" Use underbar completion.
"let g:NeoComplCache_EnableUnderbarCompletion = 1 

nnoremap <silent><F1> :JSHint<CR>
inoremap <silent><F1> <C-O>:JSHint<CR>
vnoremap <silent><F1> :JSHint<CR>
cnoremap <F1> JSHint

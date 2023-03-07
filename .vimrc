autocmd BufWritePost $MYVIMRC source $MYVIMRC
"
" 关闭兼容模式
set nocompatible
"
set nu " 设置行号
set cursorline "突出显示当前行
" set cursorcolumn " 突出显示当前列
set showmatch " 显示括号匹配
"
" tab 缩进
set tabstop=4 " 设置Tab长度为4空格
set shiftwidth=4 " 设置自动缩进长度为4空格
set autoindent " 继承前一行的缩进方式，适用于多行注释

set backspace=indent,eol,start

" 定义快捷键的前缀，即<Leader>
let mapleader=";" 
"
" ==== 系统剪切板复制粘贴 ====
" v 模式下复制内容到系统剪切板
vmap <Leader>c "+yy
" n 模式下复制一行到系统剪切板
nmap <Leader>c "+yy
" n 模式下粘贴系统剪切板的内容
nmap <Leader>v "+p
"
" 开启实时搜索
set incsearch
" 搜索时大小写不敏感
"
"
set nobackup
set nowritebackup
set noswapfile    " http://robots.thoughtbot.com/post/18739402579/global-gitignore#comment-458413287
set history=50
set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands
set confirm       " Need confrimation while exit
set fileencodings=utf-8,gb18030,gbk,big5

autocmd InsertLeave * se nocul  " 用浅色高亮当前行 

autocmd InsertEnter * se cul    " 用浅色高亮当前行 
set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ %{strftime(\"%d/%m/%y\ -\ %H:%M\")}   "状态行显示的内容 

set laststatus=1    " 启动显示状态行(1),总是显示状态行(2) 


"新建.c,.h,.sh,.java文件，自动插入文件头
autocmd BufNewFile *.cpp,*.[ch],*.sh,*.java,*.py exec ":call SetTitle()"
""定义函数SetTitle，自动插入文件头
func SetTitle()
    "如果文件类型为.sh文件
    if &filetype == 'sh'
        call setline(1,"\#########################################################################")
        call append(line("."), "\# File Name: ".expand("%"))
        call append(line(".")+1, "\# Author: scq")
        call append(line(".")+2, "\# mail: 1134762940@qq.com")
        call append(line(".")+3, "\# Created Time: ".strftime("%c"))
        call append(line(".")+4, "\#########################################################################")
        call append(line(".")+5, "\#!/bin/bash")
        call append(line(".")+6, "")
    else
        call setline(1, "/*************************************************************************")
        call append(line("."), "    > File Name: ".expand("%"))
        call append(line(".")+1, "    > Author: scq")
        call append(line(".")+2, "    > Mail: 1134762940@qq.com ")
        call append(line(".")+3, "    > Created Time: ".strftime("%c"))
        call append(line(".")+4, " ************************************************************************/")
        call append(line(".")+5, "")
    endif
    if &filetype == 'cpp'
        call append(line(".")+6, "#include<iostream>")
        call append(line(".")+7, "using namespace std;")
        call append(line(".")+8, "")
    endif
    if &filetype == 'c'
        call append(line(".")+6, "#include<stdio.h>")
        call append(line(".")+7, "")
    endif
    if &filetype == 'python'
        call setline(1,"#!/usr/bin/env python3")
        call append(line("."),"# -*- coding:UTF-8 -*-")
        call append(line(".")+1,"##########################################################################")
        call append(line(".")+2, "# File Name: ".expand("%"))
        call append(line(".")+3, "# Author: scq")
        call append(line(".")+4, "# Created Time: ".strftime("%c"))
        call append(line(".")+5, "##########################################################################")
    endif
    if &filetype == 'plaintex'
        call setline(1,"% -*- coding:UTF-8 -*-")
        call append(line("."),"%#########################################################################")
        call append(line(".")+1, "% File Name: ".expand("%"))
        call append(line(".")+2, "% Author: scq")
        call append(line(".")+3, "% Created Time: ".strftime("%c"))
        call append(line(".")+4, "%#########################################################################")
    endif
    "新建文件后，自动定位到文件末尾
    "autocmd BufNewFile * normal G
    normal G
endfunc

" 映射全选+复制 ctrl+a
map <C-A> ggVGY
map! <C-A> <Esc>ggVGY
map <F12> gg=G
" 选中状态下 Ctrl+c 复制
vmap <C-c> "+y
"去空行
nnoremap <F2> :g/^\s*$/d<CR>
"比较文件
nnoremap <C-F2> :vert diffsplit
"新建标签
map <M-F2> :tabnew<CR>
"列出当前目录文件
map <F3> :tabnew .<CR>
"打开树状文件目录
map <C-F3> \be
"C，C++ 按F5编译运行
map <F5> :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        exec "!g++ % -o %<"
        exec "! ./%<"
    elseif &filetype == 'cpp'
        exec "!g++ % -o %<"
        exec "! ./%<"
    elseif &filetype == 'java'
        exec "!javac %"
        exec "!java %<"
    elseif &filetype == 'sh'
        :!./%
    endif
endfunc
"C,C++的调试
map <F8> :call Rungdb()<CR>
func! Rungdb()
    exec "w"
    exec "!g++ % -g -o %<"
    exec "!gdb ./%<"
endfunc

filetype plugin indent on 
"打开文件类型检测, 加了这句才可以用智能补全
set completeopt=longest,menu

set hlsearch "开启搜索结果的高亮显示"
set incsearch "边输入边搜索(实时搜索)"

"NERDTree配置{{{
map <F3> :NERDTreeToggle<CR>
let NERDTreeChDirMode=2  "选中root即设置为当前目录
"let NERDTreeQuitOnOpen=1 "打开文件时关闭树
let NERDTreeShowBookmarks=1 "显示书签
let NERDTreeMinimalUI=1 "不显示帮助面板
let NERDTreeDirArrows=1 "目录箭头 1 显示箭头  0传统+-|号
let NERDChristmasTree=1
let NERDTreeMouseMode=2
"autocmd BufRead *  25vsp . "自动开启NerdTree
"}}}
"
"
"设置窗口排布方式
"let g:AutoOpenWinManager=1
let g:NERDTree_title="[NERDTree]"
let g:winManagerWindowLayout="NERDTree|TagList"

function! NERDTree_Start()
        exec 'NERDTree'
endfunction

function! NERDTree_IsValid()
        return 1
endfunction
map <C-B> :WMToggle<CR>

"在状态栏显示正在输入的命令
set showcmd
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab


set foldenable      " 允许折叠 

set foldmethod=manual   " 手动折叠 


set ignorecase
syntax enable
syntax on                    " 开启文件类型侦测
filetype plugin indent on    " 启用自动补全
"
"
"set statusline=%1*\%<%.50F\             "显示文件名和文件路径 
"set statusline+=%=%2*\%y%m%r%h%w\ %*        "显示文件类型及文件状态
"set statusline+=%3*\%{&ff}\[%{&fenc}]\ %*   "显示文件编码类型
"set statusline+=%4*\ row:%l/%L,col:%c\ %*   "显示光标所在行和列
"set statusline+=%5*\%3p%%\%*            "显示光标前文本所占总文本的比例
"hi User1 cterm=none ctermfg=25 ctermbg=0 
"hi User2 cterm=none ctermfg=208 ctermbg=0
"hi User3 cterm=none ctermfg=169 ctermbg=0
"hi User4 cterm=none ctermfg=100 ctermbg=0
"hi User5 cterm=none ctermfg=green ctermbg=0

" 设置背景透明
hi Normal ctermfg=252 ctermbg=none
"寻找下一搜索结果，并将其置于屏幕中心
noremap = nzz
"寻找上一搜索结果，并将其置于屏幕中心
noremap - Nzz


" 退出插入模式指定类型的文件自动保存
au InsertLeave *.go,*.sh,*.php,*.py write

if has("autocmd")

  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif
endif


" 设置注释快捷键

"map <LEADER>r :call Note()<CR>
func! Note()
    if &filetype == 'python'
        normal 0i#
    endif
    if &filetype == 'vim'
        normal 0i"
    endif
    if &filetype == 'plaintex'
        normal 0i%
    endif
endfunc
" 设置取消注释
map <LEADER>t 0df j
"编译运行
map <F5> :call RunPython()<CR>
func! RunPython()
    exec "W"
    if &filetype == 'python'
       " exec "!time python3.6 %"
    "exec ":set splitbelow<CR>:split<CR>"
    exec "!time python3.6 %"

    endif
    if &filetype == 'dot'
    exec "!dot % -T png -o %.png"
    exec "!feh %.png"
    endif
endfunc

"colorscheme molokai
set t_Co=256            "开启256色支持
"set background=dark

autocmd BufWritePost $NYVIMRC source $MYVIMRC

call plug#begin('~/.vim/plugged')
"
" Shorthand notation; fetches https://github.com/junegunn/vim-easy-align
" 可以快速对齐的插件
"Plug 'junegunn/vim-easy-align'
"Plug 'https://hub.fastgit.org/junegunn/vim-easy-align.git'
"
" 用来提供一个导航目录的侧边栏
"Plug 'scrooloose/nerdtree'
"
" 可以使 nerdtree 的 tab 更加友好些
"Plug 'jistr/vim-nerdtree-tabs'
"
" 可以在导航目录中看到 git 版本信息
"Plug 'Xuyuanp/nerdtree-git-plugin'
"
" 查看当前代码文件中的变量和函数列表的插件，
" 可以切换和跳转到代码中对应的变量和函数的位置
" 大纲式导航, Go 需要 https://github.com/jstemmer/gotags 支持
"Plug 'majutsushi/tagbar'
"
" 自动补全括号的插件，包括小括号，中括号，以及花括号
"Plug 'jiangmiao/auto-pairs'
"
" Vim状态栏插件，包括显示行号，列号，文件类型，文件名，以及Git状态
"Plug 'vim-airline/vim-airline'
"
" 有道词典在线翻译
"Plug 'ianva/vim-youdao-translater'
"
" 代码自动完成，安装完插件还需要额外配置才可以使用
"Plug 'Valloric/YouCompleteMe'
"
" 可以在文档中显示 git 信息
"Plug 'airblade/vim-gitgutter'
"
"
" 下面两个插件要配合使用，可以自动生成代码块
"Plug 'SirVer/ultisnips'
"Plug 'honza/vim-snippets'
"
" 可以在 vim 中使用 tab 补全
"Plug 'vim-scripts/SuperTab'
"
" 可以在 vim 中自动完成
"Plug 'Shougo/neocomplete.vim'
"
"
" 配色方案
" colorscheme neodark
"Plug 'KeitaNakamura/neodark.vim'
"Plug 'https://hub.fastgit.org/KeitaNakamura/neodark.vim.git'
" colorscheme monokai
"Plug 'crusoexia/vim-monokai'
" colorscheme github 
"Plug 'cormacrelf/vim-colors-github'

colorscheme one 
"Plug 'rakr/vim-one'
"
" go 主要插件
"Plug 'fatih/vim-go', { 'tag': '*' }
" go 中的代码追踪，输入 gd 就可以自动跳转
"Plug 'dgryski/vim-godef'
"
" markdown 插件
"Plug 'iamcco/mathjax-support-for-mkdp'
"Plug 'iamcco/markdown-preview.vim'
"
" 插件结束的位置，插件全部放在此行上面
Plug 'https://hub.fastgit.org/Valloric/YouCompleteMe.git'
Plug 'https://hub.fastgit.org/cormacrelf/vim-colors-github.git'
Plug 'https://hub.fastgit.org/KeitaNakamura/neodark.vim.git'
Plug 'https://hub.fastgit.org/scrooloose/nerdtree.git'
Plug 'https://hub.fastgit.org/Xuyuanp/nerdtree-git-plugin.git'
Plug 'https://hub.fastgit.org/ianva/vim-youdao-translater.git'
Plug 'https://hub.fastgit.org/rakr/vim-one.git'
Plug 'https://hub.fastgit.org/jiangmiao/auto-pairs.git'
Plug 'https://hub.fastgit.org/majutsushi/tagbar.git'
Plug 'https://hub.fastgit.org/crusoexia/vim-monokai.git'
Plug 'https://hub.fastgit.org/fatih/vim-go.git'
Plug 'https://hub.fastgit.org/iamcco/mathjax-support-for-mkdp.git'
Plug 'https://hub.fastgit.org/jistr/vim-nerdtree-tabs.git'
Plug 'https://hub.fastgit.org/airblade/vim-gitgutter.git'
Plug 'https://hub.fastgit.org/vim-airline/vim-airline.git'
Plug 'https://hub.fastgit.org/junegunn/vim-easy-align.git'
Plug 'https://hub.fastgit.org/sainnhe/lightline_foobar.vim.git'
Plug 'https://hub.fastgit.org/itchyny/lightline.vim.git'
Plug 'https://hub.fastgit.org/andrewstuart/vim-kubernetes.git'

"Plug 'https://hub.fastgit.org/iamcco/markdown-preview.nvim.git''


call plug#end()


let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1

let g:go_fmt_experimental = 1

let g:go_gopls_enabled = 0

let g:go_bin_path="/root/go/bin"


"lightline
"set noshowmode

let g:lightline = {
      \ 'colorscheme': 'nord',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'FugitiveHead'
      \ },
      \ }
" 设置配色方案

colorscheme neodark

"autocmd BufNewFile *.py exec ":call SetTitle()"

""F9触发，设置宽度为30
let g:tagbar_width = 30
nmap <F9> :TagbarToggle<CR>

let g:tagbar_autopreview = 1

let g:tagbar_sort = 0


au FileType yaml nmap <leader>r : KubeApply<CR>

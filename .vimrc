set backspace=indent,eol,start  
set tabstop=4       " Tab键替换的空格长度，默认8
set softtabstop=4   " 退格键退回缩进空格的长度
set shiftwidth=4    " 表示每一级缩进的长度
set expandtab       " 设置缩进用空格来表示
set hlsearch
set showmatch       " 显示括号匹配
set ruler
set number
set cursorline
syntax on 
let mapleader=","   " 修改<leader>

autocmd FileType html setlocal ts=2 sts=2 sw=2
autocmd FileType ruby setlocal ts=2 sts=2 sw=2
autocmd FileType javascript setlocal ts=2 sts=2 sw=2
autocmd FileType typescript setlocal ts=2 sts=2 sw=2
autocmd FileType yaml setlocal ts=2 sts=2 sw=2
autocmd FileType yml setlocal ts=2 sts=2 sw=2
autocmd FileType toml setlocal ts=2 sts=2 sw=2

" 分屏快捷键
nmap <C-b> :split<CR>
map <C-v> :vsplit<CR>
nmap <C-c> :close<CR>
" 分屏跳转
map <C-j> <C-W>j
map <C-k> <C-W>k
map <C-h> <C-W>h
map <C-l> <C-W>l
" 关闭buffer
map <C-x> :bp<cr>:bd #<cr>

" 插件
call plug#begin('~/.vim/plugged')

" 用来提供一个导航目录的侧边栏
Plug 'scrooloose/nerdtree'

" 可以使 nerdtree 的 tab 更加友好些
Plug 'jistr/vim-nerdtree-tabs'
" 注释插件
Plug 'preservim/nerdcommenter'

" 配色方案
Plug 'crusoexia/vim-monokai'
Plug 'thenewvu/vim-colors-arthur'
Plug 'tomasiser/vim-code-dark'
Plug 'romgrk/doom-one.vim'
Plug 'joshdick/onedark.vim'
Plug 'morhetz/gruvbox'

" 模糊搜索插件
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'

" go 主要插件
Plug 'fatih/vim-go', { 'tag': '*' }

" go 中的代码追踪，输入 gd 就可以自动跳转
" Plug 'dgryski/vim-godef'

"代码补全插件
Plug 'neoclide/coc.nvim', {'branch': 'release'}

Plug 'ap/vim-buftabline'
Plug 'liyechen/vim-agriculture'

Plug 'ngemily/vim-vp4'

if has('nvim') || has('patch-8.0.902')
  Plug 'mhinz/vim-signify'
else
  Plug 'mhinz/vim-signify', { 'branch': 'legacy' }
endif

call plug#end()

" 配色方案
set termguicolors
" colorscheme monokai
" set rtp+=~/.vim/plugged/vim-colors-arthur
" colorscheme arthur 
" colorscheme codedark 
" colorscheme doom-one
" colorscheme onedark
colorscheme gruvbox 

" 设置cursorline 颜色
" highlight CursorLine guibg=#3c3836

" vim-go 设置
let g:go_autodetect_gopath = 1
let g:go_list_type = "quickfix"

let g:go_version_warning = 1
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_highlight_methods = 1
let g:go_highlight_generate_tags = 1

" godef 设置
let g:godef_split=3

" nerdtree 设置
" 打开和关闭NERDTree快捷键
map <leader>nn :NERDTreeToggle<CR>
map <leader>nf :NERDTreeFind<CR>
" 显示行号
let NERDTreeShowLineNumbers=1
" 打开文件时是否显示目录
let NERDTreeAutoCenter=1
" 是否显示隐藏文件
let NERDTreeShowHidden=0
" 设置宽度
" let NERDTreeWinSize=31
" 忽略一下文件的显示
let NERDTreeIgnore=['\.pyc','\~$','\.swp']
" 打开 vim 文件及显示书签列表
let NERDTreeShowBookmarks=2

" buftable shortcut
map <C-q> :bprevious<cr>
map <C-e> :bnext<cr>

" fzf
let g:fzf_preview_window = ['down:75%', 'ctrl-/']
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.85, 'border': 'sharp' } }
map <C-p> :Files<cr>

" fzf vim-agriculture mapping
vmap <Leader>f <Plug>AgRawVisualSelection
nmap <Leader>f <Plug>AgRawWordUnderCursor

" coc.nvim mapping
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
map <C-]> <Plug>(coc-definition)

" nerdcommenter
let g:NERDSpaceDelims = 1
let g:NERDCompactSexyComs = 1

" 显示当前行的所属函数
fun! ShowFuncName()
    let lnum = line(".")
    let col = col(".")
    echohl ModeMsg
    echo getline(search("^[^ \t#/]\\{2}.*[^:]\s*$", 'bW'))
    echohl None
    call search("\\%" . lnum . "l" . "\\%" . col . "c")
endfun
map f :call ShowFuncName() <CR>

" tab自动补全 
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()



""""""""""""""""""""""""""""""""""""""""""""
" avoid scrolling window from switch buffers
" Save current view settings on a per-window, per-buffer basis.
function! AutoSaveWinView()
    if !exists("w:SavedBufView")
        let w:SavedBufView = {}
    endif
    let w:SavedBufView[bufnr("%")] = winsaveview()
endfunction

" Restore current view settings.
function! AutoRestoreWinView()
    let buf = bufnr("%")
    if exists("w:SavedBufView") && has_key(w:SavedBufView, buf)
        let v = winsaveview()
        let atStartOfFile = v.lnum == 1 && v.col == 0
        if atStartOfFile && !&diff
            call winrestview(w:SavedBufView[buf])
        endif
        unlet w:SavedBufView[buf]
    endif
endfunction

" When switching buffers, preserve window view.
if v:version >= 700
    autocmd BufLeave * call AutoSaveWinView()
    autocmd BufEnter * call AutoRestoreWinView()
endif
"""""""""""""""""""""""""""""""""""""""""""""

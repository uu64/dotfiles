"        _
" __   _(_)_ __ ___  _ __ ___
" \ \ / / | '_ ` _ \| '__/ __|
"  \ V /| | | | | | | | | (__
" (_)_/ |_|_| |_| |_|_|  \___|

" Initialize
if &compatible
  set nocompatible
endif
let g:python3_host_prog = $PYENV_ROOT . '/shims/python'


" Appearance
set cursorline
set title
set number
set numberwidth=5
set list
set signcolumn=yes
set laststatus=2
set showtabline=2
set splitbelow
set splitright
set listchars=eol:¬,tab:▸\ ,space:.
autocmd VimEnter,Colorscheme * highlight NonText guibg=NONE ctermbg=None guifg=#3e445e ctermfg=237
autocmd VimEnter,Colorscheme * highlight SpecialKey guibg=NONE ctermbg=None guifg=#3e445e ctermfg=237


" Indent
set autoindent
set tabstop=4
set shiftwidth=4
set expandtab


" Fold
set foldlevel=100


" Encoding
set encoding=utf-8
scriptencoding utf-8
set fileencodings=ucs-bom,utf-8,iso-2022-jp,sjis,cp932,euc-jp,cp20932


" Clipboard
set clipboard=unnamed,unnamedplus


" Nvim
if has('nvim')
  set inccommand=split
endif


" File Types
augroup vimrc_filetype
  autocmd!
  autocmd BufRead,BufNewFile *.md setfiletype markdown
  autocmd BufRead,BufNewFile *.txt setfiletype markdown
  autocmd BufRead,BufNewFile *.go setfiletype go
augroup END


" KeyMap
let g:mapleader = "\<Space>"

" semicolon to colon
noremap ; :

" jj is Esc
inoremap <silent> jj <ESC>

" Home / End
noremap <Leader>h ^
noremap <Leader>H 0
noremap <Leader>l $

" Move windows
nnoremap <Leader><Tab> <C-w>w
nnoremap <Leader>ws :split<CR>
nnoremap <Leader>wv :vsplit<CR>
nnoremap <Leader>wh <C-w>h
nnoremap <Leader>wj <C-w>j
nnoremap <Leader>wk <C-w>k
nnoremap <Leader>wl <C-w>l
nnoremap <Leader>wt <C-w>t
nnoremap <Leader>wb <C-w>b

" Move tabs
nnoremap tl :tabnext<CR>
nnoremap th :tabprev<CR>

" File search
nnoremap <C-p> :GFiles<CR>

" Quickly open/reload vim
nnoremap <Leader>ve :split $MYVIMRC<CR>
nnoremap <Leader>vs :source $MYVIMRC<CR>

" Save
nnoremap <Leader>s :w<CR>

" Buffer
nnoremap <Leader>bp :bprevious<CR>
nnoremap <Leader>bn :bnext<CR>
nnoremap <Leader>bb :b#<CR>
nnoremap <Leader>bd :bdelete<CR>


" Plugins
let s:config_home = empty($XDG_CONFIG_HOME) ? expand('~/.config') : $XDG_CONFIG_HOME
let s:dein_config_dir = s:config_home . '/nvim'

let s:cache_home = empty($XDG_CACHE_HOME) ? expand('~/.cache') : $XDG_CACHE_HOME
let s:dein_dir = s:cache_home . '/dein'
let s:dein_repo_dir = s:dein_dir . '/repos/github.com/Shougo/dein.vim'

if !isdirectory(s:dein_repo_dir)
  call system('git clone https://github.com/Shougo/dein.vim ' . shellescape(s:dein_repo_dir))
endif

let &runtimepath = s:dein_repo_dir . ',' . &runtimepath

if dein#load_state(s:dein_dir)
  call dein#begin(s:dein_dir)
  call dein#load_toml(s:dein_config_dir . '/dein/plugins.toml')

  " " lazy load
  " call dein#add('plasticboy/vim-markdown', {'lazy': 1, 'on_ft': ['markdown', 'txt']})

  call dein#end()
  call dein#save_state()
endif

if dein#check_install()
  call dein#install()
endif


" " dense-analysis/ale
" let g:ale_linters = {
"       \ 'go': ['golint', 'go vet']
"       \ }
" let g:ale_fixers = {
"       \ 'go': ['goimports']
"       \ }
" let g:ale_fix_on_save = 1


" Color Scheme
colorscheme iceberg
set termguicolors
set background=dark
syntax on


" finally
filetype plugin indent on


"        _
" __   _(_)_ __ ___  _ __ ___
" \ \ / / | '_ ` _ \| '__/ __|
"  \ V /| | | | | | | | | (__
" (_)_/ |_|_| |_| |_|_|  \___|

" Indent
set tabstop=4
set shiftwidth=4
set expandtab
set list
set listchars=tab:»-,nbsp:%

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

" Other
set cursorline
set title
set number
" set noshowmode

" FIle Types
augroup vimrc_filetype
  autocmd!
  autocmd BufRead,BufNewFile *.md set filetype=markdown
  autocmd BufRead,BufNewFile *.txt set filetype=markdown
augroup END

" KeyMap
let g:mapleader = "\<Space>"

" jj is Esc
inoremap <silent> jj <ESC>

" Home / End
noremap <Leader>h ^
noremap <Leader>H 0
noremap <Leader>l $

" Plugins
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim
call dein#begin('~/.vim/dein')

call dein#add('Yggdroot/indentLine')
if has('nvim')
  call dein#add('Shougo/deoplete.nvim')
endif

" Lazy load
" markdown
call dein#add('rcmdnk/vim-markdown', {'on_ft' : ['markdown', 'txt']})

call dein#end()

" finally
filetype plugin indent on
syntax enable

if dein#check_install()
  call dein#install()
endif
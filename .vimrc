"        _
" __   _(_)_ __ ___  _ __ ___
" \ \ / / | '_ ` _ \| '__/ __|
"  \ V /| | | | | | | | | (__
" (_)_/ |_|_| |_| |_|_|  \___|

" Initialize
if &compatible
  set nocompatible
endif
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

" Appearance
set cursorline
set title
set number
set numberwidth=5
set list
set listchars=eol:¬,tab:▸\ ,space:.
" set noshowmode

" Indent
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

" Move windows
nnoremap <Leader><Tab> <C-w>w
nnoremap sh <C-w>h
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap st <C-w>t
nnoremap sb <C-w>b

" Plugins
set runtimepath+=~/.vim/dein/repos/github.com/Shougo/dein.vim
call dein#begin('~/.vim/dein')

call dein#add('cocopon/iceberg.vim')
call dein#add('itchyny/lightline.vim')
call dein#add('ryanoasis/vim-devicons')
call dein#add('tpope/vim-commentary')
call dein#add('tpope/vim-fugitive')
if has('nvim')
  call dein#add('Shougo/deoplete.nvim')
endif

" Lazy load
" markdown
call dein#add('rcmdnk/vim-markdown', {'on_ft' : ['markdown', 'txt']})

call dein#end()

" itchyny/lightline.vim
let g:lightline = {
    \ 'colorscheme': 'seoul256',
    \ 'active': {
    \   'left': [ [ 'mode', 'paste' ],
    \             [ 'gitbranch', 'readonly', 'filename', 'modified' ] ]
    \ },
    \ 'component_function': {
    \   'gitbranch': 'fugitive#head',
    \   'filetype': 'MyFiletype',
    \   'fileformat': 'MyFileformat',
    \ },
    \ }

function! MyFiletype()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() . ' ' : 'no ft') : ''
endfunction

function! MyFileformat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) . ' ' : ''
endfunction

" Color Scheme
colorscheme iceberg

" finally
filetype plugin indent on
syntax enable

if dein#check_install()
  call dein#install()
endif
call map(dein#check_clean(), "delete(v:val, 'rf')")

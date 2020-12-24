"        _
" __   _(_)_ __ ___  _ __ ___
" \ \ / / | '_ ` _ \| '__/ __|
"  \ V /| | | | | | | | | (__
" (_)_/ |_|_| |_| |_|_|  \___|

" Initialize
if &compatible
  set nocompatible
endif


" Appearance
set cursorline
set title
set number
set numberwidth=5
set list
set listchars=eol:¬,tab:▸\ ,trail:.
" set noshowmode
"

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
nnoremap sh <C-w>h
nnoremap sj <C-w>j
nnoremap sk <C-w>k
nnoremap sl <C-w>l
nnoremap st <C-w>t
nnoremap sb <C-w>b

" Move tabs
nnoremap tl :tabnext<CR>
nnoremap th :tabprev<CR>


" Plugins
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim
if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')
  call dein#add('Shougo/deoplete.nvim')

  if has('nvim')
    call dein#add('airblade/vim-gitgutter')
    call dein#add('cocopon/iceberg.vim')
    call dein#add('itchyny/lightline.vim')
    call dein#add('preservim/nerdtree')
    call dein#add('ryanoasis/vim-devicons')
    call dein#add('tpope/vim-commentary')
    call dein#add('tpope/vim-fugitive')
  endif

  " Lazy load
  " markdown
  call dein#add('rcmdnk/vim-markdown', {'on_ft' : ['markdown', 'txt']})

  call dein#end()
  call dein#save_state()
endif

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

" preservim/nerdtree
let NERDTreeShowHidden=1
nnoremap <leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>


" Color Scheme
colorscheme iceberg


" finally
filetype plugin indent on
syntax enable

if dein#check_install()
  call dein#install()
endif
call map(dein#check_clean(), "delete(v:val, 'rf')")

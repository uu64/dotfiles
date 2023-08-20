
" __   _(_)_ __ ___  _ __ ___
" \ \ / / | '_ ` _ \| '__/ __|
"  \ V /| | | | | | | | | (__
" (_)_/ |_|_| |_| |_|_|  \___|

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
autocmd VimEnter,Colorscheme * highlight SpecialKey guibg=NONE ctermbg=None guifg=#34445e ctermfg=237


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

" Search & Replace
nnoremap <silent> <Space><Space> :let @/ = '\<' . expand('<cword>') . '\>'<CR>:set hlsearch<CR>
nmap # <Space><Space>:%s/<C-r>///g<Left><Left>


" Manage plugins
call plug#begin('~/.vim/plugged')
Plug 'cocopon/iceberg.vim'
Plug 'easymotion/vim-easymotion'
Plug 'itchyny/lightline.vim'
Plug 'jiangmiao/auto-pairs'
Plug 'lambdalisue/fern.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-surround'
call plug#end()

" easymotion/vim-easymotion
"" <Leader>f{char} to move to {char}
map  <Leader>f <Plug>(easymotion-bd-f)
nmap <Leader>f <Plug>(easymotion-overwin-f)
" s{char}{char} to move to {char}{char}
nmap s <Plug>(easymotion-overwin-f2)
" Move to line
map <Leader>L <Plug>(easymotion-bd-jk)
nmap <Leader>L <Plug>(easymotion-overwin-line)
" Move to word
map  <Leader>w <Plug>(easymotion-bd-w)
nmap <Leader>w <Plug>(easymotion-overwin-w)

" itchyny/lightline.vim
let g:lightline = {
  \ 'colorscheme': 'iceberg',
  \ 'active': {
  \   'left': [ [ 'mode', 'paste' ],
  \             [ 'gitbranch', 'filename', 'readonly', 'modified' ] ]
  \ },
  \ 'component_function': {
  \   'gitbranch': 'MyFugitive',
  \ },
  \ 'component_expand': {
  \   'buffers': 'lightline#bufferline#buffers'
  \ },
  \ 'component_type': {
  \   'buffers': 'tabsel'
  \ },
  \ 'tabline': {
  \   'left': [ ['buffers'] ],
  \   'right': [ ['close'] ]
  \ },
  \ }

" lambdalisue/fern.vim
let g:fern#renderer = "nerdfont"
let g:fern#default_hidden=1
nnoremap <C-n> :Fern . -reveal=% -drawer -toggle -width=40<CR>

" tpope/vim-fugitive
function! MyFugitive()
  let l:branch = FugitiveHead()
  return l:branch ==# "" ? "" : "\ue725 " . FugitiveHead()
endfunction

" Color Scheme
colorscheme iceberg
set termguicolors
set background=dark

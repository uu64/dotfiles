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
set listchars=eol:¬,tab:▸\ ,trail:.
set signcolumn=yes
set laststatus=2
set showtabline=2
set splitbelow
set splitright


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
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim
if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')

  call dein#add('airblade/vim-gitgutter')
  call dein#add('dense-analysis/ale')
  call dein#add('ghifarit53/tokyonight-vim')
  call dein#add('godlygeek/tabular')
  call dein#add('itchyny/lightline.vim')
  call dein#add('jiangmiao/auto-pairs')
  call dein#add('junegunn/fzf', { 'build': './install --all --no-bash', 'merged': 0 })
  call dein#add('junegunn/fzf.vim', { 'depends': 'fzf' })
  call dein#add('kassio/neoterm')
  call dein#add('preservim/nerdtree')
  call dein#add('ryanoasis/vim-devicons')
  call dein#add('simeji/winresizer')
  call dein#add('sheerun/vim-polyglot')
  call dein#add('tpope/vim-commentary')
  call dein#add('tpope/vim-fugitive')
  call dein#add('tpope/vim-surround')
  call dein#add('yuttie/comfortable-motion.vim')

  if has('nvim')
    call dein#add('neoclide/coc.nvim', {'branch': 'release'})
  endif

  " lazy load
  call dein#add('plasticboy/vim-markdown', {'lazy': 1, 'on_ft': ['markdown', 'txt']})

  call dein#end()
  call dein#save_state()
endif

" dense-analysis/ale
let g:ale_linters = {
      \ 'go': ['golint', 'go vet']
      \ }
let g:ale_fixers = {
      \ 'go': ['goimports']
      \ }
let g:ale_fix_on_save = 1

" itchyny/lightline.vim
let g:lightline = {
      \ 'colorscheme': 'tokyonight',
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

" kassio/neoterm
let g:neoterm_autoinsert = 1
let g:neoterm_autoscroll = 1
let g:neoterm_default_mod = 'belowright'
let g:neoterm_use_relative_path = 1
nnoremap <c-t><c-t> :Ttoggle<CR>
tnoremap <c-t><c-t> <C-\><C-n>:Ttoggle<CR>
tnoremap <silent> <ESC> <C-\><C-n>

" preservim/nerdtree
let NERDTreeShowHidden=1
nnoremap <Leader>n :NERDTreeFocus<CR>
nnoremap <C-n> :NERDTree<CR>
nnoremap <C-t> :NERDTreeToggle<CR>
nnoremap <C-f> :NERDTreeFind<CR>

" neoclide/coc.nvim
" if hidden is not set, TextEdit might fail.
set hidden

" Some servers have issues with backup files, see #649
set nobackup
set nowritebackup

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Key mappings for coc.nvim
nmap <silent> cd <Plug>(coc-definition)
nmap <silent> cy <Plug>(coc-type-definition)
nmap <silent> ci <Plug>(coc-implementation)
nmap <silent> crf <Plug>(coc-references)
nmap <silent> crn <Plug>(coc-rename)
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" yuttie/comfortable-motion.vim
set mouse=a
let g:comfortable_motion_no_default_key_mappings = 1
nnoremap <silent> <C-d> :call comfortable_motion#flick(100)<CR>
nnoremap <silent> <C-u> :call comfortable_motion#flick(-100)<CR>
noremap <ScrollWheelDown> :call comfortable_motion#flick(40)<CR>
noremap <ScrollWheelUp>   :call comfortable_motion#flick(-40)<CR>


" Color Scheme
let g:tokyonight_style = 'night'
let g:tokyonight_enable_italic = 1
colorscheme tokyonight
set termguicolors
set background=dark
syntax on


" finally
filetype plugin indent on

if dein#check_install()
  call dein#install()
endif
call map(dein#check_clean(), "delete(v:val, 'rf')")

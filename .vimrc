" docs
" NERDCommander http://www.vim.org/scripts/script.php?script_id=1218
"
" CTRL-B Page up
" CTRL-F Page down
" CTRL-U Half page up
" CTRL-D Half page down
"
" CTRL-W w Move cursor to window below/right of the current one
" CTRL-w R Rotage windows

" pathogen
filetype off
call pathogen#runtime_append_all_bundles()
filetype plugin indent on

" change my <leader> key
let mapleader=","

set nocompatible

set modelines=0

syntax on

" indent stuff
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

" misc stuff
" most come from http://stevelosh.com/blog/2010/09/coming-home-to-vim/
set encoding=utf-8
set scrolloff=3
set autoindent
set showmode
set showcmd
set hidden
set wildmenu
set wildmode=list:longest
set visualbell
set cursorline
set ruler
set backspace=indent,eol,start
set laststatus=2
set relativenumber " vim  7.3
set undofile " vim 7.3

" search and move
" from http://stevelosh.com/blog/2010/09/coming-home-to-vim/
nnoremap / /\v
vnoremap / /\v
set ignorecase
set smartcase
set gdefault
set incsearch
set showmatch
set hlsearch

" leader(,)+space to clear out search
nnoremap <leader><space> :noh<cr>

" handle long lines
" from http://stevelosh.com/blog/2010/09/coming-home-to-vim/
set wrap
set textwidth=79
set formatoptions=qrn1
set colorcolumn=85 " unkown to vim 7.2

" use the leader
nnoremap <leader>a :Ack
nnoremap <leader>* "zyiw:Ack <c-r>z<CR>
map <leader>ew :e <C-R>=expand("%:p:h")."/"<CR>
map <leader>es :sp <C-R>=expand("%:p:h")."/"<CR>
map <leader>ev :vsp <C-R>=expand("%:p:h")."/"<CR>
map <leader>et :tabe <C-R>=expand("%:p:h")."/"<CR>

" old stuff
map ** {!} par 70j<CR>
map *o {!} par 67j<CR>:/./,/^$/s/^/   /<CR>xx{jR o<ESC>
map *- {!} par 67j<CR>:/./,/^$/s/^/    /<CR>xx{jR  -<ESC>

map @o gqap{:/./,/^$/s/^/    /<CR>xx{jR o<ESC>
map ,< :s/^\(.*\)$/<!-- \1 -->/<CR><Esc>:nohlsearch<CR>

" http://github.com/hallettj/jslint.vim
map <F4> :JSLintLight<CR>
map <F5> :JSLint<CR>


" https://github.com/vim-scripts/YankRing.vim.git
nmap <F2> :YRShow<CR>

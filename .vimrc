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
call pathogen#infect()
filetype plugin indent on

" vim-plug
call plug#begin('~/.vim/plugged')
Plug 'raghur/vim-ghost', {'do': ':GhostInstall'}
Plug 'fabi1cazenave/suckless.vim'
Plug 'ambv/black'
call plug#end()

" change my <leader> key
let mapleader=","

set nocompatible

set modelines=0

syntax on

" source vimrc on write
if has("autocmd")
  autocmd! bufwritepost .vimrc source ~/.vimrc
endif

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
set textwidth=100
set formatoptions=qrn1
set colorcolumn=100 " unknown to vim 7.2

" alias unnamed register to the + register
" requires vim-gtk
set clipboard=unnamedplus

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

" write a file as root
cmap w!! w !sudo tee % >/dev/null

map @o gqap{:/./,/^$/s/^/    /<CR>xx{jR o<ESC>
map ,< :s/^\(.*\)$/<!-- \1 -->/<CR><Esc>:nohlsearch<CR>

" https://github.com/vim-scripts/YankRing.vim.git
nmap <F2> :YRShow<CR>

" https://github.com/vim-scripts/pep8
let g:pep8_map='<F3>'

" https://github.com/nvie/vim-flake8
autocmd BufWritePost *.py call Flake8()
"let g:flake8_ignore="E501,W293"

" taken from the https://github.com/tpope/vim-fugitive README
autocmd QuickFixCmdPost *grep* cwindow

" fzf
" https://github.com/junegunn/fzf
" https://statico.github.io/vim3.html
set rtp+=~/.fzf
nmap ; :Buffers<CR>
nmap <Leader>t :Files<CR>
nmap <Leader>r :Tags<CR>

" Use ag with Ack
" https://vimawesome.com/plugin/ack-vim
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

let g:syntastic_javascript_checkers = ['gjslint']
let g:syntastic_javascript_gjslint_conf = "-strict --custom_jsdoc_tags=todo"

" https://github.com/mattn/emmet-vim
let g:user_emmet_leader_key='<C-F>'

" https://github.com/Lokaltog/vim-easymotion
map <Leader>y <Plug>(easymotion-prefix)

" http://dmerej.info/blog/index.php/?post/2016/04/30/Vim-and-cwd
map <Leader>cd :lcd %:h<CR>

" https://github.com/vim-scripts/SQLUtilities
let g:sqlutil_align_comma=1

" UI
colorscheme torte

" status line
" https://github.com/tpope/vim-fugitive
set statusline=%<%f\ %h%m%r%{fugitive#statusline()}%=%-14.(%l,%c%V%)\ %P

" exclude patters for EditorConfig
" https://github.com/editorconfig/editorconfig-vim
let g:EditorConfig_exclude_patterns = ['fugitive://.*', 'scp://.*']

"black
let g:black_linelength = 100
let g:black_virtualenv = '~/.virtualenvs/main'

" bépo related
" http://bepo.fr/wiki/Vim
noremap w <C-w>
noremap W <C-w><C-w>
noremap <Leader><Leader> <C-w><C-w>
noremap wj <C-w>j
noremap wf <C-w>k
noremap wl <C-w>l
noremap wh <C-w>h
"noremap « <
"noremap » >
"inoremap « <
"inoremap » >
inoremap gq <Esc>
vnoremap gq <Esc>
inoremap <Tab> <Esc>
vnoremap <Tab> <Esc>
inoremap <S-Tab> <Tab>
vnoremap <S-Tab> <Tab>
noremap <BS> <C-U>
noremap <Space> <C-D>

" Markdown mappings
au FileType markdown inoremap <buffer> <Leader>sl <!SLIDE><Esc>FEa

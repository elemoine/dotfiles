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
set textwidth=79
set formatoptions=qrn1
set colorcolumn=85 " unkown to vim 7.2

" alias unnamed register to the + register
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

" http://github.com/hallettj/jslint.vim
map <F4> :JSLintLight<CR>
map <F5> :JSLint<CR>

" https://github.com/vim-scripts/YankRing.vim.git
nmap <F2> :YRShow<CR>

" https://github.com/vim-scripts/pep8
let g:pep8_map='<F3>'

" https://github.com/nvie/vim-flake8
autocmd BufWritePost *.py call Flake8()
"let g:flake8_ignore="E501,W293"

" taken from the https://github.com/tpope/vim-fugitive README
autocmd QuickFixCmdPost *grep* cwindow

" http://kien.github.com/ctrlp.vim/#installation
set runtimepath^=~/.vim/bundle/ctrlp.vim
let g:ctrlp_map = '<Leader>p'
let g:ctrlp_cmd = 'CtrlP'

let g:syntastic_javascript_checkers = ['gjslint']
let g:syntastic_javascript_gjslint_conf = "-strict --custom_jsdoc_tags=todo"

" https://github.com/mattn/emmet-vim
let g:user_emmet_leader_key='<C-F>'

" https://github.com/Lokaltog/vim-easymotion
map <Leader>y <Plug>(easymotion-prefix)

" UI
colorscheme torte

" bépo related
" http://bepo.fr/wiki/Vim
noremap w <C-w>
noremap W <C-w><C-w>
noremap <Leader><Leader> <C-w><C-w>
noremap wj <C-w>j
noremap wf <C-w>k
noremap wl <C-w>l
noremap wh <C-w>h
noremap « <
noremap » >
inoremap « <
inoremap » >
inoremap gq <Esc>
vnoremap gq <Esc>
inoremap <Tab> <Esc>
vnoremap <Tab> <Esc>
inoremap <S-Tab> <Tab>
vnoremap <S-Tab> <Tab>
noremap <BS> <C-U>
noremap <Space> <C-D>

" JavaScript mappings (essentially Closure-related)
au FileType javascript inoremap <buffer> <Leader>Fu function<Space>()<Space>{<CR>}<Esc>k$F(i
au FileType javascript inoremap <buffer> <Leader>br break;<CR>
au FileType javascript inoremap <buffer> <Leader>co @constructor
au FileType javascript inoremap <buffer> <Leader>de @define<Space>{}<Esc>i
au FileType javascript inoremap <buffer> <Leader>ei }<Space>else<Space>if<Space>()<Space>{<Esc>F(a
au FileType javascript inoremap <buffer> <Leader>el }<Space>else<Space>{<CR>
au FileType javascript inoremap <buffer> <Leader>en @enum<Space>{}<Esc>i
au FileType javascript inoremap <buffer> <Leader>ex @extends<Space>{}<Esc>i
au FileType javascript inoremap <buffer> <Leader>ga goog.asserts.assert();<Esc>F(a
au FileType javascript inoremap <buffer> <Leader>gb goog.base(this);<Esc>F)i
au FileType javascript inoremap <buffer> <Leader>gep <Esc>?}<CR>%^"jyt<Space>f{%ogoog.exportProperty(<CR><C-R>j,<CR><C-R>j);<Esc>k$i'<Esc>F.cl,<CR>'<Esc>2ji
au FileType javascript inoremap <buffer> <Leader>ges goog.exportSymbol('', );<Esc>F'i
au FileType javascript inoremap <buffer> <Leader>gi goog.inherits();<Esc>F(a
au FileType javascript inoremap <buffer> <Leader>gp goog.provide('');<Esc>F'i
au FileType javascript inoremap <buffer> <Leader>gr goog.require('');<Esc>F'i
au FileType javascript inoremap <buffer> <Leader>id @inheritDoc
au FileType javascript inoremap <buffer> <Leader>if if<Space>()<Space>{<CR>}<Esc>k$F(a
au FileType javascript inoremap <buffer> <Leader>im @implements<Space>{}<Esc>i
au FileType javascript inoremap <buffer> <Leader>in goog.isNull();<Esc>F(a
au FileType javascript inoremap <buffer> <Leader>fo for<Space>()<Space>{<CR>}<Esc>k$F(a
au FileType javascript inoremap <buffer> <Leader>f, function()<Space>{<CR>},<Esc>k$F(a
au FileType javascript inoremap <buffer> <Leader>f; function()<Space>{<CR>};<Esc>k$F(a
au FileType javascript inoremap <buffer> <Leader>fu function()<Space>{<CR>}<Esc>k$F(a
au FileType javascript inoremap <buffer> <Leader>pa @param<Space>{}<Esc>i
au FileType javascript inoremap <buffer> <Leader>pr @private
au FileType javascript inoremap <buffer> <Leader>re @return<Space>{}<Esc>i
au FileType javascript inoremap <buffer> <Leader>ty @type<Space>{}<Esc>i
au FileType javascript inoremap <buffer> <Leader>wh while<Space>()<Space>{<CR>}<Esc>k$F(a
au FileType javascript inoremap <buffer> <Leader>dc describe('',<Space>function()<Space>{<CR>});<Esc>k$F'i
au FileType javascript inoremap <buffer> <Leader>it it('',<Space>function()<Space>{<CR>});<Esc>k$F'i
au FileType javascript inoremap <buffer> <Leader>ex expect().toX();<Esc>0f(a
au FileType javascript inoremap <buffer> <Leader>bE beforeEach(function()<Space>{<CR>});<Esc>O
au FileType javascript inoremap <buffer> <Leader>aE afterEach(function()<Space>{<CR>});<Esc>O

" Markdown mappings
au FileType markdown inoremap <buffer> <Leader>sl <!SLIDE><Esc>FEa

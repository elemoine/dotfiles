" pathogen
call pathogen#runtime_append_all_bundles()

set autoindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set incsearch
set scrolloff=3

syntax on

map ** {!} par 70j<CR>
map *o {!} par 67j<CR>:/./,/^$/s/^/   /<CR>xx{jR o<ESC>
map *- {!} par 67j<CR>:/./,/^$/s/^/    /<CR>xx{jR  -<ESC>

map @o gqap{:/./,/^$/s/^/    /<CR>xx{jR o<ESC>
map ,< :s/^\(.*\)$/<!-- \1 -->/<CR><Esc>:nohlsearch<CR>

" http://github.com/hallettj/jslint.vim
map <F4> :JSLintLight<CR>
map <F5> :JSLint<CR>

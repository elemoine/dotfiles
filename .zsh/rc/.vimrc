set autoindent
set backspace=2
set incsearch
set scrolloff=3

" if has("gui_running")
"   set guifont=-Adobe-Courier-Medium-R-Normal--12-120-75-75-M-70-ISO8859-1
" endif

map ** {!} par 70j<CR>
map *o {!} par 67j<CR>:/./,/^$/s/^/   /<CR>xx{jR o<ESC>
map *- {!} par 67j<CR>:/./,/^$/s/^/    /<CR>xx{jR  -<ESC>

map @o gqap{:/./,/^$/s/^/    /<CR>xx{jR o<ESC>

syntax on

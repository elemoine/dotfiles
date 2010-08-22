set autoindent
"set backspace=2
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set incsearch
set scrolloff=3

syntax on

" if has("gui_running")
"   set guifont=-Adobe-Courier-Medium-R-Normal--12-120-75-75-M-70-ISO8859-1
" endif

map ** {!} par 70j<CR>
map *o {!} par 67j<CR>:/./,/^$/s/^/   /<CR>xx{jR o<ESC>
map *- {!} par 67j<CR>:/./,/^$/s/^/    /<CR>xx{jR  -<ESC>

map @o gqap{:/./,/^$/s/^/    /<CR>xx{jR o<ESC>
map ,< :s/^\(.*\)$/<!-- \1 -->/<CR><Esc>:nohlsearch<CR>

" http://github.com/hallettj/jslint.vim
" Run JSLint on the current file in simple mode when <F4> is pressed.
map <F4> :JSLintLight<CR>
" " Run JSLint on the current file with quickfix when <F5> is pressed.
map <F5> :JSLint<CR>

function! DoPrettyXML()
  " save the filetype so we can restore it later
  let l:origft = &ft
  set ft=
  " delete the xml header if it exists. This will
  " permit us to surround the document with fake tags
  " without creating invalid xml.
  1s/<?xml .*?>//e
  " insert fake tags around the entire document.
  " This will permit us to pretty-format excerpts of
  " XML that may contain multiple top-level elements.
  0put ='<PrettyXML>'
  $put ='</PrettyXML>'
  silent %!xmllint --format -
  " xmllint will insert an <?xml?> header. it's easy enough to delete
  " if you don't want it.
  " delete the fake tags
  2d
  $d
  " restore the 'normal' indentation, which is one extra level
  " too deep due to the extra tags we wrapped around the document.
  silent %<
  " back to home
  1
  " restore the filetype
  exe "set ft=" . l:origft
endfunction
command! PrettyXML call DoPrettyXML()

" https://neovim.io/doc/user/nvim.html#nvim-from-vim
set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath
source ~/.vimrc

" https://neovim.io/doc/user/provider.html#provider-python
let g:python3_host_prog = '~/.virtualenvs/main/bin/python'

lua require('lsp')

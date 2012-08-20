" Vim global plugin for loading directory-specific configuration files
" Last Change: 2010 Nov 13
" Maintainer: Tom Payne <vim@tompayne.org>
" License: This file is placed in the public domain.
" https://github.com/twpayne/vim-plugin-brnchcfg/blob/master/brnchcfg.vim

if exists("loaded_brnchcfg")
finish
endif
let loaded_brnchcfg = 1

let s:dir = getcwd()
while stridx(s:dir, $HOME) != -1
let s:fn = s:dir . "/vimrc"
if filereadable(s:fn)
execute "source " . s:fn
break
endif
let s:dir = strpart(s:dir, 0, strridx(s:dir, "/"))
endwhile

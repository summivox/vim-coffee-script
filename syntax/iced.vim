" Language:    IcedCoffeeScript
" Maintainer:  Mick Koch <kchmck@gmail.com>
" URL:         http://github.com/kchmck/vim-coffee-script
" License:     WTFPL

if exists('b:current_syntax') && b:current_syntax == 'iced'
  finish
endif

runtime! syntax/coffee.vim
unlet b:current_syntax

syn match coffeeAwait /\<\%(await\)\>/ display
hi def link coffeeAwait Special

syn match coffeeKeyword /\<\%(defer\|autocb\)\>/
syn match coffeeGlobal /\<\%(iced\)\>/ display

let b:current_syntax = 'iced'

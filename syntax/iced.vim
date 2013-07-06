" Language:    IcedCoffeeScript
" Maintainer:  Mick Koch <kchmck@gmail.com>
" URL:         http://github.com/kchmck/vim-coffee-script
" License:     WTFPL

if exists('b:current_syntax') && b:current_syntax == 'iced'
  finish
endif

runtime! syntax/coffee.vim
unlet b:current_syntax

syn match coffeeAwait /\<await\>/ display
hi def link coffeeAwait Special

syn match coffeeKeyword /\<\%(defer\|autocb\)\>/
syn match coffeeGlobal /\<iced\>/ display

" refresh coffeeAll (otherwise `await` within parens won't display correctly)
syn cluster coffeeAll contains=coffeeStatement,coffeeRepeat,coffeeConditional,
\                              coffeeException,coffeeKeyword,coffeeOperator,
\                              coffeeExtendedOp,coffeeSpecialOp,coffeeBoolean,
\                              coffeeGlobal,coffeeSpecialVar,coffeeSpecialIdent,
\                              coffeeObject,coffeeConstant,coffeeString,
\                              coffeeNumber,coffeeFloat,coffeeReservedError,
\                              coffeeObjAssign,coffeeComment,coffeeBlockComment,
\                              coffeeEmbed,coffeeRegex,coffeeHeregex,
\                              coffeeHeredoc,coffeeSpaceError,
\                              coffeeSemicolonError,coffeeDotAccess,
\                              coffeeProtoAccess,coffeeCurlies,coffeeBrackets,
\                              coffeeParens,coffeeAwait


let b:current_syntax = 'iced'

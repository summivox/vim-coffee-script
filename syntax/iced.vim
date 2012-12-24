" Language:    IcedCoffeeScript
" Maintainer:  Mick Koch <kchmck@gmail.com>
" URL:         http://github.com/kchmck/vim-coffee-script
" License:     WTFPL

" Bail if our syntax is already loaded.
if exists('b:current_syntax') && b:current_syntax == 'iced'
  finish
endif

" Include JavaScript for icedEmbed.
syn include @icedJS syntax/javascript.vim

" Highlight long strings.
syn sync minlines=100

" CoffeeScript identifiers can have dollar signs.
setlocal isident+=$

" These are `matches` instead of `keywords` because vim's highlighting
" priority for keywords is higher than matches. This causes keywords to be
" highlighted inside matches, even if a match says it shouldn't contain them --
" like with icedAssign and icedDot.
syn match icedAwait /\<\%(await\)\>/ display
hi def link icedAwait Special

syn match icedStatement /\<\%(return\|break\|continue\|throw\)\>/ display
hi def link icedStatement Statement

syn match icedRepeat /\<\%(for\|while\|until\|loop\)\>/ display
hi def link icedRepeat Repeat

syn match icedConditional /\<\%(if\|else\|unless\|switch\|when\|then\)\>/
\                           display
hi def link icedConditional Conditional

syn match icedException /\<\%(try\|catch\|finally\)\>/ display
hi def link icedException Exception

syn match icedKeyword /\<\%(new\|in\|of\|by\|and\|or\|not\|is\|isnt\|class\|extends\|super\|do\|defer\|autocb\)\>/
\                       display
" The `own` keyword is only a keyword after `for`.
syn match icedKeyword /\<for\s\+own\>/ contained containedin=icedRepeat
\                       display
hi def link icedKeyword Keyword

syn match icedOperator /\<\%(instanceof\|typeof\|delete\)\>/ display
hi def link icedOperator Operator

" The first case matches symbol operators only if they have an operand before.
syn match icedExtendedOp /\%(\S\s*\)\@<=[+\-*/%&|\^=!<>?.]\{-1,}\|[-=]>\|--\|++\|:/
\                          display
syn match icedExtendedOp /\<\%(and\|or\)=/ display
hi def link icedExtendedOp icedOperator

" This is separate from `icedExtendedOp` to help differentiate commas from
" dots.
syn match icedSpecialOp /[,;]/ display
hi def link icedSpecialOp SpecialChar

syn match icedBoolean /\<\%(true\|on\|yes\|false\|off\|no\)\>/ display
hi def link icedBoolean Boolean

syn match icedGlobal /\<\%(null\|undefined\|iced\)\>/ display
hi def link icedGlobal Type

" A special variable
syn match icedSpecialVar /\<\%(this\|prototype\|arguments\)\>/ display
hi def link icedSpecialVar Special

" An @-variable
syn match icedSpecialIdent /@\%(\I\i*\)\?/ display
hi def link icedSpecialIdent Identifier

" A class-like name that starts with a capital letter
syn match icedObject /\<\u\w*\>/ display
hi def link icedObject Structure

" A constant-like name in SCREAMING_CAPS
syn match icedConstant /\<\u[A-Z0-9_]\+\>/ display
hi def link icedConstant Constant

" A variable name
syn cluster icedIdentifier contains=icedSpecialVar,icedSpecialIdent,
\                                     icedObject,icedConstant

" A non-interpolated string
syn cluster icedBasicString contains=@Spell,icedEscape
" An interpolated string
syn cluster icedInterpString contains=@icedBasicString,icedInterp

" Regular strings
syn region icedString start=/"/ skip=/\\\\\|\\"/ end=/"/
\                       contains=@icedInterpString
syn region icedString start=/'/ skip=/\\\\\|\\'/ end=/'/
\                       contains=@icedBasicString
hi def link icedString String

" A integer, including a leading plus or minus
syn match icedNumber /\i\@<![-+]\?\d\+\%([eE][+-]\?\d\+\)\?/ display
" A hex, binary, or octal number
syn match icedNumber /\<0[xX]\x\+\>/ display
syn match icedNumber /\<0[bB][01]\+\>/ display
syn match icedNumber /\<0[oO][0-7]\+\>/ display
hi def link icedNumber Number

" A floating-point number, including a leading plus or minus
syn match icedFloat /\i\@<![-+]\?\d*\.\@<!\.\d\+\%([eE][+-]\?\d\+\)\?/
\                     display
hi def link icedFloat Float

" An error for reserved keywords
if !exists("iced_no_reserved_words_error")
  syn match icedReservedError /\<\%(case\|default\|function\|var\|void\|with\|const\|let\|enum\|export\|import\|native\|__hasProp\|__extends\|__slice\|__bind\|__indexOf\|implements\|interface\|let\|package\|private\|protected\|public\|static\|yield\)\>/
  \                             display
  hi def link icedReservedError Error
endif

" A normal object assignment
syn match icedObjAssign /@\?\I\i*\s*\ze::\@!/ contains=@icedIdentifier display
hi def link icedObjAssign Identifier

syn keyword icedTodo TODO FIXME XXX contained
hi def link icedTodo Todo

syn match icedComment /#.*/ contains=@Spell,icedTodo
hi def link icedComment Comment

syn region icedBlockComment start=/####\@!/ end=/###/
\                             contains=@Spell,icedTodo
hi def link icedBlockComment icedComment

" A comment in a heregex
syn region icedHeregexComment start=/#/ end=/\ze\/\/\/\|$/ contained
\                               contains=@Spell,icedTodo
hi def link icedHeregexComment icedComment

" Embedded JavaScript
syn region icedEmbed matchgroup=icedEmbedDelim
\                      start=/`/ skip=/\\\\\|\\`/ end=/`/
\                      contains=@icedJS
hi def link icedEmbedDelim Delimiter

syn region icedInterp matchgroup=icedInterpDelim start=/#{/ end=/}/ contained
\                       contains=@icedAll
hi def link icedInterpDelim Operator

" A string escape sequence
syn match icedEscape /\\\d\d\d\|\\x\x\{2\}\|\\u\x\{4\}\|\\./ contained display
hi def link icedEscape SpecialChar

" A regex -- must not follow a parenthesis, number, or identifier, and must not
" be followed by a number
syn region icedRegex start=/\%(\%()\|\i\@<!\d\)\s*\|\i\)\@<!\/=\@!\s\@!/
\                      skip=/\[[^\]]\{-}\/[^\]]\{-}\]/
\                      end=/\/[gimy]\{,4}\d\@!/
\                      oneline contains=@icedBasicString
hi def link icedRegex String

" A heregex
syn region icedHeregex start=/\/\/\// end=/\/\/\/[gimy]\{,4}/
\                        contains=@icedInterpString,icedHeregexComment
\                        fold
hi def link icedHeregex icedRegex

" Heredoc strings
syn region icedHeredoc start=/"""/ end=/"""/ contains=@icedInterpString
\                        fold
syn region icedHeredoc start=/'''/ end=/'''/ contains=@icedBasicString
\                        fold
hi def link icedHeredoc String

" An error for trailing whitespace, as long as the line isn't just whitespace
if !exists("iced_no_trailing_space_error")
  syn match icedSpaceError /\S\@<=\s\+$/ display
  hi def link icedSpaceError Error
endif

" An error for trailing semicolons, for help transitioning from JavaScript
if !exists("iced_no_trailing_semicolon_error")
  syn match icedSemicolonError /;$/ display
  hi def link icedSemicolonError Error
endif

" Ignore reserved words in dot accesses.
syn match icedDotAccess /\.\@<!\.\s*\I\i*/he=s+1 contains=@icedIdentifier
hi def link icedDotAccess icedExtendedOp

" Ignore reserved words in prototype accesses.
syn match icedProtoAccess /::\s*\I\i*/he=s+2 contains=@icedIdentifier
hi def link icedProtoAccess icedExtendedOp

" This is required for interpolations to work.
syn region icedCurlies matchgroup=icedCurly start=/{/ end=/}/
\                        contains=@icedAll
syn region icedBrackets matchgroup=icedBracket start=/\[/ end=/\]/
\                         contains=@icedAll
syn region icedParens matchgroup=icedParen start=/(/ end=/)/
\                       contains=@icedAll

" These are highlighted the same as commas since they tend to go together.
hi def link icedBlock icedSpecialOp
hi def link icedBracket icedBlock
hi def link icedCurly icedBlock
hi def link icedParen icedBlock

" This is used instead of TOP to keep things coffee-specific for good
" embedding. `contained` groups aren't included.
syn cluster icedAll contains=icedStatement,icedRepeat,icedConditional,
\                              icedException,icedKeyword,icedOperator,
\                              icedExtendedOp,icedSpecialOp,icedBoolean,
\                              icedGlobal,icedSpecialVar,icedSpecialIdent,
\                              icedObject,icedConstant,icedString,
\                              icedNumber,icedFloat,icedReservedError,
\                              icedObjAssign,icedComment,icedBlockComment,
\                              icedEmbed,icedRegex,icedHeregex,
\                              icedHeredoc,icedSpaceError,
\                              icedSemicolonError,icedDotAccess,
\                              icedProtoAccess,icedCurlies,icedBrackets,
\                              icedParens

if !exists('b:current_syntax')
  let b:current_syntax = 'iced'
endif

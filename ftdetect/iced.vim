" Language:    IcedCoffeeScript
" Maintainer:  Mick Koch <kchmck@gmail.com>
" URL:         http://github.com/kchmck/vim-coffee-script
" License:     WTFPL

autocmd BufNewFile,BufRead *.iced set filetype=iced

function! s:DetectIcedCoffee()
    if getline(1) =~ '^#!.*\<iced\>'
        set filetype=iced
    endif
endfunction

autocmd BufNewFile,BufRead * call s:DetectIcedCoffee()

if !exists("mapleader")
    let mapleader = " "
endif

nnoremap <leader>g :set operatorfunc=<SID>grep_operator<cr>g@
vnoremap <leader>g :<c-u> call <SID>grep_operator(visualmode())<cr>

function! s:grep_operator(type)
    let old_reg = @@ " Unnamed register

    if a:type ==# "v"
        execute "normal! `<v`>y"
    elseif a:type ==# "char"
        execute "normal! `[v`]y"
    else
        return
    endif

    execute "grep! " . shellescape(@@) . " ."
    copen

    let @@ = old_reg " Replace old content
endfunction

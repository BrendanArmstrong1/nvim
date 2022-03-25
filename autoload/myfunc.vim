function! myfunc#ExecuteStuff(location) abort
    w
    let l:name=expand('%:p')
    let l:exte=expand('%:e')
    if !term_list()->len()
        if l:exte == 'tex' || l:exte == 'html' || l:exte == 'css'
            ter ++hidden
        elseif l:exte == 'js'
            let l:path=expand('%:p:h')
            if glob(l:path . "/index.html") != ""
                ter ++hidden
            else
                if a:location == 'right'
                    vert ter
                else
                    ter
                endif
                call feedkeys("\<C-w>h")
            endif
        else
            if a:location == 'right'
                vert ter
            else
                ter
            endif
            call feedkeys("\<C-w>h")
        endif
    endif
    call term_sendkeys(term_list()[0], "clear && compiler " . myfunc#Quoterepl(l:name) . "\<CR>")
endfunction

function! myfunc#Quoterepl(name) abort
    let l:len=len(a:name)
    for i in range(l:len)
        if a:name[i] == "\'"
            return strpart(a:name,0,i) . "\\" . strpart(a:name, i,l:len)
        endif
    endfor
    return a:name
endfunction

function! myfunc#Resize_Execution_Term(amount) abort
    if term_list()->len()
        let l:size=term_getsize(term_list()[0])
        call term_setsize(term_list()[0],l:size[0],l:size[1] + a:amount)
    endif
endfunction

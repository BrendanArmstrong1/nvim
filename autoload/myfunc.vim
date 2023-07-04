function! myfunc#ExecuteStuff(location) abort
    w
    let l:name=expand('%:p')
    let l:exte=expand('%:e')
    let l:list = getbufinfo({'buflisted': 1, 'bufloaded': 1})
    for item in l:list
      if item.name =~ 'term://'
        let l:id = item.variables.terminal_job_id
        call chansend(l:id, "clear && compiler " . myfunc#Quoterepl(l:name) . "\n")
        return
      endif
    endfor
    if l:exte == 'tex' || l:exte == 'html' || l:exte == 'css'
      call jobstart(["bash", "-c", "compiler " .. l:name])
      return
    elseif l:exte == 'js'
        let l:path=expand('%:p:h')
        if glob(l:path . "/index.html") != ""
          call jobstart(["bash", "-c", "compiler " .. l:name])
          return
        else
            if a:location == 'right'
              vs +te
              call feedkeys("\<C-w>\<C-w>")
            else
                sp +te
                call feedkeys("\<C-w>\<C-w>")
            endif
        endif
    else
        if a:location == 'right'
            vs +te
            call feedkeys("\<C-w>\<C-w>")
        else
            sp +te
            call feedkeys("\<C-w>\<C-w>")
        endif
    endif
    let l:list = getbufinfo({'buflisted': 1, 'bufloaded': 1})
    for item in l:list
      if item.name =~ 'term://'
        let l:id = item.variables.terminal_job_id
        call chansend(l:id, "clear && compiler " . myfunc#Quoterepl(l:name) . "\n")
        return
      endif
    endfor
endfunction

function! myfunc#CloseTerm() abort
    let l:list = getbufinfo({'buflisted': 1, 'bufloaded': 1})
    for item in l:list
      if item.name =~ 'term://'
        execute "bd! " .. item.name
      endif
    endfor
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

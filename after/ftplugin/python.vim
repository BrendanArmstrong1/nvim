setlocal include=^\\s*\\(from\\\|import\\)\\s*\\zs\\(\\S\\+\\s\\{-}\\)*\\ze\\($\\\|\ as\\)
setlocal wildignore=*.pyc,*/__pycache__/*
setlocal suffixesadd=.py,/__init__.py
setlocal omnifunc=lsp#complete


function! PyInclude(fname)
    let parts = split(a:fname, ' import ')
    let l = parts[0]
    if len(parts) > 1
        let r = parts[1]
        let joined = join([l,r], '.')
        let fp = substitute(joined, '\.', '/', 'g') . '.py'
        let found = glob(fp, 1)
        if len(found)
            return found
        endif
    endif
    let fp = substitute(l, '\.', '/', 'g') . '.py'
    return fp
endfunction


setlocal includeexpr=PyInclude(v:fname)

let g:ale_linters = { 'python': [ 'flake8', 'pylint' ] }
let g:ale_fix_on_save = 1
let g:ale_fixers = {
      \   '*': ['remove_trailing_lines', 'trim_whitespace'],
      \ 'python': ['black'],
      \}

let s:recent_files = []
let s:recent_lines = []

function! backtrack#file#Set() abort
    let i = 1
    for file in v:oldfiles
        if filereadable(file)
            call add(s:recent_files, file)
            call add(s:recent_lines, printf('   [%d]  %s', i % 10, fnamemodify(file, ':~')))
            let i += 1
        endif
        if i > 10 | break | endif
    endfor
endfunction

function! backtrack#file#Print() abort
    call append(line('$'), s:recent_lines)
    for idx in range(len(s:recent_files))
        let key = (idx + 1) % 10
        execute printf("nnoremap <buffer> %d :call backtrack#file#Navigate(%d)<CR>", key, idx)
    endfor
endfunction

function! backtrack#file#Reset() abort
    let s:recent_files = []
    let s:recent_lines = []

    let lnum = search('^\s*\[1\]\s', 'nw')
    if lnum > 0
        execute lnum . ',$delete _'
    endif
endfunction

function! backtrack#file#Display() abort
    setlocal modifiable

    call backtrack#buffer#Get()
    call backtrack#file#Reset()
    call backtrack#file#Set()
    call backtrack#file#Print()

    setlocal nomodifiable
endfunction

function! backtrack#file#Navigate(index) abort
    if exists('s:recent_files') && a:index < len(s:recent_files)
        execute 'edit ' . fnameescape(s:recent_files[a:index])
    endif
endfunction

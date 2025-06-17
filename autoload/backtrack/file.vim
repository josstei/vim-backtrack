let s:recent_files      = []
let s:recent_lines      = []
let s:default_max_count = 10
let s:max_count         = get(g:, 'backtrack_max_count', s:default_max_count)

if s:max_count > 50
  let s:max_count = 50
endif

function! backtrack#file#Set() abort
    let l:i = 1
    for l:file in v:oldfiles
        let l:absfile = fnamemodify(l:file, ':p')
        if filereadable(l:absfile)
            call add(s:recent_files, l:absfile)
            call add(s:recent_lines, printf('   [%02d]  %s', l:i, fnamemodify(l:absfile, ':~')))
            let l:i += 1
        endif
        if l:i > s:max_count | break | endif
    endfor
endfunction

function! backtrack#file#Print() abort
    call append(line('$'), s:recent_lines)
    for l:idx in range(len(s:recent_files))
        if l:idx < 9
            let l:key = printf('%d', l:idx + 1)
        else
            let l:key = printf('%02d', l:idx + 1)
        endif
        execute printf("nnoremap <buffer> %s :call backtrack#file#Navigate(%d)<CR>", l:key, l:idx)
    endfor
endfunction

function! backtrack#file#Reset() abort
    let s:recent_files = []
    let s:recent_lines = []

    let lnum = search('^\s*\[01\]\s', 'nw')
    if lnum > 0
        execute lnum . ',$delete _'
    endif
endfunction

function! backtrack#file#Display() abort
    setlocal modifiable

    call backtrack#file#Reset()
    call backtrack#buffer#Get()
    call backtrack#file#Set()
    call backtrack#file#Print()

    setlocal nomodifiable
endfunction

function! backtrack#file#Navigate(index) abort
    if exists('s:recent_files') && a:index < len(s:recent_files)
        setlocal modifiable
        call backtrack#buffer#Previous()

        execute 'edit ' . fnameescape(s:recent_files[a:index])

        call backtrack#buffer#Close()
        call backtrack#buffer#Previous()

        unlet! g:backtrack_prev_winid
        unlet! g:backtrack_list_winid
    endif
endfunction

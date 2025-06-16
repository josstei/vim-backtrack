let s:recent_files      = []
let s:recent_lines      = []
let s:default_max_count = 10
let s:max_count         = get(g:, 'backtrack_max_count', s:default_max_count)

if s:max_count > 50
  let s:max_count = 50
endif

function! backtrack#file#Set() abort
    let i = 1
    for file in v:oldfiles
        if filereadable(file)
            call add(s:recent_files, file)
            call add(s:recent_lines, printf('   [%02d]  %s', i, fnamemodify(file, ':~')))
            let i += 1
        endif
        if i > s:max_count | break | endif
    endfor
endfunction

function! backtrack#file#Print() abort
    call append(line('$'), s:recent_lines)
    let count = len(s:recent_files)
    for idx in range(count)
        if idx < 9
            let key = printf('%d', idx + 1)
        else
            let key = printf('%02d', idx + 1)
        endif
        execute printf("nnoremap <buffer> %s :call backtrack#file#Navigate(%d)<CR>", key, idx)
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

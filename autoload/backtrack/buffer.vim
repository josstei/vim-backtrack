function! backtrack#buffer#Get() abort
    try
        if exists('g:backtrack_split') && !empty(g:backtrack_split)
            let g:backtrack_prev_winid = win_getid()
            call backtrack#buffer#Set()
        endif
    catch /.*/
        echoerr v:exception
    endtry
endfunction

function! backtrack#buffer#Set() abort
    execute g:backtrack_split
    enew
    setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile
    file [Backtrack List]
    let g:backtrack_winid= win_getid()
endfunction

function! backtrack#buffer#Close() abort
    if exists('g:backtrack_winid') && win_gotoid(g:backtrack_winid)
        close
    endif
endfunction

function! backtrack#buffer#Previous() abort
    return exists('g:backtrack_prev_winid') && win_gotoid(g:backtrack_prev_winid)
endfunction

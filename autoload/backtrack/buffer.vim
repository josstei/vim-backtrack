function! backtrack#buffer#Get() abort
    try
        if exists('g:backtrack_split') && !empty(g:backtrack_split)
            execute g:backtrack_split
            call backtrack#buffer#Set()
        endif
        return
    catch /.*/
        echoerr v:exception
    endtry
endfunction

function! backtrack#buffer#Set() abort
    enew
    setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile
    file [Backtrack List]
endfunction

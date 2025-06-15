let s:allowed_splits = [
      \ '',
      \ 'split',
      \ 'vsplit',
      \ 'botright split',
      \ 'botright vsplit',
      \ 'topleft split',
      \ 'topleft vsplit',
      \ 'aboveleft split',
      \ 'aboveleft vsplit',
      \ 'belowright split',
      \ 'belowright vsplit'
      \ ]

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
    let l:split_cmd = exists('g:backtrack_split') ? g:backtrack_split : ''

    if index(s:allowed_splits, l:split_cmd) != -1
        if l:split_cmd !=# ''
            execute l:split_cmd
        endif
        enew
        setlocal buftype=nofile bufhidden=wipe nobuflisted noswapfile
        file [Backtrack List]
        let g:backtrack_winid = win_getid()
    else
        echoerr 'Invalid value for g:backtrack_split: "' . l:split_cmd . '"'
        return
    endif
endfunction

function! backtrack#buffer#Close() abort
    if exists('g:backtrack_winid') && win_gotoid(g:backtrack_winid)
        close
    endif
endfunction

function! backtrack#buffer#Previous() abort
    return exists('g:backtrack_prev_winid') && win_gotoid(g:backtrack_prev_winid)
endfunction

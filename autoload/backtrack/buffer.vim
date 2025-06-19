let s:allowed_splits = [
      \ '',
      \ 'split',            'vsplit',
      \ 'botright split',   'botright vsplit',
      \ 'topleft split',    'topleft vsplit',
      \ 'aboveleft split',  'aboveleft vsplit',
      \ 'belowright split', 'belowright vsplit'
      \ ]

function! backtrack#buffer#Get() abort
    try
        let g:backtrack_prev_winid = win_getid()
        call backtrack#buffer#Split()
    catch /.*/
        echoerr v:exception
    endtry
endfunction

function! backtrack#buffer#Set(...) abort
    if a:0 > 0
        let l:split_cmd = a:1
    else
        let l:split_cmd = exists('g:backtrack_split') ? g:backtrack_split : ''
    endif

    if index(s:allowed_splits, l:split_cmd) != -1
        if l:split_cmd !=# ''
            execute l:split_cmd
            enew
            setlocal buftype=nofile
            setlocal bufhidden=wipe
            setlocal nobuflisted
            setlocal noswapfile
            setlocal nonumber norelativenumber
            setlocal signcolumn=no
            setlocal foldcolumn=0
            setlocal nocursorline
            setlocal modifiable
            setlocal filetype=easydash
            setlocal filetype=backtrack
            file [Backtrack List]
            let g:backtrack_winid = win_getid()
        endif
    else
        echoerr 'Invalid value for split command: "' . l:split_cmd . '"'
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

function! backtrack#buffer#Split() abort
    let l:alternate_split_types   = get(g:, 'backtrack_alternate_split_types', [])
    let l:alternate_split         = get(g:, 'backtrack_alternate_split', '')

    if index(l:alternate_split_types, &filetype) >= 0 
        let l:split_cmd = l:alternate_split
    else
        let l:split_cmd = exists('g:backtrack_split') ? g:backtrack_split : ''
    endif
    call backtrack#buffer#Set(l:split_cmd)
endfunction

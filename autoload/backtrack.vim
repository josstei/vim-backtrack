if exists('g:backtrack_core_loaded')
    finish
endif

let g:backtrack_core_loaded=1

function! backtrack#Execute() abort
    call backtrack#file#Display()
endfunction


if exists('g:backtrack_loaded') | finish | endif

if !exists('g:backtrack_split')
    let g:backtrack_split='split'
endif

let g:backtrack_loaded= 1

command! Backtrack call backtrack#Execute()

